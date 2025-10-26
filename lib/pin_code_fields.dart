library pin_code_fields; // Define library name

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'src/models/pin_theme.dart';
part 'src/utils/enums.dart';
part 'src/widgets/cursor_painter.dart'; // Keep import for potential future use
part 'src/widgets/gradiented.dart';
part 'src/widgets/pin_code_cell.dart';
part 'src/widgets/pin_code_field_row.dart';
part 'src/widgets/underlying_editable_text.dart';

// State class for PinCodeTextField
part 'src/pin_code_fields_state.dart';

/// Pin code text fields which automatically changes focus and validates
class PinCodeTextField extends StatefulWidget {
  /// The [BuildContext] of the application - **REMOVED** (can get from context)
  // final BuildContext appContext; // Removed

  ///Box Shadow for Pincode
  final List<BoxShadow>? boxShadows; // Kept

  /// length of how many cells there should be. 3-8 is recommended by me
  final int length; // Kept

  /// you already know what it does i guess :P default is false
  final bool obscureText; // Kept

  /// Character used for obscuring text if obscureText is true.
  /// Must not be empty. Single character is recommended. Default is ●
  final String obscuringCharacter; // Kept

  /// Widget used to obscure text. it overrides the obscuringCharacter
  final Widget? obscuringWidget; // Kept

  /// Whether to use haptic feedback or not
  final bool useHapticFeedback; // Kept

  /// Haptic Feedback Types
  final HapticFeedbackTypes hapticFeedbackTypes; // Kept

  /// Decides whether typed character should be briefly shown before being obscured
  final bool blinkWhenObscuring; // Kept

  /// Blink Duration if blinkWhenObscuring is set to true
  final Duration blinkDuration; // Kept

  /// returns the current typed text in the fields
  final ValueChanged<String>? onChanged; // Kept

  /// returns the typed text when all pins are set
  final ValueChanged<String>? onCompleted; // Kept

  /// returns the typed text when user presses done/next action on the keyboard
  final ValueChanged<String>?
      onSubmitted; // Kept (will be used by EditableText)

  /// The [onEditingComplete] callback also runs when the user finishes editing.
  final VoidCallback? onEditingComplete; // Kept (will be used by EditableText)

  /// the style of the text, default is [ fontSize: 20, fontWeight: FontWeight.bold]
  final TextStyle? textStyle; // Kept (will be used inside PinTheme now maybe?)

  /// the style of the pasted text, default is [fontWeight: FontWeight.bold] while
  /// [TextStyle.color] is [ThemeData.colorScheme.onSecondary] - **REMOVED** (Handled by context menu)
  // final TextStyle? pastedTextStyle; // Removed

  /// background color for the whole row of pin code fields. - **REMOVED** (Applied via container in build if needed)
  // final Color? backgroundColor; // Removed

  /// This defines how the elements in the pin code field align. Default to [MainAxisAlignment.spaceBetween]
  final MainAxisAlignment mainAxisAlignment; // Kept

  /// [AnimationType] for the text to appear in the pin code field. Default is [AnimationType.slide]
  final AnimationType animationType; // Kept (For visual transition)

  /// Duration for the animation. Default is [Duration(milliseconds: 150)]
  final Duration animationDuration; // Kept (For visual transition)

  /// [Curve] for the animation. Default is [Curves.easeInOut]
  final Curve animationCurve; // Kept (For visual transition)

  /// [TextInputType] for the pin code fields. default is [TextInputType.visiblePassword]
  final TextInputType keyboardType; // Kept

  /// If the pin code field should be autofocused or not. Default is [false]
  final bool autoFocus; // Kept

  /// Should pass a [FocusNode] to manage it from the parent
  final FocusNode? focusNode; // Kept

  /// A list of [TextInputFormatter] that goes to the TextField
  final List<TextInputFormatter> inputFormatters; // Kept

  /// Enable or disable the Field. Default is [true]
  final bool enabled; // Kept (will map to readOnly)

  /// [TextEditingController] to control the text manually. Sets a default [TextEditingController()] object if none given
  final TextEditingController? controller; // Kept

