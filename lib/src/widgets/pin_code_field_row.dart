part of '../../pin_code_fields.dart';

/// A private widget that represents the row of pin code cells.
class _PinCodeFieldRow extends StatelessWidget {
  const _PinCodeFieldRow({
    required this.length,
    required this.text,
    required this.hasFocus,
    required this.isInErrorMode,
    required this.pinTheme,
    required this.textStyle,
    required this.hintStyle,
    required this.hintCharacter,
    required this.obscureText,
    required this.obscuringCharacter,
    required this.obscuringWidget,
    required this.showCursor,
    required this.cursorColor,
    required this.cursorWidth,
    required this.cursorHeight,
    required this.enableActiveFill,
    required this.boxShadows,
    required this.enabled,
    required this.readOnly,
    required this.animationDuration,
    required this.animationCurve,
    required this.animationType,
    required this.textGradient,
    required this.blinkWhenObscuring,
    required this.hasBlinked,
    required this.mainAxisAlignment,
    required this.animateCursor,
    required this.cursorBlinkDuration,
    required this.cursorBlinkCurve,
    this.separatorBuilder,
  });

  final int length;
  final String text;
  final bool hasFocus;
  final bool isInErrorMode;
  final PinTheme pinTheme;
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final String? hintCharacter;
  final bool obscureText;
  final String obscuringCharacter;
  final Widget? obscuringWidget;
  final bool showCursor;
  final Color? cursorColor;
  final double cursorWidth;
  final double? cursorHeight;
  final bool enableActiveFill;
  final List<BoxShadow>? boxShadows;
  final bool enabled;
  final bool readOnly;
  final Duration animationDuration;
  final Curve animationCurve;
  final AnimationType animationType;
  final Gradient? textGradient;
  final bool blinkWhenObscuring;
  final bool hasBlinked;
  final MainAxisAlignment mainAxisAlignment;
  final bool animateCursor;
  final Duration cursorBlinkDuration;
  final Curve cursorBlinkCurve;
  final Widget Function(BuildContext, int)? separatorBuilder;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: _generateFields(context),
    );
  }

  List<Widget> _generateFields(BuildContext context) {
    final result = <Widget>[];
    final textLength = text.length;

    for (int i = 0; i < length; i++) {
      // Add the pin code cell
      result.add(
        _PinCodeCell(
          index: i,
          text: text,
          textLength: textLength,
          hasFocus: hasFocus,
          isInErrorMode: isInErrorMode,
          pinTheme: pinTheme,
          textStyle: textStyle,
          hintStyle: hintStyle,
          hintCharacter: hintCharacter,
          obscureText: obscureText,
          obscuringCharacter: obscuringCharacter,
          obscuringWidget: obscuringWidget,
          showCursor: showCursor,
          cursorColor: cursorColor,
          cursorWidth: cursorWidth,
          cursorHeight: cursorHeight,
          enableActiveFill: enableActiveFill,
          boxShadows: boxShadows,
          enabled: enabled,
          readOnly: readOnly,
          animationDuration: animationDuration,
          animationCurve: animationCurve,
          animationType: animationType,
          textGradient: textGradient,
          blinkWhenObscuring: blinkWhenObscuring,
          hasBlinked: hasBlinked,
          animateCursor: animateCursor,
          cursorBlinkDuration: cursorBlinkDuration,
          cursorBlinkCurve: cursorBlinkCurve,
        ),
      );

      // Add separator if needed
      if (separatorBuilder != null && i < length - 1) {
        result.add(separatorBuilder!(context, i));
      }
    }
    return result;
  }
}
