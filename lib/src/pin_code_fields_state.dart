part of '../pin_code_fields.dart';

class _PinCodeTextFieldState extends State<PinCodeTextField>
    with
        TickerProviderStateMixin // Use TickerProviderStateMixin for animations
    implements
        TextSelectionGestureDetectorBuilderDelegate {
  // Implement delegate

  TextEditingController? _textEditingController;
  late FocusNode _focusNode;

  // --- Delegate Properties ---
  @override
  final GlobalKey<EditableTextState> editableTextKey =
      GlobalKey<EditableTextState>();

  // Determines if selection-related gestures should be enabled.
  @override
  bool get selectionEnabled => widget.enableContextMenu && !widget.readOnly;

  @override
  bool get forcePressEnabled => false; // Keep false generally

  // The builder for handling selection gestures.
  late final TextSelectionGestureDetectorBuilder _gestureDetectorBuilder;

  // --- Animation Controllers ---
  late AnimationController
      _errorAnimationController; // Renamed from _controller
  late Animation<Offset> _offsetAnimation; // For shake animation
  Timer? _blinkDebounce;
  bool _hasBlinked = true; // For blinkWhenObscuring

  // --- State ---
  bool isInErrorMode = false;

  // --- Styles ---
  TextStyle get _textStyle =>
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
          .merge(widget.textStyle);
  TextStyle get _hintStyle => _textStyle
      .copyWith(
          color: widget.pinTheme.disabledColor) // Use disabled color for hint
      .merge(widget.hintStyle);

  @override
  void initState() {
    super.initState();
    _assignController(); // Initialize controller & ADD LISTENER
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChanged);

    // Initialize the gesture detector builder
    _gestureDetectorBuilder =
        TextSelectionGestureDetectorBuilder(delegate: this);

    // Initialize error animation controller
    _errorAnimationController = AnimationController(
      duration: Duration(milliseconds: widget.errorAnimationDuration),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(.1, 0.0),
    ).animate(CurvedAnimation(
      parent: _errorAnimationController,
      curve: Curves.elasticIn,
    ));
    _errorAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _errorAnimationController.reverse();
      }
    });

    // Listen to external error controller if provided
    if (widget.errorAnimationController != null) {
      _errorAnimationSubscription =
          widget.errorAnimationController!.stream.listen(_handleErrorAnimation);
    }

    // Set initial selection directly
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Check mounted after frame callback
        _controller.selection =
            TextSelection.collapsed(offset: _controller.text.length);
      }
    });

    // Handle autofocus AFTER the first frame
    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Check mounted AND focus status before requesting
        if (mounted && !_focusNode.hasFocus) {
          _requestFocusSafely(); // Use the safe request method
        }
      });
    }
  }

  // Add the safe focus request method (if not already present)
  void _requestFocusSafely() {
    // Ensure context is valid and widget is mounted before requesting focus
    // Check _focusNode isn't null either
    if (mounted && _focusNode.context != null) {
      FocusScope.of(context).requestFocus(_focusNode);
    } else if (mounted) {
      // Fallback if context isn't immediately ready after frame callback
      Future.delayed(const Duration(milliseconds: 50), () {
        if (mounted && _focusNode.context != null) {
          FocusScope.of(context).requestFocus(_focusNode);
        }
      });
    }
  }

  // Helper to get the effective controller
  TextEditingController get _controller => _textEditingController!;

  StreamSubscription<ErrorAnimationType>? _errorAnimationSubscription;

  void _handleErrorAnimation(ErrorAnimationType errorAnimation) {
    if (errorAnimation == ErrorAnimationType.shake) {
      _errorAnimationController.forward();
      _setState(() => isInErrorMode = true);
    } else if (errorAnimation == ErrorAnimationType.clear) {
      _setState(() => isInErrorMode = false);
    }
  }

  void _assignController() {
    if (widget.controller == null) {
      _textEditingController = TextEditingController();
    } else {
      _textEditingController = widget.controller;
    }
    _textEditingController!.addListener(_textEditingControllerListener);
    // Ensure initial text doesn't exceed length
    final initialText = _getLimitedText(_textEditingController!.text);
    if (initialText != _textEditingController!.text) {
      // Use scheduler binding to avoid issues during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller.text = initialText;
        }
      });
    }
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      editableTextKey.currentState?.hideToolbar();
      if (widget.autoDismissKeyboard) {
        // Consider if unfocus should happen here or on complete only
      }
    }
    _setState(() {}); // Rebuild for visual changes
  }

  // Central handler for text changes from the controller
  void _textEditingControllerListener() {
    if (!mounted) return; // Avoid calling if disposed

    // Apply haptic feedback if enabled
    if (widget.useHapticFeedback) _runHapticFeedback();

    // Clear error state on text change
    if (isInErrorMode) _setState(() => isInErrorMode = false);

    final currentText = _controller.text;
    final limitedText = _getLimitedText(currentText);

    // 1. Validate and correct the controller's value if needed
    if (currentText != limitedText) {
      // This correction will trigger the listener again.
      // Schedule the correction after the current frame to avoid conflicts.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller.value = TextEditingValue(
            text: limitedText,
            selection: TextSelection.collapsed(offset: limitedText.length),
          );
        }
      });
      return; // Exit early, the correction will re-trigger the listener
    }

    // 2. Update internal state and call callbacks
    final previousLength = _controller.value.text.length;
    final currentLength = limitedText.length;

    // Call onChanged regardless of completion
    widget.onChanged?.call(limitedText);

    // Check for completion
    if (currentLength == widget.length && previousLength < widget.length) {
      widget.onCompleted?.call(limitedText);
      if (widget.autoDismissKeyboard) {
        _focusNode.unfocus();
      }
    }

    // Handle blink effect
    _debounceBlink();

    // Trigger rebuild if necessary (visual state depends on text length/focus)
    _setState(() {});
  }

  // Applies length and character filtering
  String _getLimitedText(String text) {
    // Apply filters first (e.g., digits only)
    String filteredText = widget.keyboardType == TextInputType.number
        ? text.replaceAll(RegExp(r'[^0-9]'), '') // Example filter
        : text;

    // Apply length limit
    return filteredText.length > widget.length
        ? filteredText.substring(0, widget.length)
        : filteredText;
  }

  void _debounceBlink() {
    if (widget.blinkWhenObscuring && _controller.text.isNotEmpty) {
      _setState(() {
        _hasBlinked = false;
      });
      _blinkDebounce?.cancel();
      _blinkDebounce = Timer(widget.blinkDuration, () {
        if (mounted) {
          _setState(() {
            _hasBlinked = true;
          });
        }
      });
    } else if (!widget.blinkWhenObscuring && !_hasBlinked) {
      _setState(() {
        _hasBlinked = true;
      });
    }
  }

  void _runHapticFeedback() {
    switch (widget.hapticFeedbackTypes) {
      case HapticFeedbackTypes.heavy:
        HapticFeedback.heavyImpact();
        break;
      case HapticFeedbackTypes.medium:
        HapticFeedback.mediumImpact();
        break;
      case HapticFeedbackTypes.light:
        HapticFeedback.lightImpact();
        break;
      case HapticFeedbackTypes.selection:
        HapticFeedback.selectionClick();
        break;
      case HapticFeedbackTypes.vibrate:
        HapticFeedback.vibrate();
        break;
    }
  }

  @override
  void dispose() {
    _errorAnimationSubscription?.cancel();
    _errorAnimationController.dispose();
    _blinkDebounce?.cancel();
    _textEditingController?.removeListener(_textEditingControllerListener);

    if (widget.controller == null) {
      _textEditingController?.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
      // Only remove listener if not disposing focus node provided externally
      _focusNode.removeListener(_onFocusChanged);
    }

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PinCodeTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Simplified update logic, focusing on critical changes

    // Controller change
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_textEditingControllerListener);
      _assignController(); // Re-assign and add listener
    }

    // FocusNode change
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_onFocusChanged);
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChanged);
    }

    // Length change
    if (widget.length != oldWidget.length) {
      // Force re-evaluation and potential truncation of text
      _textEditingControllerListener();
      setState(() {}); // Ensure rebuild for new length
    }

    // Error stream change
    if (widget.errorAnimationController != oldWidget.errorAnimationController) {
      _errorAnimationSubscription?.cancel();
      if (widget.errorAnimationController != null) {
        _errorAnimationSubscription = widget.errorAnimationController!.stream
            .listen(_handleErrorAnimation);
      }
    }

    // Rebuild if readOnly or enableContextMenu changes as it affects behavior
    if (widget.readOnly != oldWidget.readOnly ||
        widget.enableContextMenu != oldWidget.enableContextMenu) {
      setState(() {});
    }
  }

  void _handleSelectionChanged(
      TextSelection selection, SelectionChangedCause? cause) {
    if (widget.readOnly) return;
    // Always force selection to be collapsed at the end
    if (_controller.selection.baseOffset != _controller.text.length ||
        _controller.selection.extentOffset != _controller.text.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller.selection =
              TextSelection.collapsed(offset: _controller.text.length);
        }
      });
    }
  }

  // --- Main Build Method ---
  @override
  Widget build(BuildContext context) {
    // Platform-specific controls if none provided
    final platform = Theme.of(context).platform;
    final TextSelectionControls selectionControls = widget.selectionControls ??
        switch (platform) {
          TargetPlatform.iOS ||
          TargetPlatform.macOS =>
            cupertinoTextSelectionHandleControls,
          TargetPlatform.android ||
          TargetPlatform.fuchsia =>
            materialTextSelectionHandleControls,
          TargetPlatform.linux ||
          TargetPlatform.windows =>
            desktopTextSelectionHandleControls,
        };

    return SlideTransition(
      // Wrap with error shake animation
      position: _offsetAnimation,
      child: _gestureDetectorBuilder.buildGestureDetector(
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          height: widget.pinTheme.fieldHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Layer 1: Visual Cells
              _PinCodeFieldRow(
                length: widget.length,
                text: _controller.text,
                hasFocus: _focusNode.hasFocus,
                isInErrorMode: isInErrorMode,
                pinTheme: widget.pinTheme,
                textStyle: _textStyle,
                hintStyle: _hintStyle,
                hintCharacter: widget.hintCharacter,
                obscureText: widget.obscureText,
                obscuringCharacter: widget.obscuringCharacter,
                obscuringWidget: widget.obscuringWidget,
                showCursor: widget.showCursor,
                cursorColor: widget.cursorColor,
                cursorWidth: widget.cursorWidth,
                cursorHeight: widget.cursorHeight,
                enableActiveFill: widget.enableActiveFill,
                boxShadows: widget.boxShadows,
                enabled: widget.enabled,
                readOnly: widget.readOnly,
                animationDuration: widget.animationDuration,
                animationCurve: widget.animationCurve,
                animationType: widget.animationType,
                textGradient: widget.textGradient,
                blinkWhenObscuring: widget.blinkWhenObscuring,
                hasBlinked: _hasBlinked,
                mainAxisAlignment: widget.mainAxisAlignment,
                separatorBuilder: widget.separatorBuilder,
                animateCursor: widget.animateCursor,
                cursorBlinkDuration: widget.cursorBlinkDuration,
                cursorBlinkCurve: widget.cursorBlinkCurve,
              ),

              // Layer 2: Functionality via EditableText
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.pinTheme.fieldOuterPadding.horizontal / 2,
                ),
                child: SizedBox(
                  width: (widget.pinTheme.fieldWidth +
                          widget.pinTheme.fieldOuterPadding.horizontal) *
                      widget.length,
                  height: widget.pinTheme.fieldHeight +
                      widget.pinTheme.fieldOuterPadding.vertical,
                  child: _UnderlyingEditableText(
                    editableTextKey: editableTextKey,
                    controller: _controller,
                    focusNode: _focusNode,
                    readOnly: widget.readOnly,
                    selectionEnabled: selectionEnabled,
                    selectionControls:
                        selectionEnabled ? selectionControls : null,
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
                    length: widget.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to prevent setState calls when the widget is disposed
  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }
}
