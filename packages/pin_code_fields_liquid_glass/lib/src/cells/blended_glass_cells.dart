import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../theme/liquid_glass_pin_theme.dart';

/// Renders PIN cells as blended glass shapes (iOS 26 style).
///
/// Uses [LiquidGlassBlendGroup] with [LiquidGlass.grouped] to create
/// seamless blending between cells.
class BlendedGlassCells extends StatelessWidget {
  const BlendedGlassCells({
    super.key,
    required this.cells,
    required this.theme,
    required this.resolvedTheme,
    required this.obscureText,
    required this.obscuringCharacter,
    this.obscuringWidget,
  });

  final List<PinCellData> cells;
  final BlendedGlassTheme theme;
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

    // blend parameter: higher = more blending (e.g., 10-30)
    // blendAmount (0-1) maps to blend (0-30)
    final blendValue = theme.blendAmount * 30;

    Widget blendedCells = LiquidGlassBlendGroup(
      blend: blendValue,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < cells.length; i++)
            _BlendedGlassCell(
              data: cells[i],
              theme: theme,
              resolvedTheme: resolvedTheme,
              obscureText: obscureText,
              obscuringCharacter: obscuringCharacter,
              obscuringWidget: obscuringWidget,
            ),
        ],
      ),
    );

    // Add glow effect if needed
    if (glowColor != null) {
      blendedCells = GlassGlow(
        glowColor: glowColor,
        glowRadius: resolvedTheme.glowRadius,
        child: blendedCells,
      );
    }

    return blendedCells;
  }
}

class _BlendedGlassCell extends StatelessWidget {
  const _BlendedGlassCell({
    required this.data,
    required this.theme,
    required this.resolvedTheme,
    required this.obscureText,
    required this.obscuringCharacter,
    this.obscuringWidget,
  });

  final PinCellData data;
  final BlendedGlassTheme theme;
  final ResolvedLiquidGlassTheme resolvedTheme;
  final bool obscureText;
  final String obscuringCharacter;
  final Widget? obscuringWidget;

  @override
  Widget build(BuildContext context) {
    // Use LiquidGlass.grouped() for blending to work
    Widget cell = LiquidGlass.grouped(
      shape: LiquidRoundedSuperellipse(borderRadius: theme.borderRadius),
      child: SizedBox(
        width: resolvedTheme.cellSize.width,
        height: resolvedTheme.cellSize.height,
        child: Center(
          child: _buildContent(),
        ),
      ),
    );

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
