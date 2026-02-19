/// A highly customizable PIN/OTP input field for Flutter.
///
/// This package provides both a headless core for building custom PIN UIs
/// and a ready-to-use Material Design implementation.
///
/// ## Quick Start with Material Design
///
/// ```dart
/// import 'package:pin_code_fields/pin_code_fields.dart';
///
/// MaterialPinField(
///   length: 6,
///   onCompleted: (pin) => print('PIN: $pin'),
///   theme: MaterialPinTheme(
///     shape: MaterialPinShape.outlined,
///     cellSize: Size(56, 64),
///   ),
/// )
/// ```
///
/// ## Custom UI with Headless Core
///
/// ```dart
/// PinInput(
///   length: 4,
///   builder: (context, cells) {
///     return Row(
///       children: cells.map((cell) => MyCustomCell(
///         character: cell.character,
///         isFocused: cell.isFocused,
///         isFilled: cell.isFilled,
///       )).toList(),
///     );
///   },
/// )
/// ```
library;

// Core exports
export 'src/core/pin_input.dart';
export 'src/core/pin_cell_data.dart';
export 'src/core/pin_input_controller.dart';
export 'src/core/pin_controller_mixin.dart';
export 'src/core/pin_input_scope.dart';
export 'src/core/haptics.dart';
export 'src/core/form/pin_input_form_field.dart';

// Material exports
export 'src/material/material_pin_field.dart';
export 'src/material/theme/material_pin_theme.dart';
export 'src/material/theme/material_pin_theme_extension.dart';
export 'src/material/cells/material_pin_cell.dart'
    show MaterialPinCell, PinCellStateStyle;
export 'src/material/cells/material_cell_content.dart';
export 'src/material/layout/material_pin_row.dart';
export 'src/material/animations/entry_animations.dart';
export 'src/material/animations/cursor_blink.dart';
export 'src/material/animations/error_shake.dart';
export 'src/material/shapes/outlined_decoration.dart';
export 'src/material/shapes/filled_decoration.dart';
export 'src/material/shapes/underlined_decoration.dart';
export 'src/material/shapes/circle_decoration.dart';
