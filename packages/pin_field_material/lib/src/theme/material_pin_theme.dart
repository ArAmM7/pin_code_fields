import 'package:flutter/material.dart';

/// Shape variants for Material PIN cells.
enum MaterialPinShape {
  /// Cell with border on all sides (rectangular).
  outlined,

  /// Cell with solid fill color (no border).
  filled,

  /// Cell with only a bottom border.
  underlined,

  /// Circular cell.
  circle,
}

/// Animation types for PIN cell entry.
enum MaterialPinAnimation {
  /// Scale animation on character entry.
  scale,

  /// Fade animation on character entry.
  fade,

  /// Slide up animation on character entry.
  slide,

  /// No animation.
  none,
}

/// Theme configuration for Material Design PIN fields.
///
/// This class provides all the styling options needed to customize the
/// appearance of PIN input cells. Colors that are not explicitly set
/// will be resolved from the current [ColorScheme].
///
/// Example:
/// ```dart
/// MaterialPinTheme(
///   shape: MaterialPinShape.outlined,
///   cellSize: Size(56, 64),
///   borderRadius: BorderRadius.circular(12),
///   borderColor: Colors.grey,
///   focusedBorderColor: Colors.blue,
/// )
/// ```
@immutable
class MaterialPinTheme {
  const MaterialPinTheme({
    this.shape = MaterialPinShape.outlined,
    this.cellSize = const Size(48, 56),
    this.spacing = 8,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.borderWidth = 1.5,
    this.focusedBorderWidth = 2.0,
    // Colors (nullable = use ColorScheme)
    this.fillColor,
    this.focusedFillColor,
    this.filledFillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.filledBorderColor,
    this.errorColor,
    this.disabledColor,
    // Text
    this.textStyle,
    this.obscuringCharacter = '●',
    // Cursor
    this.cursorColor,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.showCursor = true,
    this.animateCursor = true,
    this.cursorBlinkDuration = const Duration(milliseconds: 500),
    // Shadows
    this.elevation = 0,
    this.focusedElevation = 0,
    this.boxShadows,
    this.focusedBoxShadows,
    // Animations
    this.entryAnimation = MaterialPinAnimation.scale,
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeOut,
    // Error animation
    this.errorAnimationDuration = const Duration(milliseconds: 500),
    this.enableErrorShake = true,
  });

  /// The shape of PIN cells.
  final MaterialPinShape shape;

  /// Size of each PIN cell.
  final Size cellSize;

  /// Spacing between cells.
  final double spacing;

  /// Border radius for cells (ignored for underlined shape).
  final BorderRadius borderRadius;

  /// Border width for unfocused cells.
  final double borderWidth;

  /// Border width for focused cell.
  final double focusedBorderWidth;

  /// Fill color for empty cells.
  final Color? fillColor;

  /// Fill color for focused cell.
  final Color? focusedFillColor;

  /// Fill color for filled cells.
  final Color? filledFillColor;

  /// Border color for empty cells.
  final Color? borderColor;

  /// Border color for focused cell.
  final Color? focusedBorderColor;

  /// Border color for filled cells.
  final Color? filledBorderColor;

  /// Color used for error states.
  final Color? errorColor;

  /// Color used for disabled state.
  final Color? disabledColor;

  /// Text style for PIN characters.
  final TextStyle? textStyle;

  /// Character used to obscure text.
  final String obscuringCharacter;

  /// Cursor color.
  final Color? cursorColor;

  /// Cursor width.
  final double cursorWidth;

  /// Cursor height (defaults to textStyle.fontSize + 8).
  final double? cursorHeight;

  /// Whether to show the cursor.
  final bool showCursor;

  /// Whether to animate the cursor blinking.
  final bool animateCursor;

  /// Duration of one cursor blink cycle.
  final Duration cursorBlinkDuration;

  /// Elevation for cells.
  final double elevation;

  /// Elevation for focused cell.
  final double focusedElevation;

  /// Box shadows for cells.
  final List<BoxShadow>? boxShadows;

  /// Box shadows for focused cell.
  final List<BoxShadow>? focusedBoxShadows;

  /// Entry animation type.
  final MaterialPinAnimation entryAnimation;

  /// Duration for animations.
  final Duration animationDuration;

  /// Curve for animations.
  final Curve animationCurve;

  /// Duration for error shake animation.
  final Duration errorAnimationDuration;

  /// Whether to enable shake animation on error.
  final bool enableErrorShake;

