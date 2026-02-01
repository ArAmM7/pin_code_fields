import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Theme configuration for Liquid Glass PIN fields.
///
/// Use the static constructors to create style-specific themes:
/// - [LiquidGlassPinTheme.separate] - Individual glass cells with spacing
/// - [LiquidGlassPinTheme.unified] - One glass container with dividers
/// - [LiquidGlassPinTheme.blended] - Cells that blend together (iOS-like)
sealed class LiquidGlassPinTheme {
  const LiquidGlassPinTheme({
    // Cell dimensions
    this.cellSize = const Size(56, 64),
    // Glass settings (from LiquidGlassSettings)
    this.blur = 10,
    this.thickness = 20,
    this.glassColor,
    this.visibility = 1.0,
    this.chromaticAberration = 0.01,
    this.lightAngle,
    this.lightIntensity = 0.5,
    this.ambientStrength = 0,
    this.refractiveIndex = 1.2,
    this.saturation = 1.5,
    // Text style
    this.textStyle,
    // Glow settings (from GlassGlow)
    this.glowColor,
    this.focusedGlowColor,
    this.filledGlowColor,
    this.errorGlowColor,
    this.glowRadius = 1.0,
    this.enableGlowOnFocus = true,
    // Stretch settings (from LiquidStretch)
    this.enableStretchAnimation = true,
    this.stretchInteractionScale = 1.05,
    this.stretchAmount = 0.5,
    this.stretchResistance = 0.08,
    // Animation settings
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeOutBack,
    // Cursor
    this.showCursor = true,
  });

  // ============================================================
  // Static constructors for convenience
  // ============================================================

  /// Creates a theme with separate individual glass cells.
  ///
  /// Each cell is an independent glass shape with spacing between them.
  /// Best for: Traditional PIN field look with glass effect.
  static SeparateGlassTheme separate({
    // Cell dimensions
    Size cellSize = const Size(56, 64),
    // Glass settings
    double blur = 10,
    double thickness = 20,
    Color? glassColor,
    double visibility = 1.0,
    double chromaticAberration = 0.01,
    double? lightAngle,
    double lightIntensity = 0.5,
    double ambientStrength = 0,
    double refractiveIndex = 1.2,
    double saturation = 1.5,
    // Text style
    TextStyle? textStyle,
    // Glow settings
    Color? glowColor,
    Color? focusedGlowColor,
    Color? filledGlowColor,
    Color? errorGlowColor,
    double glowRadius = 1.0,
    bool enableGlowOnFocus = true,
    // Stretch settings
    bool enableStretchAnimation = true,
    double stretchInteractionScale = 1.05,
    double stretchAmount = 0.5,
    double stretchResistance = 0.08,
    // Animation settings
    Duration animationDuration = const Duration(milliseconds: 200),
    Curve animationCurve = Curves.easeOutBack,
    // Cursor
    bool showCursor = true,
    // Separate-specific
    double spacing = 8,
    double borderRadius = 12,
    bool glowPerCell = true,
  }) {
    return SeparateGlassTheme(
      cellSize: cellSize,
      blur: blur,
      thickness: thickness,
      glassColor: glassColor,
      visibility: visibility,
      chromaticAberration: chromaticAberration,
      lightAngle: lightAngle,
      lightIntensity: lightIntensity,
      ambientStrength: ambientStrength,
      refractiveIndex: refractiveIndex,
      saturation: saturation,
      textStyle: textStyle,
      glowColor: glowColor,
      focusedGlowColor: focusedGlowColor,
      filledGlowColor: filledGlowColor,
      errorGlowColor: errorGlowColor,
      glowRadius: glowRadius,
      enableGlowOnFocus: enableGlowOnFocus,
      enableStretchAnimation: enableStretchAnimation,
      stretchInteractionScale: stretchInteractionScale,
      stretchAmount: stretchAmount,
      stretchResistance: stretchResistance,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      showCursor: showCursor,
      spacing: spacing,
      borderRadius: borderRadius,
      glowPerCell: glowPerCell,
    );
  }

