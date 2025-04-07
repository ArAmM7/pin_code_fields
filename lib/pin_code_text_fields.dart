library pin_code_text_fields; // Define library name

import 'dart:async';
import 'package:flutter/cupertino.dart'; // Required for cupertino controls
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'src/models/pin_theme.dart';
part 'src/utils/enums.dart';
part 'src/widgets/cursor_painter.dart'; // Keep import for potential future use
part 'src/widgets/gradiented.dart';
part 'src/widgets/pin_code_cell.dart';
part 'src/widgets/pin_code_field_row.dart';
part 'src/widgets/underlying_editable_text.dart';

// Forward declare the state class
part 'src/pin_code_text_fields_state.dart';

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
  final bool enableActiveFill; // Kept (used by PinTheme logic)

  /// Auto dismiss the keyboard upon inputting the value for the last field. Default is [true]
  final bool autoDismissKeyboard; // Kept

  /// Auto dispose the [controller] and [FocusNode] upon the destruction of widget from the widget tree. Default is [true]
  final bool autoDisposeControllers; // Kept

  /// Configures how the platform keyboard will select an uppercase or lowercase keyboard.
  final TextCapitalization textCapitalization; // Kept

  /// The type of action button to use for the keyboard.
  final TextInputAction textInputAction; // Kept

  /// Triggers the error animation
  final StreamController<ErrorAnimationType>? errorAnimationController; // Kept

  /// Callback method to validate if text can be pasted. Default will be pasted as received.
  final bool Function(String? text)?
      beforeTextPaste; // Kept (Needs integration with custom context menu)

  /// Method for detecting a pin_code form tap
  final GestureTapCallback? onTap; // Kept (Will be handled by gesture detector)

  /// Whether to show a confirmation dialog before pasting or not - **REMOVED**
  // final bool showPasteConfirmationDialog; // Removed

  /// Configuration for paste dialog. - **REMOVED**
  // final DialogConfig? dialogConfig; // Removed

  /// Theme for the pin cells. Read more [PinTheme]
  final PinTheme pinTheme; // Kept

  /// Brightness dark or light choices for iOS keyboard.
  final Brightness? keyboardAppearance; // Kept

  /// Validator for the [TextFormField] - **REMOVED** (Validation handled differently if needed)
  // final FormFieldValidator<String>? validator; // Removed

  /// An optional method to call with the final value when the form is saved - **REMOVED**
  // final FormFieldSetter<String>? onSaved; // Removed

  /// enables auto validation for the [TextFormField] - **REMOVED**
  // final AutovalidateMode autovalidateMode; // Removed

  /// The vertical padding from the [PinCodeTextField] to the error text - **REMOVED** (Handled by layout)
  // final double errorTextSpace; // Removed

  /// Margin for the error text - **REMOVED** (Handled by layout)
  // final EdgeInsets errorTextMargin; // Removed

  /// [TextDirection] to control a direction in which text flows. - **REMOVED** (Handled by context)
  // final TextDirection errorTextDirection; // Removed

  /// Enables pin autofill for TextFormField. - **Kept** (Needs re-integration with AutofillClient on EditableText)
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
    this.enableActiveFill = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
    this.autoDismissKeyboard = true,
    this.autoDisposeControllers = true,
    this.errorAnimationController,
    this.beforeTextPaste,
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
