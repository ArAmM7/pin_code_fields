import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'gestures/context_menu_builder.dart';
import 'gestures/selection_gesture_builder.dart';
import 'haptics.dart';
import 'input_capture/invisible_text_field.dart';
import 'pin_cell_data.dart';
import 'pin_input_scope.dart';

/// Builder function for custom PIN cell rendering.
typedef PinCellBuilder = Widget Function(
  BuildContext context,
  List<PinCellData> cells,
);

/// Headless PIN input widget.
///
/// This widget captures keyboard input and manages PIN state but delegates
/// ALL visual rendering to the provided [builder]. You decide exactly how
/// each cell should look - this widget just provides the data.
///
/// Example:
/// ```dart
/// PinInput(
///   length: 6,
///   builder: (context, cells) {
///     return Row(
///       children: cells.map((cell) => MyCustomCell(data: cell)).toList(),
///     );
///   },
///   onCompleted: (pin) => print('PIN: $pin'),
/// )
/// ```
class PinInput extends StatefulWidget {
  const PinInput({
    super.key,
    required this.length,
    required this.builder,
    // Controller
    this.controller,
    this.focusNode,
    // Input behavior
    this.keyboardType = TextInputType.number,
    this.textInputAction = TextInputAction.done,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    // Behavior
    this.autoFocus = false,
    this.readOnly = false,
    this.autoDismissKeyboard = true,
    this.obscureText = false,
    this.obscuringCharacter = '●',
    this.blinkWhenObscuring = true,
    this.blinkDuration = const Duration(milliseconds: 500),
    // Haptics
    this.enableHapticFeedback = true,
    this.hapticFeedbackType = HapticFeedbackType.light,
    // Gestures
    this.enablePaste = true,
    this.selectionControls,
    this.contextMenuBuilder = defaultPinContextMenuBuilder,
    // Callbacks
    this.onChanged,
    this.onCompleted,
    this.onSubmitted,
    this.onEditingComplete,
    this.onTap,
    // Error
    this.errorTrigger,
    // Keyboard
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20),
    // Autofill
    this.enableAutofill = false,
    this.autofillContextAction = AutofillContextAction.commit,
  })  : assert(length > 0, 'Length must be greater than 0'),
        assert(
          obscuringCharacter.length > 0,
          'Obscuring character must not be empty',
        );

  /// Number of PIN cells.
  final int length;

  /// Builder that receives cell data and returns the visual representation.
  ///
  /// This is where YOU decide how to render each cell. The builder receives
  /// a list of [PinCellData] objects containing all the state information
  /// needed to render each cell.
  final PinCellBuilder builder;

  /// Controller for the text input.
  ///
  /// If not provided, an internal controller will be created and managed.
  final TextEditingController? controller;

  /// Focus node for managing keyboard focus.
  ///
  /// If not provided, an internal focus node will be created and managed.
  final FocusNode? focusNode;

  /// The type of keyboard to display.
  final TextInputType keyboardType;

  /// The action button to display on the keyboard.
  final TextInputAction textInputAction;

  /// Additional input formatters to apply.
  final List<TextInputFormatter>? inputFormatters;

  /// How to capitalize text input.
  final TextCapitalization textCapitalization;

  /// Autofill hints for the text field.
  final Iterable<String>? autofillHints;

  /// Whether to auto-focus on mount.
  final bool autoFocus;

  /// Whether the field is read-only.
  final bool readOnly;

  /// Whether to dismiss the keyboard when PIN is complete.
  final bool autoDismissKeyboard;

  /// Whether to obscure the entered text.
  final bool obscureText;

  /// Character used to obscure text.
  final String obscuringCharacter;

  /// Whether to briefly show the character before obscuring.
  final bool blinkWhenObscuring;

  /// Duration to show the character before obscuring.
  final Duration blinkDuration;

  /// Whether to trigger haptic feedback on input.
  final bool enableHapticFeedback;

  /// Type of haptic feedback to trigger.
  final HapticFeedbackType hapticFeedbackType;

  /// Whether to enable paste functionality.
  final bool enablePaste;

  /// Custom text selection controls.
  final TextSelectionControls? selectionControls;

  /// Builder for the context menu (paste functionality).
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// Called when the text changes.
  final ValueChanged<String>? onChanged;

  /// Called when the PIN is complete (all cells filled).
  final ValueChanged<String>? onCompleted;

  /// Called when the user submits (keyboard action button).
  final ValueChanged<String>? onSubmitted;

  /// Called when editing is complete.
  final VoidCallback? onEditingComplete;

  /// Called when the widget is tapped.
  final VoidCallback? onTap;

  /// Stream to trigger error state.
  ///
  /// Emit `null` to clear error state, or emit any value to set error state.
  final Stream<void>? errorTrigger;

  /// The brightness of the keyboard.
  final Brightness? keyboardAppearance;

  /// Padding when scrolling the field into view.
  final EdgeInsets scrollPadding;

  /// Whether to enable autofill (e.g., SMS OTP autofill).
  ///
  /// When enabled, the system may automatically fill in OTP codes
  /// received via SMS or suggest saved PINs/passwords.
  final bool enableAutofill;

  /// Action to perform when the autofill context is disposed.
  ///
  /// - [AutofillContextAction.commit]: Tell the system to save the data
  ///   (useful for password managers to save PINs/passwords)
  /// - [AutofillContextAction.cancel]: Tell the system to discard the data
  ///   (appropriate for one-time codes like OTP)
  final AutofillContextAction autofillContextAction;

  @override
  State<PinInput> createState() => _PinInputState();
}