  /// Creates a theme with one unified glass container.
  ///
  /// All cells are inside a single glass shape with internal dividers.
  /// Best for: Clean, minimal look.
  static UnifiedGlassTheme unified({
    // Cell dimensions
    Size cellSize = const Size(56, 64),
    // Glass settings
    double blur = 10,
    double thickness = 20,
    Color? glassColor,
    double visibility = 1.0,
    double chromaticAberration = 0.01,
    double? lightAngle,
    double lightIntensity = 0.5,
    double ambientStrength = 0,
    double refractiveIndex = 1.2,
    double saturation = 1.5,
    // Text style
    TextStyle? textStyle,
    // Glow settings
    Color? glowColor,
    Color? focusedGlowColor,
    Color? filledGlowColor,
    Color? errorGlowColor,
    double glowRadius = 1.0,
    bool enableGlowOnFocus = true,
    // Stretch settings
    bool enableStretchAnimation = true,
    double stretchInteractionScale = 1.05,
    double stretchAmount = 0.5,
    double stretchResistance = 0.08,
    // Animation settings
    Duration animationDuration = const Duration(milliseconds: 200),
    Curve animationCurve = Curves.easeOutBack,
    // Cursor
    bool showCursor = true,
    // Unified-specific
    double dividerWidth = 1,
    Color? dividerColor,
    double containerBorderRadius = 16,
    EdgeInsets containerPadding = const EdgeInsets.symmetric(horizontal: 4),
  }) {
    return UnifiedGlassTheme(
      cellSize: cellSize,
      blur: blur,
      thickness: thickness,
      glassColor: glassColor,
      visibility: visibility,
      chromaticAberration: chromaticAberration,
      lightAngle: lightAngle,
      lightIntensity: lightIntensity,
      ambientStrength: ambientStrength,
      refractiveIndex: refractiveIndex,
      saturation: saturation,
      textStyle: textStyle,
      glowColor: glowColor,
      focusedGlowColor: focusedGlowColor,
      filledGlowColor: filledGlowColor,
      errorGlowColor: errorGlowColor,
      glowRadius: glowRadius,
      enableGlowOnFocus: enableGlowOnFocus,
      enableStretchAnimation: enableStretchAnimation,
      stretchInteractionScale: stretchInteractionScale,
      stretchAmount: stretchAmount,
      stretchResistance: stretchResistance,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      showCursor: showCursor,
      dividerWidth: dividerWidth,
      dividerColor: dividerColor,
      containerBorderRadius: containerBorderRadius,
      containerPadding: containerPadding,
    );
  }

  /// Creates a theme with blended glass cells (iOS 26 style).
  ///
  /// Cells blend together using LiquidGlassBlendGroup.
  /// Best for: Modern iOS 26 aesthetic.
  static BlendedGlassTheme blended({
    // Cell dimensions
    Size cellSize = const Size(56, 64),
    // Glass settings
    double blur = 10,
    double thickness = 20,
    Color? glassColor,
    double visibility = 1.0,
    double chromaticAberration = 0.01,
    double? lightAngle,
    double lightIntensity = 0.5,
    double ambientStrength = 0,
    double refractiveIndex = 1.2,
    double saturation = 1.5,
    // Text style
    TextStyle? textStyle,
    // Glow settings
    Color? glowColor,
    Color? focusedGlowColor,
    Color? filledGlowColor,
    Color? errorGlowColor,
    double glowRadius = 1.0,
    bool enableGlowOnFocus = true,
    // Stretch settings
    bool enableStretchAnimation = true,
    double stretchInteractionScale = 1.05,
    double stretchAmount = 0.5,
    double stretchResistance = 0.08,
    // Animation settings
    Duration animationDuration = const Duration(milliseconds: 200),
    Curve animationCurve = Curves.easeOutBack,
    // Cursor
    bool showCursor = true,
    // Blended-specific
    double blendAmount = 0.3,
    double borderRadius = 12,
    double overlapOffset = 0,
  }) {
    return BlendedGlassTheme(
      cellSize: cellSize,
      blur: blur,
      thickness: thickness,
      glassColor: glassColor,
      visibility: visibility,
      chromaticAberration: chromaticAberration,
      lightAngle: lightAngle,
      lightIntensity: lightIntensity,
      ambientStrength: ambientStrength,
      refractiveIndex: refractiveIndex,
      saturation: saturation,
      textStyle: textStyle,
      glowColor: glowColor,
      focusedGlowColor: focusedGlowColor,
      filledGlowColor: filledGlowColor,
      errorGlowColor: errorGlowColor,
      glowRadius: glowRadius,
      enableGlowOnFocus: enableGlowOnFocus,
      enableStretchAnimation: enableStretchAnimation,
      stretchInteractionScale: stretchInteractionScale,
      stretchAmount: stretchAmount,
      stretchResistance: stretchResistance,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      showCursor: showCursor,
      blendAmount: blendAmount,
      borderRadius: borderRadius,
      overlapOffset: overlapOffset,
    );
  }

