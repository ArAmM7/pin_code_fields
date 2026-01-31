import 'package:flutter/material.dart';
import 'package:pin_field_core/pin_field_core.dart';

import '../shapes/circle_decoration.dart';
import '../shapes/filled_decoration.dart';
import '../shapes/outlined_decoration.dart';
import '../shapes/underlined_decoration.dart';
import '../theme/material_pin_theme.dart';
import 'material_cell_content.dart';

/// A Material Design PIN cell widget.
///
/// This widget renders a single PIN cell with the appropriate styling
/// based on its current state (empty, filled, focused, error, disabled).
class MaterialPinCell extends StatelessWidget {
  const MaterialPinCell({
    super.key,
    required this.data,
    required this.theme,
    this.obscureText = false,
    this.hintCharacter,
    this.hintStyle,
  });

  /// The cell data containing state information.
  final PinCellData data;

  /// The resolved Material theme.
  final MaterialPinThemeData theme;

  /// Whether to obscure the text.
  final bool obscureText;

  /// Hint character to show in empty cells.
  final String? hintCharacter;

  /// Style for hint character.
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: theme.animationDuration,
      curve: theme.animationCurve,
      width: theme.cellSize.width,
      height: theme.cellSize.height,
      decoration: _buildDecoration(),
      alignment: Alignment.center,
      child: MaterialCellContent(
        data: data,
        theme: theme,
        obscureText: obscureText,
        hintCharacter: hintCharacter,
        hintStyle: hintStyle,
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    // Determine colors based on state
    Color fillColor;
    Color borderColor;
    double borderWidth;
    List<BoxShadow>? boxShadows;

    if (data.isDisabled) {
      fillColor = theme.disabledColor.withValues(alpha: 0.1);
      borderColor = theme.disabledColor;
      borderWidth = theme.borderWidth;
      boxShadows = null;
    } else if (data.isError) {
      fillColor = theme.errorColor.withValues(alpha: 0.1);
      borderColor = theme.errorColor;
      borderWidth = theme.focusedBorderWidth;
      boxShadows = null;
    } else if (data.isFocused) {
      fillColor = theme.focusedFillColor;
      borderColor = theme.focusedBorderColor;
      borderWidth = theme.focusedBorderWidth;
      boxShadows = theme.focusedBoxShadows;
    } else if (data.isFilled) {
      fillColor = theme.filledFillColor;
      borderColor = theme.filledBorderColor;
      borderWidth = theme.borderWidth;
      boxShadows = theme.boxShadows;
    } else {
      fillColor = theme.fillColor;
      borderColor = theme.borderColor;
      borderWidth = theme.borderWidth;
      boxShadows = theme.boxShadows;
    }

    // Build decoration based on shape
    switch (theme.shape) {
      case MaterialPinShape.outlined:
        return buildOutlinedDecoration(
          fillColor: fillColor,
          borderColor: borderColor,
          borderWidth: borderWidth,
          borderRadius: theme.borderRadius,
          boxShadows: boxShadows,
        );
      case MaterialPinShape.filled:
        return buildFilledDecoration(
          fillColor: fillColor,
          borderRadius: theme.borderRadius,
          boxShadows: boxShadows,
        );
      case MaterialPinShape.underlined:
        return buildUnderlinedDecoration(
          fillColor: Colors.transparent,
          borderColor: borderColor,
          borderWidth: borderWidth,
          boxShadows: boxShadows,
        );
      case MaterialPinShape.circle:
        return buildCircleDecoration(
          fillColor: fillColor,
          borderColor: borderColor,
          borderWidth: borderWidth,
          boxShadows: boxShadows,
        );
    }
  }
}
