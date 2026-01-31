import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../haptics.dart';
import '../pin_input.dart';
import '../pin_input_controller.dart';

/// A [FormField] wrapper for [PinInput] that enables form validation.
///
/// This widget provides all the standard form field functionality including
/// validation, onSaved callbacks, and auto-validation modes.
///
/// Example:
/// ```dart
/// Form(
///   child: PinInputFormField(
///     length: 6,
///     builder: (context, cells) => Row(
///       children: cells.map((c) => MyCell(data: c)).toList(),
///     ),
///     validator: (value) {
///       if (value == null || value.length < 6) {
///         return 'Please enter all 6 digits';
///       }
///       return null;
///     },
///   ),
/// )
/// ```
class PinInputFormField extends FormField<String> {
  PinInputFormField({
    super.key,
    required int length,
    required PinCellBuilder builder,
    // Controller
    PinInputController? pinController,
    // Input behavior
    TextInputType keyboardType = TextInputType.number,
    TextInputAction textInputAction = TextInputAction.done,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
    Iterable<String>? autofillHints,
    // Behavior
    bool autoFocus = false,
    bool readOnly = false,
    bool autoDismissKeyboard = true,
    bool obscureText = false,
    String obscuringCharacter = '●',
    bool blinkWhenObscuring = true,
    Duration blinkDuration = const Duration(milliseconds: 500),
    // Haptics
    bool enableHapticFeedback = true,
    HapticFeedbackType hapticFeedbackType = HapticFeedbackType.light,
    // Gestures
    bool enablePaste = true,
    TextSelectionControls? selectionControls,
    EditableTextContextMenuBuilder? contextMenuBuilder,
    // Callbacks
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onCompleted,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onEditingComplete,
    VoidCallback? onTap,
    // Error
    Stream<void>? errorTrigger,
    // Keyboard
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20),
    // Autofill
    bool enableAutofill = false,
    AutofillContextAction autofillContextAction = AutofillContextAction.commit,
    // Form field
    super.validator,
    super.onSaved,
    super.initialValue,
    super.autovalidateMode = AutovalidateMode.disabled,
    super.restorationId,
    // Error display
    double errorTextSpace = 16.0,
    TextStyle? errorTextStyle,
  }) : super(
          builder: (FormFieldState<String> field) {
            final state = field as _PinInputFormFieldState;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PinInput(
                  length: length,
                  builder: builder,
                  pinController: state._effectiveController,
                  keyboardType: keyboardType,
                  textInputAction: textInputAction,
                  inputFormatters: inputFormatters,
                  textCapitalization: textCapitalization,
                  autofillHints: autofillHints,
                  autoFocus: autoFocus,
                  readOnly: readOnly,
                  autoDismissKeyboard: autoDismissKeyboard,
                  obscureText: obscureText,
                  obscuringCharacter: obscuringCharacter,
                  blinkWhenObscuring: blinkWhenObscuring,
                  blinkDuration: blinkDuration,
                  enableHapticFeedback: enableHapticFeedback,
                  hapticFeedbackType: hapticFeedbackType,
                  enablePaste: enablePaste,
                  selectionControls: selectionControls,
                  contextMenuBuilder: contextMenuBuilder,
                  onChanged: (value) {
                    field.didChange(value);
                    onChanged?.call(value);
                  },
                  onCompleted: onCompleted,
                  onSubmitted: onSubmitted,
                  onEditingComplete: onEditingComplete,
                  onTap: onTap,
                  errorTrigger: errorTrigger,
                  keyboardAppearance: keyboardAppearance,
                  scrollPadding: scrollPadding,
                  enableAutofill: enableAutofill,
                  autofillContextAction: autofillContextAction,
                ),
                if (field.hasError) ...[
                  SizedBox(height: errorTextSpace),
                  Text(
                    field.errorText!,
                    style: errorTextStyle ??
                        TextStyle(
                          color: Theme.of(field.context).colorScheme.error,
                          fontSize: 12,
                        ),
                  ),
                ],
              ],
            );
          },
        );

  @override
  FormFieldState<String> createState() => _PinInputFormFieldState();
}

class _PinInputFormFieldState extends FormFieldState<String> {
  PinInputController? _controller;

  PinInputController get _effectiveController => _controller!;

  @override
  PinInputFormField get widget => super.widget as PinInputFormField;

  @override
  void initState() {
    super.initState();
    _controller = PinInputController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(PinInputFormField oldWidget) {
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