  // ============================================================
  // Common properties - Cell dimensions
  // ============================================================

  /// Size of each PIN cell.
  final Size cellSize;

  // ============================================================
  // Common properties - Glass settings (LiquidGlassSettings)
  // ============================================================

  /// Blur intensity for the glass effect (frosted appearance).
  ///
  /// Higher values create a more frosted appearance.
  /// Defaults to 10.
  final double blur;

  /// Thickness of the glass surface.
  ///
  /// Thicker surfaces refract the light more intensely.
  /// Defaults to 20.
  final double thickness;

  /// Base color tint of the glass.
  ///
  /// Opacity defines the intensity of the tint.
  /// If null, uses a semi-transparent white based on brightness.
  final Color? glassColor;

  /// A factor that scales all thickness-related properties.
  ///
  /// Useful for animating the glass effect in/out.
  /// Defaults to 1.0.
  final double visibility;

  /// Chromatic aberration (color fringe) intensity.
  ///
  /// Higher values create more pronounced color fringes at edges.
  /// Defaults to 0.01.
  final double chromaticAberration;

  /// Angle of the virtual light source in radians.
  ///
  /// Determines where the highlights on shapes will come from.
  /// If null, defaults to 0.5 * pi (90 degrees, from top).
  final double? lightAngle;

  /// Intensity of the light source highlights.
  ///
  /// Higher values create more pronounced highlights.
  /// Defaults to 0.5.
  final double lightIntensity;

  /// Strength of the ambient light.
  ///
  /// Higher values create more pronounced ambient lighting.
  /// Defaults to 0.
  final double ambientStrength;

  /// Refractive index of the glass material.
  ///
  /// Higher values create more pronounced refraction.
  /// 1.0 = no refraction, ~1.5 = realistic glass.
  /// Defaults to 1.2.
  final double refractiveIndex;

  /// Saturation adjustment for pixels shining through the glass.
  ///
  /// 1.0 = no change, <1.0 = desaturate, >1.0 = increase saturation.
  /// Defaults to 1.5.
  final double saturation;

  // ============================================================
  // Common properties - Text style
  // ============================================================

  /// Text style for PIN characters.
  final TextStyle? textStyle;

  // ============================================================
  // Common properties - Glow settings (GlassGlow)
  // ============================================================

  /// Base glow color for glass effect.
  final Color? glowColor;

  /// Glow color when cell is focused.
  final Color? focusedGlowColor;

  /// Glow color when cell is filled.
  final Color? filledGlowColor;

  /// Glow color when in error state.
  final Color? errorGlowColor;

  /// Radius of the glow effect relative to the cell's shortest side.
  ///
  /// A value of 1.0 means the glow radius equals the shortest dimension.
  /// Defaults to 1.0.
  final double glowRadius;

  /// Whether to show glow effect on focused cell.
  final bool enableGlowOnFocus;

  // ============================================================
  // Common properties - Stretch settings (LiquidStretch)
  // ============================================================

  /// Whether to use stretch animation on character entry.
  final bool enableStretchAnimation;

