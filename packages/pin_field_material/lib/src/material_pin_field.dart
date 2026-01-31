import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_field_core/pin_field_core.dart';

import 'animations/error_shake.dart';
import 'layout/material_pin_row.dart';
import 'theme/material_pin_theme.dart';

/// A ready-to-use Material Design PIN field.
///
/// This widget provides a complete, styled PIN input experience using
/// Material Design principles. It wraps [PinInput] with Material-styled
/// cells and animations.
///
/// Example:
/// ```dart
/// MaterialPinField(
///   length: 6,
///   onCompleted: (pin) => print('PIN: $pin'),
///   theme: MaterialPinTheme(
///     shape: MaterialPinShape.outlined,
///     cellSize: Size(56, 64),
///   ),
/// )
/// ```
class MaterialPinField extends StatefulWidget {
  const MaterialPinField({
    super.key,
    required this.length,
    this.theme = const MaterialPinTheme(),
    // Controller
    this.controller,
    this.focusNode,
    // Input behavior
    this.keyboardType = TextInputType.number,
    this.textInputAction = TextInputAction.done,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.enableAutofill = false,
    this.autofillContextAction = AutofillContextAction.commit,
    // Behavior
    this.autoFocus = false,
    this.readOnly = false,
    this.autoDismissKeyboard = true,
    this.obscureText = false,
    this.blinkWhenObscuring = true,
    this.blinkDuration = const Duration(milliseconds: 500),
    // Haptics
    this.enableHapticFeedback = true,
    this.hapticFeedbackType = HapticFeedbackType.light,
    // Gestures
    this.enablePaste = true,
    // Callbacks
    this.onChanged,
    this.onCompleted,
    this.onSubmitted,
    this.onEditingComplete,
    this.onTap,
    // Error
    this.errorTrigger,
    // Hint
    this.hintCharacter,
    this.hintStyle,
    // Layout
    this.separatorBuilder,
    this.mainAxisAlignment = MainAxisAlignment.center,
    // Keyboard
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20),
  }) : assert(length > 0, 'Length must be greater than 0');

  /// Number of PIN cells.
  final int length;

  /// Theme configuration for the PIN field.
  final MaterialPinTheme theme;

  /// Controller for the text input.
  final TextEditingController? controller;

  /// Focus node for managing keyboard focus.
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

  /// Whether to enable autofill functionality.
  ///
  /// When enabled, the field will be wrapped in an [AutofillGroup] to support
  /// SMS OTP autofill and password managers.
  final bool enableAutofill;

  /// The action to take when the autofill context is disposed.
  ///
  /// - [AutofillContextAction.commit]: Save the autofilled data (default)
  /// - [AutofillContextAction.cancel]: Discard the autofilled data
  final AutofillContextAction autofillContextAction;

  /// Whether to auto-focus on mount.
  final bool autoFocus;

  /// Whether the field is read-only.
  final bool readOnly;

  /// Whether to dismiss the keyboard when PIN is complete.
  final bool autoDismissKeyboard;

  /// Whether to obscure the entered text.
  final bool obscureText;

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

  /// Called when the text changes.
  final ValueChanged<String>? onChanged;

  /// Called when the PIN is complete.
  final ValueChanged<String>? onCompleted;

  /// Called when the user submits.
  final ValueChanged<String>? onSubmitted;

  /// Called when editing is complete.
  final VoidCallback? onEditingComplete;

  /// Called when the widget is tapped.
  final VoidCallback? onTap;

  /// Stream to trigger error state and shake animation.
  final Stream<void>? errorTrigger;

  /// Hint character to show in empty cells.
  final String? hintCharacter;

  /// Style for hint character.
  final TextStyle? hintStyle;

  /// Optional builder for separators between cells.
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  /// How the cells should be aligned horizontally.
  ///
  /// Defaults to [MainAxisAlignment.center].
  final MainAxisAlignment mainAxisAlignment;

  /// The brightness of the keyboard.
  final Brightness? keyboardAppearance;

  /// Padding when scrolling the field into view.
  final EdgeInsets scrollPadding;

  @override
  State<MaterialPinField> createState() => _MaterialPinFieldState();
}

class _MaterialPinFieldState extends State<MaterialPinField> {
  final GlobalKey<ErrorShakeState> _shakeKey = GlobalKey<ErrorShakeState>();

  @override
  Widget build(BuildContext context) {
    final resolvedTheme = widget.theme.resolve(context);

    return ErrorShake(
      key: _shakeKey,
      trigger: widget.errorTrigger,
      duration: resolvedTheme.errorAnimationDuration,
      enabled: resolvedTheme.enableErrorShake,
      child: PinInput(
        length: widget.length,
        controller: widget.controller,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        inputFormatters: widget.inputFormatters,
        textCapitalization: widget.textCapitalization,
        autofillHints: widget.autofillHints,
        enableAutofill: widget.enableAutofill,
        autofillContextAction: widget.autofillContextAction,
        autoFocus: widget.autoFocus,
        readOnly: widget.readOnly,
        autoDismissKeyboard: widget.autoDismissKeyboard,
        obscureText: widget.obscureText,
        obscuringCharacter: resolvedTheme.obscuringCharacter,
        blinkWhenObscuring: widget.blinkWhenObscuring,
        blinkDuration: widget.blinkDuration,
        enableHapticFeedback: widget.enableHapticFeedback,
        hapticFeedbackType: widget.hapticFeedbackType,
        enablePaste: widget.enablePaste,
        onChanged: widget.onChanged,
        onCompleted: widget.onCompleted,
        onSubmitted: widget.onSubmitted,
        onEditingComplete: widget.onEditingComplete,
        onTap: widget.onTap,
        errorTrigger: widget.errorTrigger,
        keyboardAppearance: widget.keyboardAppearance,
        scrollPadding: widget.scrollPadding,
        builder: (context, cells) {
          return MaterialPinRow(
            cells: cells,
            theme: resolvedTheme,
            obscureText: widget.obscureText,
            hintCharacter: widget.hintCharacter,
            hintStyle: widget.hintStyle,
            separatorBuilder: widget.separatorBuilder,
            mainAxisAlignment: widget.mainAxisAlignment,
          );
        },
      ),
    );
  }
}