  /// Enabled Color fill for individual pin fields, default is [false]
  final bool enableActiveFill;

  /// Auto dismiss the keyboard upon inputting the value for the last field (when PIN is complete).
  /// Note: The keyboard is NOT dismissed when the field loses focus, only on completion.
  /// Default is [true]
  final bool autoDismissKeyboard;

  /// Configures how the platform keyboard will select an uppercase or lowercase keyboard.
  final TextCapitalization textCapitalization; // Kept

  /// The type of action button to use for the keyboard.
  final TextInputAction textInputAction; // Kept

  /// Triggers the error animation
  final StreamController<ErrorAnimationType>? errorAnimationController; // Kept

  /// Method for detecting a pin_code form tap
  final GestureTapCallback? onTap; // Kept (Will be handled by gesture detector)

  /// Theme for the pin cells. Read more [PinTheme]
  final PinTheme pinTheme; // Kept

  /// Brightness dark or light choices for iOS keyboard.
  final Brightness? keyboardAppearance; // Kept

  /// Validator for the pin code field. Returns an error message string to display if the input is invalid, or null otherwise.
  final FormFieldValidator<String>? validator;

  /// An optional method to call with the final value when the form is saved.
  final FormFieldSetter<String>? onSaved;

  /// Auto validation mode for the form field.
  final AutovalidateMode autovalidateMode;

  /// The vertical padding from the pin code field to the error text.
  final double errorTextSpace;

  /// Style for the error text.
  final TextStyle? errorTextStyle;

  /// enables pin autofill for TextFormField. - **Kept** (Needs re-integration with AutofillClient on EditableText)
  final bool enablePinAutofill; // Kept (Needs implementation)

  /// Error animation duration
  final int errorAnimationDuration;

  /// Whether to show cursor or not
  final bool showCursor;

  /// The color of the cursor, default to Theme.of(context).accentColor
  final Color? cursorColor;

  /// width of the cursor, default to 2
  final double cursorWidth;

  /// Height of the cursor, default to FontSize + 8;
  final double? cursorHeight;

  /// Whether to animate the cursor blinking
  final bool animateCursor;

  /// The duration of one cursor blink cycle
  final Duration cursorBlinkDuration;

  /// The curve to use for cursor blink animation
  final Curve cursorBlinkCurve;

  /// Autofill cleanup action
  final AutofillContextAction onAutoFillDisposeAction;

  /// Displays a hint or placeholder in the field if it's value is empty.
  final String? hintCharacter;

  /// the style of the [hintCharacter], default is [fontSize: 20, fontWeight: FontWeight.bold]
  final TextStyle? hintStyle;

  /// ScrollPadding follows the same property as TextField's ScrollPadding, default to const EdgeInsets.all(20),
  final EdgeInsets scrollPadding;

  /// Text gradient for Pincode
  final Gradient? textGradient;

  /// Makes the pin cells readOnly
  final bool readOnly;

  /// Enable auto unfocus
  final bool autoUnfocus;

  /// Builds separator children
  final IndexedWidgetBuilder? separatorBuilder;

  /// If true, the native context menu (e.g., Paste) will appear on long press.
  final bool enableContextMenu;

  /// The platform text selection controls to use (e.g., materialTextSelectionControls).
  /// If null, defaults based on platform.
  final TextSelectionControls? selectionControls;