  /// Scale factor when user interacts with the cell.
  ///
  /// 1.0 = no scaling, >1.0 = grow, <1.0 = shrink.
  /// Defaults to 1.05.
  final double stretchInteractionScale;

  /// Factor for the stretch effect magnitude.
  ///
  /// 0.0 = no stretch, 1.0 = stretch matches drag offset exactly.
  /// Defaults to 0.5.
  final double stretchAmount;

  /// Resistance factor for the drag/stretch effect.
  ///
  /// Higher values make the stretch feel more "sticky".
  /// Defaults to 0.08.
  final double stretchResistance;

  // ============================================================
  // Common properties - Animation settings
  // ============================================================

  /// Duration of entry animations.
  final Duration animationDuration;

  /// Curve for entry animations.
  final Curve animationCurve;

  // ============================================================
  // Common properties - Cursor
  // ============================================================

  /// Whether to show the cursor in focused empty cells.
  final bool showCursor;

  // ============================================================
  // Resolve method
  // ============================================================

  /// Resolves colors with fallbacks based on context.
  ResolvedLiquidGlassTheme resolve(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;

    final defaultGlassColor = brightness == Brightness.light
        ? Colors.white.withValues(alpha: 0.25)
        : Colors.white.withValues(alpha: 0.15);

    return ResolvedLiquidGlassTheme(
      // Cell dimensions
      cellSize: cellSize,
      // Glass settings
      blur: blur,
      thickness: thickness,
      glassColor: glassColor ?? defaultGlassColor,
      visibility: visibility,
      chromaticAberration: chromaticAberration,
      lightAngle: lightAngle ?? 0.5 * math.pi,
      lightIntensity: lightIntensity,
      ambientStrength: ambientStrength,
      refractiveIndex: refractiveIndex,
      saturation: saturation,
      // Text style
      textStyle: textStyle ??
          TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
      // Glow settings
      glowColor: glowColor ?? colorScheme.primary.withValues(alpha: 0.3),
      focusedGlowColor:
          focusedGlowColor ?? colorScheme.primary.withValues(alpha: 0.5),
      filledGlowColor:
          filledGlowColor ?? colorScheme.primary.withValues(alpha: 0.2),
      errorGlowColor:
          errorGlowColor ?? colorScheme.error.withValues(alpha: 0.5),
      glowRadius: glowRadius,
      enableGlowOnFocus: enableGlowOnFocus,
      // Stretch settings
      enableStretchAnimation: enableStretchAnimation,
      stretchInteractionScale: stretchInteractionScale,
      stretchAmount: stretchAmount,
      stretchResistance: stretchResistance,
      // Animation settings
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      // Cursor
      showCursor: showCursor,
    );
  }
}

/// Theme for separate individual glass cells.
class SeparateGlassTheme extends LiquidGlassPinTheme {
  const SeparateGlassTheme({
    super.cellSize,
    super.blur,
    super.thickness,
    super.glassColor,
    super.visibility,
    super.chromaticAberration,
    super.lightAngle,
    super.lightIntensity,
    super.ambientStrength,
    super.refractiveIndex,
    super.saturation,
    super.textStyle,
    super.glowColor,
    super.focusedGlowColor,
    super.filledGlowColor,
    super.errorGlowColor,
    super.glowRadius,
    super.enableGlowOnFocus,
    super.enableStretchAnimation,
    super.stretchInteractionScale,
    super.stretchAmount,
    super.stretchResistance,
    super.animationDuration,
    super.animationCurve,
    super.showCursor,
    this.spacing = 8,
    this.borderRadius = 12,
    this.glowPerCell = true,
  });

  /// Spacing between cells.
  final double spacing;

  /// Border radius of each cell.
  final double borderRadius;

  /// Whether each cell has its own glow, or glow is shared.
  final bool glowPerCell;
}

