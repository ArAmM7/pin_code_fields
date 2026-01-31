import 'package:flutter/material.dart';
import 'package:pin_field_core/pin_field_core.dart';

import '../animations/cursor_blink.dart';
import '../animations/entry_animations.dart';
import '../theme/material_pin_theme.dart';

/// Widget that renders the content inside a PIN cell.
///
/// This handles displaying the character, cursor, or empty state
/// with appropriate animations.
class MaterialCellContent extends StatelessWidget {
  const MaterialCellContent({
    super.key,
    required this.data,
    required this.theme,
    this.obscureText = false,
    this.obscuringWidget,
    this.hintCharacter,
    this.hintStyle,
  });

  /// The cell data containing state information.
  final PinCellData data;

  /// The resolved Material theme.
  final MaterialPinThemeData theme;

  /// Whether to obscure the text.
  final bool obscureText;

  /// Custom widget to show when obscuring text.
  final Widget? obscuringWidget;

  /// Hint character to show in empty cells.
  final String? hintCharacter;

  /// Style for hint character.
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    final content = _buildContent(context);

    return AnimatedSwitcher(
      duration: theme.animationDuration,
      switchInCurve: theme.animationCurve,
      switchOutCurve: theme.animationCurve,
      transitionBuilder: getEntryAnimationTransitionBuilder(
        theme.entryAnimation,
        theme.animationCurve,
      ),
      child: content,
    );
  }

  Widget _buildContent(BuildContext context) {
    // Filled cell - show character
    if (data.isFilled) {
      return _buildCharacter(context);
    }

    // Focused cell - show cursor
    if (data.isFocused && theme.showCursor && !data.isDisabled) {
      return _buildCursor(context);
    }

    // Empty cell - show hint or nothing
    if (hintCharacter != null) {
      return _buildHint(context);
    }

    return const SizedBox.shrink(key: ValueKey('empty'));
  }

  Widget _buildCharacter(BuildContext context) {
    // Determine if we should show obscured content
    final shouldObscure = obscureText && !data.isBlinking;

    // Use custom obscuring widget if provided
    if (shouldObscure && obscuringWidget != null) {
      return KeyedSubtree(
        key: ValueKey('obscure_widget_${data.index}'),
        child: obscuringWidget!,
      );
    }

    // Use character (either actual or obscuring character)
    final displayChar =
        shouldObscure ? theme.obscuringCharacter : data.character!;

    Widget textWidget = Text(
      displayChar,
      key: ValueKey('char_${data.index}_$displayChar'),
      style: theme.textStyle,
    );

    // Apply gradient if provided
    if (theme.textGradient != null) {
      textWidget = ShaderMask(
        shaderCallback: (bounds) => theme.textGradient!.createShader(bounds),
        blendMode: BlendMode.srcIn,
        child: textWidget,
      );
    }

    return textWidget;
  }

  Widget _buildCursor(BuildContext context) {
    final cursorHeight = theme.cursorHeight ??
        (theme.textStyle?.fontSize ?? 20) + 8;

    return CursorBlink(
      key: const ValueKey('cursor'),
      color: theme.cursorColor,
      width: theme.cursorWidth,
      height: cursorHeight,
      animate: theme.animateCursor,
      duration: theme.cursorBlinkDuration,
    );
  }

  Widget _buildHint(BuildContext context) {
    final effectiveHintStyle = hintStyle ??
        theme.textStyle?.copyWith(color: theme.disabledColor) ??
        TextStyle(color: theme.disabledColor);

    return Text(
      hintCharacter!,
      key: ValueKey('hint_${data.index}'),
      style: effectiveHintStyle,
    );
  }
}
