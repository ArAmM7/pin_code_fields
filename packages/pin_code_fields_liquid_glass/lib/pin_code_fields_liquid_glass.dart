/// iOS 26 Liquid Glass styled PIN input field for Flutter.
///
/// This package provides a PIN input field with Apple's iOS 26 Liquid Glass
/// aesthetic, built on top of [pin_code_fields] with GPU-accelerated glass
/// effects from [liquid_glass_renderer].
///
/// ## Requirements
///
/// This package requires the Impeller rendering engine and only works on:
/// - iOS
/// - Android
/// - macOS
///
/// Web, Windows, and Linux are **not supported**.
///
/// ## Quick Start
///
/// ```dart
/// import 'package:pin_code_fields_liquid_glass/pin_code_fields_liquid_glass.dart';
///
/// LiquidGlassPinField(
///   length: 6,
///   theme: LiquidGlassPinTheme.blended(
///     blur: 10,
///     glassColor: Colors.white.withOpacity(0.2),
///   ),
///   onCompleted: (pin) => print('PIN: $pin'),
/// )
/// ```
///
/// ## Available Styles
///
/// Three visual styles are available:
///
/// - **Separate** ([LiquidGlassPinTheme.separate]) - Individual glass cells
///   with spacing between them. Traditional PIN field look.
///
/// - **Unified** ([LiquidGlassPinTheme.unified]) - One glass container with
///   internal dividers. Clean, minimal look.
///
/// - **Blended** ([LiquidGlassPinTheme.blended]) - Cells that blend together
///   using LiquidGlassBlendGroup. Modern iOS 26 aesthetic.
library pin_code_fields_liquid_glass;

export 'src/liquid_glass_pin_field.dart';
export 'src/theme/liquid_glass_pin_theme.dart';

// Re-export useful types from pin_code_fields
export 'package:pin_code_fields/pin_code_fields.dart'
    show PinInputController, PinCellData, HapticFeedbackType;
