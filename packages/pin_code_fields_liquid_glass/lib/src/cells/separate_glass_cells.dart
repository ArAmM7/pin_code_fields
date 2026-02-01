import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../theme/liquid_glass_pin_theme.dart';

/// Renders PIN cells as separate individual glass shapes.
class SeparateGlassCells extends StatelessWidget {
  const SeparateGlassCells({
    super.key,
    required this.cells,
    required this.theme,
    required this.resolvedTheme,
    required this.obscureText,
    required this.obscuringCharacter,
    this.obscuringWidget,
  });

  final List<PinCellData> cells;
  final SeparateGlassTheme theme;
  final ResolvedLiquidGlassTheme resolvedTheme;
  final bool obscureText;
  final String obscuringCharacter;
  final Widget? obscuringWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < cells.length; i++) ...[
          _SeparateGlassCell(
            data: cells[i],
            theme: theme,
            resolvedTheme: resolvedTheme,
            obscureText: obscureText,
            obscuringCharacter: obscuringCharacter,
            obscuringWidget: obscuringWidget,
          ),
          if (i < cells.length - 1) SizedBox(width: theme.spacing),
        ],
      ],
    );
  }
}

class _SeparateGlassCell extends StatelessWidget {
  const _SeparateGlassCell({
    required this.data,
    required this.theme,
    required this.resolvedTheme,
    required this.obscureText,
    required this.obscuringCharacter,
    this.obscuringWidget,
  });

  final PinCellData data;
  final SeparateGlassTheme theme;
  final ResolvedLiquidGlassTheme resolvedTheme;
  final bool obscureText;
  final String obscuringCharacter;
  final Widget? obscuringWidget;

  @override
  Widget build(BuildContext context) {
    // Determine glow color based on state
    Color? glowColor;
    if (data.isError) {
      glowColor = resolvedTheme.errorGlowColor;
    } else if (data.isFocused && resolvedTheme.enableGlowOnFocus) {
      glowColor = resolvedTheme.focusedGlowColor;
    } else if (data.isFilled) {
      glowColor = resolvedTheme.filledGlowColor;
    }

    Widget cell = LiquidGlass(
      shape: LiquidRoundedSuperellipse(borderRadius: theme.borderRadius),
      child: SizedBox(
        width: resolvedTheme.cellSize.width,
        height: resolvedTheme.cellSize.height,
        child: Center(
          child: _buildContent(),
        ),
      ),
    );

    // Add glow effect if enabled
    if (glowColor != null && theme.glowPerCell) {
      cell = GlassGlow(
        glowColor: glowColor,
        glowRadius: resolvedTheme.glowRadius,
        child: cell,
      );
    }

    // Add stretch animation if enabled
    if (resolvedTheme.enableStretchAnimation && data.wasJustEntered) {
      cell = LiquidStretch(
        interactionScale: resolvedTheme.stretchInteractionScale,
        stretch: resolvedTheme.stretchAmount,
        resistance: resolvedTheme.stretchResistance,
        child: cell,
      );
    }

    return cell;
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