  /// Builds the context menu when triggered. Defaults to a platform-adaptive menu.
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  PinCodeTextField({
    super.key,
    required this.length,
    this.controller,
    this.obscureText = false,
    this.obscuringCharacter = '●',
    this.obscuringWidget,
    this.blinkWhenObscuring = false,
    this.blinkDuration = const Duration(milliseconds: 500),
    this.onChanged,
    this.onCompleted,
    this.onSubmitted,
    this.onEditingComplete,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeInOut,
    this.animationType = AnimationType.slide,
    this.keyboardType = TextInputType.visiblePassword,
    this.autoFocus = false,
    this.focusNode,
    this.onTap,
    this.enabled = true, // Will map to !readOnly internally
    this.inputFormatters = const <TextInputFormatter>[],
    this.textStyle,
    this.useHapticFeedback = false,
    this.hapticFeedbackTypes = HapticFeedbackTypes.light,
    this.enableActiveFill = true,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
    this.autoDismissKeyboard = true,
    this.errorAnimationController,
    this.pinTheme = const PinTheme.defaults(),
    this.keyboardAppearance,
    this.enablePinAutofill = true, // Needs re-implementation
    this.errorAnimationDuration = 500,
    this.boxShadows,
    this.showCursor = true,
    this.cursorColor,
    this.cursorWidth = 2,
    this.cursorHeight,
    this.animateCursor = false, // Added
    this.cursorBlinkDuration = const Duration(milliseconds: 500), // Added
    this.cursorBlinkCurve = Curves.easeInOut, // Added
    this.hintCharacter,
    this.hintStyle,
    this.textGradient,
    this.readOnly = false, // Keep this, maps directly
    this.autoUnfocus = true,
    this.onAutoFillDisposeAction = AutofillContextAction.commit, // For Autofill
    this.scrollPadding = const EdgeInsets.all(20),
    this.separatorBuilder,
    this.enableContextMenu = true,
    this.selectionControls,
    this.contextMenuBuilder = _defaultContextMenuBuilder, // Use static default
    this.validator,
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.errorTextSpace = 16.0,
    this.errorTextStyle,
  })  : assert(obscuringCharacter.isNotEmpty),
        assert(length > 0);

  // Default context menu builder function (static) - Copied from POC
  static Widget _defaultContextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    final items = editableTextState.contextMenuButtonItems;
    items.removeWhere((item) => item.type != ContextMenuButtonType.paste);

    if (items.isEmpty) return const SizedBox.shrink();

    return AdaptiveTextSelectionToolbar.buttonItems(
      anchors: editableTextState.contextMenuAnchors,
      buttonItems: items,
    );
  }

  @override
  // Reference the state class declared in the separate file
  State<PinCodeTextField> createState() => _PinCodeTextFieldState();
}

