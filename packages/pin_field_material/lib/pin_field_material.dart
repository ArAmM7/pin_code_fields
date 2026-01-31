/// Material Design implementation for PIN/OTP input fields.
///
/// This package provides ready-to-use Material Design styled PIN input
/// components built on top of [pin_field_core].
///
/// ## Quick Start
///
/// ```dart
/// import 'package:pin_field_material/pin_field_material.dart';
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
/// ## Customization
///
/// Use [MaterialPinTheme] to customize the appearance:
/// - Shape: outlined, filled, or underlined
/// - Colors: fill, border, focused, error states
/// - Animations: scale, fade, slide, or none
/// - Cursor: color, size, blinking
///
/// For complete control over rendering, use [PinInput] from the
/// core package instead.
library pin_field_material;

// Re-export core types that consumers will need
export 'package:pin_field_core/pin_field_core.dart'
    show
        PinCellData,
        PinInput,
        PinInputScope,
        PinInputFormField,
        HapticFeedbackType;

// Theme
export 'src/theme/material_pin_theme.dart';

// Main widget
export 'src/material_pin_field.dart';

// Cells (for advanced customization)
export 'src/cells/material_pin_cell.dart';
export 'src/cells/material_cell_content.dart';

// Layout
export 'src/layout/material_pin_row.dart';

// Animations
export 'src/animations/entry_animations.dart';
export 'src/animations/cursor_blink.dart';
export 'src/animations/error_shake.dart';

// Shapes
export 'src/shapes/outlined_decoration.dart';
export 'src/shapes/filled_decoration.dart';
export 'src/shapes/underlined_decoration.dart';
export 'src/shapes/circle_decoration.dart';