/// Theme for unified glass container with dividers.
class UnifiedGlassTheme extends LiquidGlassPinTheme {
  const UnifiedGlassTheme({
    super.cellSize,
    super.blur,
    super.thickness,
    super.glassColor,
    super.visibility,
    super.chromaticAberration,
    super.lightAngle,
    super.lightIntensity,
    super.ambientStrength,
    super.refractiveIndex,
    super.saturation,
    super.textStyle,
    super.glowColor,
    super.focusedGlowColor,
    super.filledGlowColor,
    super.errorGlowColor,
    super.glowRadius,
    super.enableGlowOnFocus,
    super.enableStretchAnimation,
    super.stretchInteractionScale,
    super.stretchAmount,
    super.stretchResistance,
    super.animationDuration,
    super.animationCurve,
    super.showCursor,
    this.dividerWidth = 1,
    this.dividerColor,
    this.containerBorderRadius = 16,
    this.containerPadding = const EdgeInsets.symmetric(horizontal: 4),
  });

  /// Width of dividers between cells.
  final double dividerWidth;

  /// Color of dividers. If null, uses a semi-transparent version of glass color.
  final Color? dividerColor;

  /// Border radius of the outer container.
  final double containerBorderRadius;

  /// Padding inside the container.
  final EdgeInsets containerPadding;
}

/// Theme for blended glass cells (iOS 26 style).
class BlendedGlassTheme extends LiquidGlassPinTheme {
  const BlendedGlassTheme({
    super.cellSize,
    super.blur,
    super.thickness,
    super.glassColor,
    super.visibility,
    super.chromaticAberration,
    super.lightAngle,
    super.lightIntensity,
    super.ambientStrength,
    super.refractiveIndex,
    super.saturation,
    super.textStyle,
    super.glowColor,
    super.focusedGlowColor,
    super.filledGlowColor,
    super.errorGlowColor,
    super.glowRadius,
    super.enableGlowOnFocus,
    super.enableStretchAnimation,
    super.stretchInteractionScale,
    super.stretchAmount,
    super.stretchResistance,
    super.animationDuration,
    super.animationCurve,
    super.showCursor,
    this.blendAmount = 0.3,
    this.borderRadius = 12,
    this.overlapOffset = 0,
  });

  /// How much cells blend together (0.0 to 1.0).
  /// Higher values create more seamless blending.
  final double blendAmount;

  /// Border radius of each cell.
  final double borderRadius;

  /// Overlap offset between cells. Negative values create gaps.
  final double overlapOffset;
}

/// Resolved theme with all colors computed.
class ResolvedLiquidGlassTheme {
  const ResolvedLiquidGlassTheme({
    // Cell dimensions
    required this.cellSize,
    // Glass settings
    required this.blur,
    required this.thickness,
    required this.glassColor,
    required this.visibility,
    required this.chromaticAberration,
    required this.lightAngle,
    required this.lightIntensity,
    required this.ambientStrength,
    required this.refractiveIndex,
    required this.saturation,
    // Text style
    required this.textStyle,
    // Glow settings
    required this.glowColor,
    required this.focusedGlowColor,
    required this.filledGlowColor,
    required this.errorGlowColor,
    required this.glowRadius,
    required this.enableGlowOnFocus,
    // Stretch settings
    required this.enableStretchAnimation,
    required this.stretchInteractionScale,
    required this.stretchAmount,
    required this.stretchResistance,
    // Animation settings
    required this.animationDuration,
    required this.animationCurve,
    // Cursor
    required this.showCursor,
  });

  // Cell dimensions
  final Size cellSize;

  // Glass settings
  final double blur;
  final double thickness;
  final Color glassColor;
  final double visibility;
  final double chromaticAberration;
  final double lightAngle;
  final double lightIntensity;
  final double ambientStrength;
  final double refractiveIndex;
  final double saturation;

  // Text style
  final TextStyle textStyle;

  // Glow settings
  final Color glowColor;
  final Color focusedGlowColor;
  final Color filledGlowColor;
  final Color errorGlowColor;
  final double glowRadius;
  final bool enableGlowOnFocus;

  // Stretch settings
  final bool enableStretchAnimation;
  final double stretchInteractionScale;
  final double stretchAmount;
  final double stretchResistance;

  // Animation settings
  final Duration animationDuration;
  final Curve animationCurve;

  // Cursor
  final bool showCursor;
}
