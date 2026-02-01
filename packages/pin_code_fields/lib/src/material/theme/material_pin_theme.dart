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

  /// Custom animation provided via [MaterialPinTheme.customEntryAnimationBuilder].
  ///
  /// When using this value, you must provide a [customEntryAnimationBuilder].
  custom,
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
    this.followingFillColor,
    this.followingBorderColor,
    this.completeFillColor,
    this.completeBorderColor,
    this.completeTextStyle,
    this.errorColor,
    this.errorFillColor,
    this.errorBorderColor,
    this.errorBorderWidth,
    this.errorTextStyle,
    this.errorBoxShadows,
    this.disabledColor,
    this.disabledFillColor,
    this.disabledBorderColor,
    this.disabledTextStyle,
    // Text
    this.textStyle,
    this.textGradient,
    this.obscuringCharacter = '●',
    // Hint
    this.hintCharacter,
    this.hintStyle,
    // Cursor
    this.cursorColor,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.showCursor = true,
    this.animateCursor = true,
    this.cursorBlinkDuration = const Duration(milliseconds: 500),
    this.cursorWidget,
    // Shadows
    this.elevation = 0,
    this.focusedElevation = 0,
    this.boxShadows,
    this.focusedBoxShadows,
    // Animations
    this.entryAnimation = MaterialPinAnimation.scale,
    this.customEntryAnimationBuilder,
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeOut,
    // Error animation
    this.errorAnimationDuration = const Duration(milliseconds: 500),
    this.enableErrorShake = true,
  }) : assert(
          entryAnimation != MaterialPinAnimation.custom ||
              customEntryAnimationBuilder != null,
          'customEntryAnimationBuilder must be provided when entryAnimation is MaterialPinAnimation.custom',
        );

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

  /// Fill color for cells that come after the focused cell.
  ///
  /// If not provided, uses [fillColor].
  final Color? followingFillColor;

  /// Border color for cells that come after the focused cell.
  ///
  /// If not provided, uses [borderColor].
  final Color? followingBorderColor;

  /// Fill color for all cells when PIN is complete.
  ///
  /// If not provided, uses [filledFillColor].
  final Color? completeFillColor;

  /// Border color for all cells when PIN is complete.
  ///
  /// If not provided, uses [filledBorderColor].
  final Color? completeBorderColor;

  /// Text style for all cells when PIN is complete.
  ///
  /// If not provided, uses [textStyle].
  final TextStyle? completeTextStyle;

  /// Base color used for error states.
  ///
  /// If [errorFillColor], [errorBorderColor], or [errorTextStyle] are not
  /// provided, they will be derived from this color.
  final Color? errorColor;

  /// Fill color for cells in error state.
  ///
  /// If not provided, defaults to [errorColor] with 10% opacity.
  final Color? errorFillColor;

  /// Border color for cells in error state.
  ///
  /// If not provided, defaults to [errorColor].
  final Color? errorBorderColor;

  /// Border width for cells in error state.
  ///
  /// If not provided, defaults to [focusedBorderWidth] for emphasis.
  final double? errorBorderWidth;

  /// Text style for cells in error state.
  ///
  /// If not provided, defaults to [textStyle] with [errorColor].
  final TextStyle? errorTextStyle;

  /// Box shadows for cells in error state.
  final List<BoxShadow>? errorBoxShadows;

  /// Color used for disabled state.
  ///
  /// This is the base disabled color. If [disabledFillColor], [disabledBorderColor],
  /// or [disabledTextStyle] are not provided, they will be derived from this color.
  final Color? disabledColor;

  /// Fill color for disabled cells.
  ///
  /// If not provided, defaults to [disabledColor] with 10% opacity.
  final Color? disabledFillColor;

  /// Border color for disabled cells.
  ///
  /// If not provided, defaults to [disabledColor].
  final Color? disabledBorderColor;

  /// Text style for disabled cells.
  ///
  /// If not provided, defaults to [textStyle] with [disabledColor].
  final TextStyle? disabledTextStyle;

  /// Text style for PIN characters.
  final TextStyle? textStyle;

  /// Gradient to apply to PIN text.
  ///
  /// When set, the text will be rendered with this gradient using a ShaderMask.
  final Gradient? textGradient;

  /// Character used to obscure text.
  final String obscuringCharacter;

  /// Hint character to show in empty cells.
  ///
  /// If set, this character will be displayed in cells that don't have input yet.
  /// Common uses include showing a dash (-) or dot (•) as a placeholder.
  final String? hintCharacter;

  /// Style for hint character.
  ///
  /// If not provided, will use [textStyle] with reduced opacity.
  final TextStyle? hintStyle;

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

  /// Custom widget to use as cursor.
  ///
  /// When provided, this widget is used instead of the default line cursor.
  /// The widget will be wrapped with the blink animation if [animateCursor] is true.
  final Widget? cursorWidget;

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

  /// Custom entry animation builder.
  ///
  /// When [entryAnimation] is set to [MaterialPinAnimation.custom], this builder
  /// is used to create the transition animation for PIN characters.
  ///
  /// Example:
  /// ```dart
  /// MaterialPinTheme(
  ///   entryAnimation: MaterialPinAnimation.custom,
  ///   customEntryAnimationBuilder: (child, animation) {
  ///     return RotationTransition(
  ///       turns: animation,
  ///       child: FadeTransition(opacity: animation, child: child),
  ///     );
  ///   },
  /// )
  /// ```
  final AnimatedSwitcherTransitionBuilder? customEntryAnimationBuilder;

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
    Color? followingFillColor,
    Color? followingBorderColor,
    Color? completeFillColor,
    Color? completeBorderColor,
    TextStyle? completeTextStyle,
    Color? errorColor,
    Color? errorFillColor,
    Color? errorBorderColor,
    double? errorBorderWidth,
    TextStyle? errorTextStyle,
    List<BoxShadow>? errorBoxShadows,
    Color? disabledColor,
    Color? disabledFillColor,
    Color? disabledBorderColor,
    TextStyle? disabledTextStyle,
    TextStyle? textStyle,
    Gradient? textGradient,
    String? obscuringCharacter,
    String? hintCharacter,
    TextStyle? hintStyle,
    Color? cursorColor,
    double? cursorWidth,
    double? cursorHeight,
    bool? showCursor,
    bool? animateCursor,
    Duration? cursorBlinkDuration,
    Widget? cursorWidget,
    double? elevation,
    double? focusedElevation,
    List<BoxShadow>? boxShadows,
    List<BoxShadow>? focusedBoxShadows,
    MaterialPinAnimation? entryAnimation,
    AnimatedSwitcherTransitionBuilder? customEntryAnimationBuilder,
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
      followingFillColor: followingFillColor ?? this.followingFillColor,
      followingBorderColor: followingBorderColor ?? this.followingBorderColor,
      completeFillColor: completeFillColor ?? this.completeFillColor,
      completeBorderColor: completeBorderColor ?? this.completeBorderColor,
      completeTextStyle: completeTextStyle ?? this.completeTextStyle,
      errorColor: errorColor ?? this.errorColor,
      errorFillColor: errorFillColor ?? this.errorFillColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      errorBorderWidth: errorBorderWidth ?? this.errorBorderWidth,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      errorBoxShadows: errorBoxShadows ?? this.errorBoxShadows,
      disabledColor: disabledColor ?? this.disabledColor,
      disabledFillColor: disabledFillColor ?? this.disabledFillColor,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      disabledTextStyle: disabledTextStyle ?? this.disabledTextStyle,
      textStyle: textStyle ?? this.textStyle,
      textGradient: textGradient ?? this.textGradient,
      obscuringCharacter: obscuringCharacter ?? this.obscuringCharacter,
      hintCharacter: hintCharacter ?? this.hintCharacter,
      hintStyle: hintStyle ?? this.hintStyle,
      cursorColor: cursorColor ?? this.cursorColor,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      showCursor: showCursor ?? this.showCursor,
      animateCursor: animateCursor ?? this.animateCursor,
      cursorBlinkDuration: cursorBlinkDuration ?? this.cursorBlinkDuration,
      cursorWidget: cursorWidget ?? this.cursorWidget,
      elevation: elevation ?? this.elevation,
      focusedElevation: focusedElevation ?? this.focusedElevation,
      boxShadows: boxShadows ?? this.boxShadows,
      focusedBoxShadows: focusedBoxShadows ?? this.focusedBoxShadows,
      entryAnimation: entryAnimation ?? this.entryAnimation,
      customEntryAnimationBuilder:
          customEntryAnimationBuilder ?? this.customEntryAnimationBuilder,
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

    // Resolve base colors first (used for fallbacks)
    final resolvedTextStyle = textStyle ?? textTheme.headlineSmall;
    final resolvedErrorColor = errorColor ?? colorScheme.error;
    final resolvedDisabledColor =
        disabledColor ?? colorScheme.onSurface.withValues(alpha: 0.38);

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
      followingFillColor:
          followingFillColor ?? fillColor ?? colorScheme.surfaceContainerHighest,
      followingBorderColor:
          followingBorderColor ?? borderColor ?? colorScheme.outline,
      completeFillColor:
          completeFillColor ?? filledFillColor ?? colorScheme.surfaceContainerHighest,
      completeBorderColor:
          completeBorderColor ?? filledBorderColor ?? colorScheme.outline,
      completeTextStyle: completeTextStyle ?? resolvedTextStyle,
      errorColor: resolvedErrorColor,
      errorFillColor:
          errorFillColor ?? resolvedErrorColor.withValues(alpha: 0.1),
      errorBorderColor: errorBorderColor ?? resolvedErrorColor,
      errorBorderWidth: errorBorderWidth ?? focusedBorderWidth,
      errorTextStyle:
          errorTextStyle ?? resolvedTextStyle?.copyWith(color: resolvedErrorColor),
      errorBoxShadows: errorBoxShadows,
      disabledColor: resolvedDisabledColor,
      disabledFillColor:
          disabledFillColor ?? resolvedDisabledColor.withValues(alpha: 0.1),
      disabledBorderColor: disabledBorderColor ?? resolvedDisabledColor,
      disabledTextStyle: disabledTextStyle ??
          resolvedTextStyle?.copyWith(color: resolvedDisabledColor),
      textStyle: resolvedTextStyle,
      textGradient: textGradient,
      obscuringCharacter: obscuringCharacter,
      hintCharacter: hintCharacter,
      hintStyle: hintStyle,
      cursorColor: cursorColor ?? colorScheme.primary,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      showCursor: showCursor,
      animateCursor: animateCursor,
      cursorBlinkDuration: cursorBlinkDuration,
      cursorWidget: cursorWidget,
      elevation: elevation,
      focusedElevation: focusedElevation,
      boxShadows: boxShadows,
      focusedBoxShadows: focusedBoxShadows,
      entryAnimation: entryAnimation,
      customEntryAnimationBuilder: customEntryAnimationBuilder,
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
    required this.followingFillColor,
    required this.followingBorderColor,
    required this.completeFillColor,
    required this.completeBorderColor,
    required this.completeTextStyle,
    required this.errorColor,
    required this.errorFillColor,
    required this.errorBorderColor,
    required this.errorBorderWidth,
    required this.errorTextStyle,
    required this.errorBoxShadows,
    required this.disabledColor,
    required this.disabledFillColor,
    required this.disabledBorderColor,
    required this.disabledTextStyle,
    required this.textStyle,
    required this.textGradient,
    required this.obscuringCharacter,
    required this.hintCharacter,
    required this.hintStyle,
    required this.cursorColor,
    required this.cursorWidth,
    required this.cursorHeight,
    required this.showCursor,
    required this.animateCursor,
    required this.cursorBlinkDuration,
    required this.cursorWidget,
    required this.elevation,
    required this.focusedElevation,
    required this.boxShadows,
    required this.focusedBoxShadows,
    required this.entryAnimation,
    required this.customEntryAnimationBuilder,
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
  final Color followingFillColor;
  final Color followingBorderColor;
  final Color completeFillColor;
  final Color completeBorderColor;
  final TextStyle? completeTextStyle;
  final Color errorColor;
  final Color errorFillColor;
  final Color errorBorderColor;
  final double errorBorderWidth;
  final TextStyle? errorTextStyle;
  final List<BoxShadow>? errorBoxShadows;
  final Color disabledColor;
  final Color disabledFillColor;
  final Color disabledBorderColor;
  final TextStyle? disabledTextStyle;
  final TextStyle? textStyle;
  final Gradient? textGradient;
  final String obscuringCharacter;
  final String? hintCharacter;
  final TextStyle? hintStyle;
  final Color cursorColor;
  final double cursorWidth;
  final double? cursorHeight;
  final bool showCursor;
  final bool animateCursor;
  final Duration cursorBlinkDuration;
  final Widget? cursorWidget;
  final double elevation;
  final double focusedElevation;
  final List<BoxShadow>? boxShadows;
  final List<BoxShadow>? focusedBoxShadows;
  final MaterialPinAnimation entryAnimation;
  final AnimatedSwitcherTransitionBuilder? customEntryAnimationBuilder;
  final Duration animationDuration;
  final Curve animationCurve;
  final Duration errorAnimationDuration;
  final bool enableErrorShake;
}
