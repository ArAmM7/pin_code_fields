part of '../../pin_code_text_fields.dart';

/// A private widget that represents a single cell in the pin code field.
class _PinCodeCell extends StatelessWidget {
  const _PinCodeCell({
    required this.index,
    required this.text,
    required this.textLength,
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
  });

  final int index;
  final String text;
  final int textLength;
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

  @override
  Widget build(BuildContext context) {
    final bool isFilled = index < textLength;
    final bool isCurrent = index == textLength;
    final bool isLast = index == text.length - 1;
    final bool isFocusedCell =
        hasFocus && (isCurrent || (textLength == text.length && isLast));

    // Determine cell styling based on state
    Color borderColor = pinTheme.inactiveColor;
    Color fillColor = pinTheme.inactiveFillColor;
    double borderWidth = pinTheme.inactiveBorderWidth;
    List<BoxShadow>? boxShadow = pinTheme.inActiveBoxShadows;

    if (!enabled || readOnly) {
      borderColor = pinTheme.disabledColor;
      fillColor = pinTheme.disabledColor;
      borderWidth = pinTheme.disabledBorderWidth;
    } else if (isInErrorMode) {
      borderColor = pinTheme.errorBorderColor;
      fillColor = pinTheme.inactiveFillColor;
      borderWidth = pinTheme.errorBorderWidth;
    } else if (hasFocus && isFocusedCell) {
      borderColor = pinTheme.selectedColor;
      fillColor = pinTheme.selectedFillColor;
      borderWidth = pinTheme.selectedBorderWidth;
      boxShadow = pinTheme.activeBoxShadows;
    } else if (isFilled) {
      borderColor = pinTheme.activeColor;
      fillColor = pinTheme.activeFillColor;
      borderWidth = pinTheme.activeBorderWidth;
      boxShadow = pinTheme.activeBoxShadows;
    }

    return Container(
      padding: pinTheme.fieldOuterPadding,
      child: AnimatedContainer(
        curve: animationCurve,
        duration: animationDuration,
        width: pinTheme.fieldWidth,
        height: pinTheme.fieldHeight,
        decoration: BoxDecoration(
          color: enableActiveFill ? fillColor : Colors.transparent,
          boxShadow: boxShadow ?? boxShadows,
          shape: pinTheme.shape == PinCodeFieldShape.circle
              ? BoxShape.circle
              : BoxShape.rectangle,
          borderRadius: pinTheme.shape != PinCodeFieldShape.circle &&
                  pinTheme.shape != PinCodeFieldShape.underline
              ? pinTheme.borderRadius
              : null,
          border: pinTheme.shape == PinCodeFieldShape.underline
              ? Border(
                  bottom: BorderSide(color: borderColor, width: borderWidth))
              : Border.all(color: borderColor, width: borderWidth),
        ),
        alignment: Alignment.center,
        child: _PinCodeCellContent(
          index: index,
          text: text,
          textLength: textLength,
          hasFocus: hasFocus,
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
          readOnly: readOnly,
          animationDuration: animationDuration,
          animationCurve: animationCurve,
          animationType: animationType,
          textGradient: textGradient,
          blinkWhenObscuring: blinkWhenObscuring,
          hasBlinked: hasBlinked,
        ),
      ),
    );
  }
}

/// A private widget that represents the content of a pin code cell.
class _PinCodeCellContent extends StatelessWidget {
  const _PinCodeCellContent({
    required this.index,
    required this.text,
    required this.textLength,
    required this.hasFocus,
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
    required this.readOnly,
    required this.animationDuration,
    required this.animationCurve,
    required this.animationType,
    required this.textGradient,
    required this.blinkWhenObscuring,
    required this.hasBlinked,
  });

  final int index;
  final String text;
  final int textLength;
  final bool hasFocus;
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
  final bool readOnly;
  final Duration animationDuration;
  final Curve animationCurve;
  final AnimationType animationType;
  final Gradient? textGradient;
  final bool blinkWhenObscuring;
  final bool hasBlinked;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = hasFocus && (index == textLength);
    final bool isFilled = index < textLength;

    // Determine content based on state
    Widget content;

    // Determine if obscuring applies
    bool showObscured = obscureText &&
        (!blinkWhenObscuring ||
            (blinkWhenObscuring && hasBlinked) ||
            index != textLength - 1);

    if (isFilled) {
      if (showObscured && obscuringWidget != null) {
        // Use obscuring widget
        content = obscuringWidget!;
      } else {
        // Use character (obscured or plain)
        final char = showObscured ? obscuringCharacter : text[index];
        final style = textStyle;
        content = textGradient != null
            ? Gradiented(
                gradient: textGradient!,
                child: Text(
                  char,
                  key: ValueKey(char + index.toString()),
                  style: style.copyWith(color: Colors.white),
                ),
              )
            : Text(
                char,
                key: ValueKey(char + index.toString()),
                style: style,
              );
      }
    } else if (isSelected && showCursor && !readOnly) {
      // Show cursor
      final cursorColorValue = cursorColor ??
          Theme.of(context).textSelectionTheme.cursorColor ??
          Theme.of(context).colorScheme.secondary;
      final cursorHeightValue = cursorHeight ?? textStyle.fontSize! + 8;

      content = Center(
        child: Container(
          width: cursorWidth,
          height: cursorHeightValue,
          color: cursorColorValue,
        ),
      );
    } else if (hintCharacter != null) {
      // Show hint character
      content = Text(
        hintCharacter!,
        key: ValueKey('hint_$index'),
        style: hintStyle,
      );
    } else {
      // Empty cell
      content = Text('', key: ValueKey('empty_$index'));
    }

    // Apply animation transition
    return AnimatedSwitcher(
      duration: animationDuration,
      switchInCurve: animationCurve,
      switchOutCurve: animationCurve,
      transitionBuilder: (child, animation) {
        if (animationType == AnimationType.scale) {
          return ScaleTransition(scale: animation, child: child);
        } else if (animationType == AnimationType.fade) {
          return FadeTransition(opacity: animation, child: child);
        } else if (animationType == AnimationType.none) {
          return child;
        } else {
          // Slide is default
          return SlideTransition(
            position:
                Tween<Offset>(begin: const Offset(0, .5), end: Offset.zero)
                    .animate(animation),
            child: child,
          );
        }
      },
      child: content,
    );
  }
}