/// A [FormField] wrapper around [PinCodeTextField] to enable form validation.
class PinCodeFormField extends FormField<String> {
  /// Creates a [PinCodeTextField] wrapped in a [FormField].
  PinCodeFormField({
    super.key,
    required int length,
    TextEditingController? controller,
    bool obscureText = false,
    String obscuringCharacter = '●',
    Widget? obscuringWidget,
    bool blinkWhenObscuring = false,
    Duration blinkDuration = const Duration(milliseconds: 500),
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onCompleted,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onEditingComplete,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween,
    Duration animationDuration = const Duration(milliseconds: 150),
    Curve animationCurve = Curves.easeInOut,
    AnimationType animationType = AnimationType.slide,
    TextInputType keyboardType = TextInputType.visiblePassword,
    bool autoFocus = false,
    FocusNode? focusNode,
    GestureTapCallback? onTap,
    bool enabled = true,
    List<TextInputFormatter> inputFormatters = const <TextInputFormatter>[],
    TextStyle? textStyle,
    bool useHapticFeedback = false,
    HapticFeedbackTypes hapticFeedbackTypes = HapticFeedbackTypes.light,
    bool enableActiveFill = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction textInputAction = TextInputAction.done,
    bool autoDismissKeyboard = true,
    StreamController<ErrorAnimationType>? errorAnimationController,
    PinTheme pinTheme = const PinTheme.defaults(),
    Brightness? keyboardAppearance,
    bool enablePinAutofill = true,
    int errorAnimationDuration = 500,
    List<BoxShadow>? boxShadows,
    bool showCursor = true,
    Color? cursorColor,
    double cursorWidth = 2,
    double? cursorHeight,
    bool animateCursor = false,
    Duration cursorBlinkDuration = const Duration(milliseconds: 500),
    Curve cursorBlinkCurve = Curves.easeInOut,
    String? hintCharacter,
    TextStyle? hintStyle,
    Gradient? textGradient,
    bool readOnly = false,
    bool autoUnfocus = true,
    AutofillContextAction onAutoFillDisposeAction =
        AutofillContextAction.commit,
    EdgeInsets scrollPadding = const EdgeInsets.all(20),
    IndexedWidgetBuilder? separatorBuilder,
    bool enableContextMenu = true,
    TextSelectionControls? selectionControls,
    EditableTextContextMenuBuilder? contextMenuBuilder =
        PinCodeTextField._defaultContextMenuBuilder,
    super.validator,
    super.onSaved,
    super.initialValue,
    super.autovalidateMode = AutovalidateMode.disabled,
    double errorTextSpace = 16.0,
    TextStyle? errorTextStyle,
  }) : super(
          builder: (FormFieldState<String> field) {
            final _PinCodeFormFieldState state =
                field as _PinCodeFormFieldState;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PinCodeTextField(
                  length: length,
                  controller: state._effectiveController,
                  obscureText: obscureText,
                  obscuringCharacter: obscuringCharacter,
                  obscuringWidget: obscuringWidget,
                  blinkWhenObscuring: blinkWhenObscuring,
                  blinkDuration: blinkDuration,
                  onChanged: (value) {
                    field.didChange(value);
                    onChanged?.call(value);
                  },
                  onCompleted: onCompleted,
                  onSubmitted: onSubmitted,
                  onEditingComplete: onEditingComplete,
                  mainAxisAlignment: mainAxisAlignment,
                  animationDuration: animationDuration,
                  animationCurve: animationCurve,
                  animationType: animationType,
                  keyboardType: keyboardType,
                  autoFocus: autoFocus,
                  focusNode: focusNode,
                  onTap: onTap,
                  enabled: enabled,
                  inputFormatters: inputFormatters,
                  textStyle: textStyle,
                  useHapticFeedback: useHapticFeedback,
                  hapticFeedbackTypes: hapticFeedbackTypes,
                  enableActiveFill: enableActiveFill,
                  textCapitalization: textCapitalization,
                  textInputAction: textInputAction,
                  autoDismissKeyboard: autoDismissKeyboard,
                  errorAnimationController: errorAnimationController,
                  pinTheme: pinTheme,
                  keyboardAppearance: keyboardAppearance,
                  enablePinAutofill: enablePinAutofill,
                  errorAnimationDuration: errorAnimationDuration,
                  boxShadows: boxShadows,
                  showCursor: showCursor,
                  cursorColor: cursorColor,
                  cursorWidth: cursorWidth,
                  cursorHeight: cursorHeight,
                  animateCursor: animateCursor,
                  cursorBlinkDuration: cursorBlinkDuration,
                  cursorBlinkCurve: cursorBlinkCurve,
                  hintCharacter: hintCharacter,
                  hintStyle: hintStyle,
                  textGradient: textGradient,
                  readOnly: readOnly,
                  autoUnfocus: autoUnfocus,
                  onAutoFillDisposeAction: onAutoFillDisposeAction,
                  scrollPadding: scrollPadding,
                  separatorBuilder: separatorBuilder,
                  enableContextMenu: enableContextMenu,
                  selectionControls: selectionControls,
                  contextMenuBuilder: contextMenuBuilder,
                ),
                SizedBox(height: field.hasError ? errorTextSpace : 0),
                if (field.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      field.errorText!,
                      style: errorTextStyle ??
                          TextStyle(
                            color: Theme.of(field.context).colorScheme.error,
                            fontSize: 12,
                          ),
                    ),
                  ),
              ],
            );
          },
        );

  @override
  FormFieldState<String> createState() => _PinCodeFormFieldState();
}

class _PinCodeFormFieldState extends FormFieldState<String> {
  TextEditingController? _controller;

  TextEditingController get _effectiveController => _controller!;

  @override
  PinCodeFormField get widget => super.widget as PinCodeFormField;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(PinCodeFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      setValue(widget.initialValue);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void reset() {
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }
}