  /// Creates a copy of this theme with the given fields replaced.
  MaterialPinTheme copyWith({
    MaterialPinShape? shape,
    Size? cellSize,
    double? spacing,
    BorderRadius? borderRadius,
    double? borderWidth,
    double? focusedBorderWidth,
    Color? fillColor,
    Color? focusedFillColor,
    Color? filledFillColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? filledBorderColor,
    Color? errorColor,
    Color? disabledColor,
    TextStyle? textStyle,
    String? obscuringCharacter,
    Color? cursorColor,
    double? cursorWidth,
    double? cursorHeight,
    bool? showCursor,
    bool? animateCursor,
    Duration? cursorBlinkDuration,
    double? elevation,
    double? focusedElevation,
    List<BoxShadow>? boxShadows,
    List<BoxShadow>? focusedBoxShadows,
    MaterialPinAnimation? entryAnimation,
    Duration? animationDuration,
    Curve? animationCurve,
    Duration? errorAnimationDuration,
    bool? enableErrorShake,
  }) {
    return MaterialPinTheme(
      shape: shape ?? this.shape,
      cellSize: cellSize ?? this.cellSize,
      spacing: spacing ?? this.spacing,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      focusedBorderWidth: focusedBorderWidth ?? this.focusedBorderWidth,
      fillColor: fillColor ?? this.fillColor,
      focusedFillColor: focusedFillColor ?? this.focusedFillColor,
      filledFillColor: filledFillColor ?? this.filledFillColor,
      borderColor: borderColor ?? this.borderColor,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      filledBorderColor: filledBorderColor ?? this.filledBorderColor,
      errorColor: errorColor ?? this.errorColor,
      disabledColor: disabledColor ?? this.disabledColor,
      textStyle: textStyle ?? this.textStyle,
      obscuringCharacter: obscuringCharacter ?? this.obscuringCharacter,
      cursorColor: cursorColor ?? this.cursorColor,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      showCursor: showCursor ?? this.showCursor,
      animateCursor: animateCursor ?? this.animateCursor,
      cursorBlinkDuration: cursorBlinkDuration ?? this.cursorBlinkDuration,
      elevation: elevation ?? this.elevation,
      focusedElevation: focusedElevation ?? this.focusedElevation,
      boxShadows: boxShadows ?? this.boxShadows,
      focusedBoxShadows: focusedBoxShadows ?? this.focusedBoxShadows,
      entryAnimation: entryAnimation ?? this.entryAnimation,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      errorAnimationDuration:
          errorAnimationDuration ?? this.errorAnimationDuration,
      enableErrorShake: enableErrorShake ?? this.enableErrorShake,
    );
  }

  /// Resolves this theme with the given [BuildContext] to get actual colors.
  ///
  /// This method fills in any null color values from the current [ColorScheme].
  MaterialPinThemeData resolve(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return MaterialPinThemeData(
      shape: shape,
      cellSize: cellSize,
      spacing: spacing,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      focusedBorderWidth: focusedBorderWidth,
      fillColor: fillColor ?? colorScheme.surfaceContainerHighest,
      focusedFillColor: focusedFillColor ?? colorScheme.primaryContainer,
      filledFillColor: filledFillColor ?? colorScheme.surfaceContainerHighest,
      borderColor: borderColor ?? colorScheme.outline,
      focusedBorderColor: focusedBorderColor ?? colorScheme.primary,
      filledBorderColor: filledBorderColor ?? colorScheme.outline,
      errorColor: errorColor ?? colorScheme.error,
      disabledColor: disabledColor ?? colorScheme.onSurface.withValues(alpha: 0.38),
      textStyle: textStyle ?? textTheme.headlineSmall,
      obscuringCharacter: obscuringCharacter,
      cursorColor: cursorColor ?? colorScheme.primary,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      showCursor: showCursor,
      animateCursor: animateCursor,
      cursorBlinkDuration: cursorBlinkDuration,
      elevation: elevation,
      focusedElevation: focusedElevation,
      boxShadows: boxShadows,
      focusedBoxShadows: focusedBoxShadows,
      entryAnimation: entryAnimation,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      errorAnimationDuration: errorAnimationDuration,
      enableErrorShake: enableErrorShake,
    );
  }
}

/// Resolved theme data with all colors filled in.
///
/// This is the result of calling [MaterialPinTheme.resolve] and contains
/// non-nullable color values ready for use in widgets.
@immutable
class MaterialPinThemeData {
  const MaterialPinThemeData({
    required this.shape,
    required this.cellSize,
    required this.spacing,
    required this.borderRadius,
    required this.borderWidth,
    required this.focusedBorderWidth,
    required this.fillColor,
    required this.focusedFillColor,
    required this.filledFillColor,
    required this.borderColor,
    required this.focusedBorderColor,
    required this.filledBorderColor,
    required this.errorColor,
    required this.disabledColor,
    required this.textStyle,
    required this.obscuringCharacter,
    required this.cursorColor,
    required this.cursorWidth,
    required this.cursorHeight,
    required this.showCursor,
    required this.animateCursor,
    required this.cursorBlinkDuration,
    required this.elevation,
    required this.focusedElevation,
    required this.boxShadows,
    required this.focusedBoxShadows,
    required this.entryAnimation,
    required this.animationDuration,
    required this.animationCurve,
    required this.errorAnimationDuration,
    required this.enableErrorShake,
  });

  final MaterialPinShape shape;
  final Size cellSize;
  final double spacing;
  final BorderRadius borderRadius;
  final double borderWidth;
  final double focusedBorderWidth;
  final Color fillColor;
  final Color focusedFillColor;
  final Color filledFillColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color filledBorderColor;
  final Color errorColor;
  final Color disabledColor;
  final TextStyle? textStyle;
  final String obscuringCharacter;
  final Color cursorColor;
  final double cursorWidth;
  final double? cursorHeight;
  final bool showCursor;
  final bool animateCursor;
  final Duration cursorBlinkDuration;
  final double elevation;
  final double focusedElevation;
  final List<BoxShadow>? boxShadows;
  final List<BoxShadow>? focusedBoxShadows;
  final MaterialPinAnimation entryAnimation;
  final Duration animationDuration;
  final Curve animationCurve;
  final Duration errorAnimationDuration;
  final bool enableErrorShake;
}
