import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../theme/liquid_glass_pin_theme.dart';

/// Renders PIN cells inside a single unified glass container with dividers.
class UnifiedGlassCell extends StatelessWidget {
  const UnifiedGlassCell({
    super.key,
    required this.cells,
    required this.theme,
    required this.resolvedTheme,
    required this.obscureText,
    required this.obscuringCharacter,
    this.obscuringWidget,
  });

  final List<PinCellData> cells;
  final UnifiedGlassTheme theme;
  final ResolvedLiquidGlassTheme resolvedTheme;
  final bool obscureText;
  final String obscuringCharacter;
  final Widget? obscuringWidget;

  @override
  Widget build(BuildContext context) {
    // Determine glow color based on overall state
    Color? glowColor;
    final hasError = cells.any((c) => c.isError);
    final hasFocus = cells.any((c) => c.isFocused);

    if (hasError) {
      glowColor = resolvedTheme.errorGlowColor;
    } else if (hasFocus && resolvedTheme.enableGlowOnFocus) {
      glowColor = resolvedTheme.focusedGlowColor;
    }

    // Calculate total width
    final totalWidth = (resolvedTheme.cellSize.width * cells.length) +
        (theme.dividerWidth * (cells.length - 1)) +
        theme.containerPadding.horizontal;

    Widget container = LiquidGlass(
      shape:
          LiquidRoundedSuperellipse(borderRadius: theme.containerBorderRadius),
      child: SizedBox(
        width: totalWidth,
        height: resolvedTheme.cellSize.height,
        child: Padding(
          padding: theme.containerPadding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < cells.length; i++) ...[
                _UnifiedCellContent(
                  data: cells[i],
                  theme: theme,
                  resolvedTheme: resolvedTheme,
                  obscureText: obscureText,
                  obscuringCharacter: obscuringCharacter,
                  obscuringWidget: obscuringWidget,
                ),
                if (i < cells.length - 1)
                  _Divider(
                    width: theme.dividerWidth,
                    color: theme.dividerColor ??
                        resolvedTheme.glassColor.withValues(alpha: 0.3),
                  ),
              ],
            ],
          ),
        ),
      ),
    );

    // Add glow effect if needed
    if (glowColor != null) {
      container = GlassGlow(
        glowColor: glowColor,
        glowRadius: resolvedTheme.glowRadius,
        child: container,
      );
    }

    return container;
  }
}

class _UnifiedCellContent extends StatelessWidget {
  const _UnifiedCellContent({
    required this.data,
    required this.theme,
    required this.resolvedTheme,
    required this.obscureText,
    required this.obscuringCharacter,
    this.obscuringWidget,
  });

  final PinCellData data;
  final UnifiedGlassTheme theme;
  final ResolvedLiquidGlassTheme resolvedTheme;
  final bool obscureText;
  final String obscuringCharacter;
  final Widget? obscuringWidget;

  @override
  Widget build(BuildContext context) {
    Widget content = SizedBox(
      width: resolvedTheme.cellSize.width,
      height: resolvedTheme.cellSize.height,
      child: Center(
        child: _buildContent(),
      ),
    );

    // Add stretch animation if enabled
    if (resolvedTheme.enableStretchAnimation && data.wasJustEntered) {
      content = LiquidStretch(
        interactionScale: resolvedTheme.stretchInteractionScale,
        stretch: resolvedTheme.stretchAmount,
        resistance: resolvedTheme.stretchResistance,
        child: content,
      );
    }

    return content;
  }

  Widget _buildContent() {
    if (!data.isFilled) {
      // Show cursor for focused empty cell (if enabled)
      if (data.isFocused && resolvedTheme.showCursor) {
        return _buildCursor();
      }
      return const SizedBox.shrink();
    }

    // Show character or obscured content
    final displayText = obscureText && !data.isBlinking
        ? obscuringCharacter
        : data.character ?? '';

    if (obscureText && !data.isBlinking && obscuringWidget != null) {
      return obscuringWidget!;
    }

    return AnimatedSwitcher(
      duration: resolvedTheme.animationDuration,
      switchInCurve: resolvedTheme.animationCurve,
      child: Text(
        displayText,
        key: ValueKey(displayText),
        style: resolvedTheme.textStyle,
      ),
    );
  }

  Widget _buildCursor() {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        width: 2,
        height: resolvedTheme.cellSize.height * 0.4,
        decoration: BoxDecoration(
          color: resolvedTheme.textStyle.color,
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    required this.width,
    required this.color,
  });

  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: color,
    );
  }
}