class _PinInputState extends State<PinInput>
    with TickerProviderStateMixin
    implements TextSelectionGestureDetectorBuilderDelegate {
  // Constants
  static const _fallbackFocusDelay = Duration(milliseconds: 50);

  // Controllers
  TextEditingController? _controller;
  FocusNode? _focusNode;

  // Gesture handling
  late TextSelectionGestureDetectorBuilder _gestureBuilder;

  // Delegate properties
  @override
  final GlobalKey<EditableTextState> editableTextKey =
      GlobalKey<EditableTextState>();

  @override
  bool get selectionEnabled => widget.enablePaste && !widget.readOnly;

  @override
  bool get forcePressEnabled => false;

  // State
  bool _isError = false;
  int _previousLength = 0;
  final Set<int> _justEnteredIndices = {};
  final Set<int> _justRemovedIndices = {};

  // Blink effect
  Timer? _blinkTimer;
  bool _isBlinking = false;

  // Error subscription
  StreamSubscription<void>? _errorSubscription;

  TextEditingController get _effectiveController => _controller!;
  FocusNode get _effectiveFocusNode => _focusNode!;

  @override
  void initState() {
    super.initState();
    _initController();
    _initFocusNode();
    _gestureBuilder = TextSelectionGestureDetectorBuilder(delegate: this);
    _subscribeToErrors();
    _handleAutoFocus();
  }

  void _initController() {
    _controller = widget.controller ?? TextEditingController();
    _controller!.addListener(_onTextChanged);

    // Ensure initial text doesn't exceed length
    final initialText = _getLimitedText(_controller!.text);
    if (initialText != _controller!.text) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller!.text = initialText;
        }
      });
    }

    _previousLength = _controller!.text.length;
  }

  void _initFocusNode() {
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode!.addListener(_onFocusChanged);
  }

  void _subscribeToErrors() {
    _errorSubscription?.cancel();
    if (widget.errorTrigger != null) {
      _errorSubscription = widget.errorTrigger!.listen((_) {
        if (mounted) {
          setState(() => _isError = true);
        }
      });
    }
  }

  void _handleAutoFocus() {
    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_effectiveFocusNode.hasFocus) {
          _requestFocusSafely();
        }
      });
    }

    // Set initial selection
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _effectiveController.selection = TextSelection.collapsed(
          offset: _effectiveController.text.length,
        );
      }
    });
  }

  @override
  void didUpdateWidget(covariant PinInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Controller change
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_onTextChanged);
      _controller?.removeListener(_onTextChanged);
      if (oldWidget.controller == null) {
        _controller?.dispose();
      }
      _initController();
    }

    // Focus node change
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode?.removeListener(_onFocusChanged);
      if (oldWidget.focusNode == null) {
        _focusNode?.dispose();
      }
      _initFocusNode();
    }

    // Length change
    if (widget.length != oldWidget.length) {
      _onTextChanged();
    }

    // Error stream change
    if (widget.errorTrigger != oldWidget.errorTrigger) {
      _subscribeToErrors();
    }
  }

  @override
  void dispose() {
    _errorSubscription?.cancel();
    _blinkTimer?.cancel();
    _controller?.removeListener(_onTextChanged);
    if (widget.controller == null) {
      _controller?.dispose();
    }
    _focusNode?.removeListener(_onFocusChanged);
    if (widget.focusNode == null) {
      _focusNode?.dispose();
    }
    super.dispose();
  }

  void _requestFocusSafely() {
    if (mounted && _effectiveFocusNode.context != null) {
      FocusScope.of(context).requestFocus(_effectiveFocusNode);
    } else if (mounted) {
      Future.delayed(_fallbackFocusDelay, () {
        if (mounted && _effectiveFocusNode.context != null) {
          FocusScope.of(context).requestFocus(_effectiveFocusNode);
        }
      });
    }
  }

  void _onFocusChanged() {
    if (!_effectiveFocusNode.hasFocus) {
      editableTextKey.currentState?.hideToolbar();
    }
    if (mounted) setState(() {});
  }

  void _onTextChanged() {
    if (!mounted) return;

    // Haptic feedback
    if (widget.enableHapticFeedback) {
      triggerHaptic(widget.hapticFeedbackType);
    }

    // Clear error on input
    if (_isError) {
      setState(() => _isError = false);
    }

    final currentText = _effectiveController.text;
    final limitedText = _getLimitedText(currentText);

    // Correct text if needed
    if (currentText != limitedText) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _effectiveController.value = TextEditingValue(
            text: limitedText,
            selection: TextSelection.collapsed(offset: limitedText.length),
          );
        }
      });
      return;
    }

    final currentLength = limitedText.length;

    // Track transition signals
    _updateTransitionSignals(currentLength);

    // Callbacks
    widget.onChanged?.call(limitedText);

    // Completion check
    if (currentLength == widget.length && _previousLength < widget.length) {
      widget.onCompleted?.call(limitedText);
      if (widget.autoDismissKeyboard) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    }

    _previousLength = currentLength;

    // Blink effect
    _handleBlinkEffect();

    setState(() {});
  }

  void _updateTransitionSignals(int currentLength) {
    _justEnteredIndices.clear();
    _justRemovedIndices.clear();

    if (currentLength > _previousLength) {
      // Characters were entered
      for (int i = _previousLength; i < currentLength; i++) {
        _justEnteredIndices.add(i);
      }
    } else if (currentLength < _previousLength) {
      // Characters were removed
      for (int i = currentLength; i < _previousLength; i++) {
        _justRemovedIndices.add(i);
      }
    }

    // Clear transition signals after one frame
    if (_justEnteredIndices.isNotEmpty || _justRemovedIndices.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _justEnteredIndices.clear();
            _justRemovedIndices.clear();
          });
        }
      });
    }
  }

  void _handleBlinkEffect() {
    if (!widget.obscureText || !widget.blinkWhenObscuring) return;

    _blinkTimer?.cancel();
    _isBlinking = true;

    _blinkTimer = Timer(widget.blinkDuration, () {
      if (mounted) {
        setState(() => _isBlinking = false);
      }
    });
  }

  String _getLimitedText(String text) {
    String filteredText = text;
    if (widget.keyboardType == TextInputType.number) {
      filteredText = text.replaceAll(RegExp(r'[^0-9]'), '');
    }
    return filteredText.length > widget.length
        ? filteredText.substring(0, widget.length)
        : filteredText;
  }

  void _handleSelectionChanged(
    TextSelection selection,
    SelectionChangedCause? cause,
  ) {
    if (widget.readOnly) return;
    // Force selection to end
    if (_effectiveController.selection.baseOffset !=
            _effectiveController.text.length ||
        _effectiveController.selection.extentOffset !=
            _effectiveController.text.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _effectiveController.selection = TextSelection.collapsed(
            offset: _effectiveController.text.length,
          );
        }
      });
    }
  }

  List<PinCellData> _buildCells() {
    final text = _effectiveController.text;
    final cells = <PinCellData>[];

    for (int i = 0; i < widget.length; i++) {
      final isFilled = i < text.length;
      final isFocused = _effectiveFocusNode.hasFocus && i == text.length;
      final isLastEntered = i == text.length - 1 && text.isNotEmpty;

      cells.add(PinCellData(
        index: i,
        character: isFilled ? text[i] : null,
        isFilled: isFilled,
        isFocused: isFocused,
        isError: _isError,
        isDisabled: widget.readOnly,
        wasJustEntered: _justEnteredIndices.contains(i),
        wasJustRemoved: _justRemovedIndices.contains(i),
        isBlinking: widget.obscureText &&
            widget.blinkWhenObscuring &&
            isLastEntered &&
            _isBlinking,
      ));
    }

    return cells;
  }

  @override
  Widget build(BuildContext context) {
    final cells = _buildCells();
    final selectionControls = widget.selectionControls ??
        (selectionEnabled ? getDefaultSelectionControls(context) : null);

    Widget content = GestureDetector(
      onTap: () {
        if (!_effectiveFocusNode.hasFocus && !widget.readOnly) {
          _requestFocusSafely();
        }
        widget.onTap?.call();
      },
      child: _gestureBuilder.buildGestureDetector(
        behavior: HitTestBehavior.translucent,
        child: PinInputScope(
          cells: cells,
          obscureText: widget.obscureText,
          obscuringCharacter: widget.obscuringCharacter,
          hasFocus: _effectiveFocusNode.hasFocus,
          requestFocus: _requestFocusSafely,
          child: Stack(
            children: [
              // User's custom UI
              widget.builder(context, cells),

              // Invisible input layer
              Positioned.fill(
                child: InvisibleTextField(
                  editableTextKey: editableTextKey,
                  controller: _effectiveController,
                  focusNode: _effectiveFocusNode,
                  length: widget.length,
                  readOnly: widget.readOnly,
                  selectionEnabled: selectionEnabled,
                  selectionControls: selectionControls,
                  contextMenuBuilder:
                      selectionEnabled ? widget.contextMenuBuilder : null,
                  keyboardType: widget.keyboardType,
                  inputFormatters: widget.inputFormatters,
                  textCapitalization: widget.textCapitalization,
                  textInputAction: widget.textInputAction,
                  onSubmitted: widget.onSubmitted,
                  onEditingComplete: widget.onEditingComplete,
                  onSelectionChanged: _handleSelectionChanged,
                  keyboardAppearance: widget.keyboardAppearance,
                  scrollPadding: widget.scrollPadding,
                  autofillHints: widget.enableAutofill ? widget.autofillHints : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Wrap with AutofillGroup if autofill is enabled
    if (widget.enableAutofill) {
      content = AutofillGroup(
        onDisposeAction: widget.autofillContextAction,
        child: content,
      );
    }

    return content;
  }
}
