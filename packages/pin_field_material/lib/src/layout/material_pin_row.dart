import 'package:flutter/material.dart';
import 'package:pin_field_core/pin_field_core.dart';

import '../cells/material_pin_cell.dart';
import '../theme/material_pin_theme.dart';

/// Row layout for Material PIN cells.
///
/// This widget arranges PIN cells horizontally with optional separators
/// between them.
class MaterialPinRow extends StatelessWidget {
  const MaterialPinRow({
    super.key,
    required this.cells,
    required this.theme,
    this.obscureText = false,
    this.hintCharacter,
    this.hintStyle,
    this.separatorBuilder,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  /// List of cell data for each PIN position.
  final List<PinCellData> cells;

  /// The resolved Material theme.
  final MaterialPinThemeData theme;

  /// Whether to obscure the text.
  final bool obscureText;

  /// Hint character to show in empty cells.
  final String? hintCharacter;

  /// Style for hint character.
  final TextStyle? hintStyle;

  /// Optional builder for separators between cells.
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  /// How the cells should be aligned horizontally.
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment,
      children: _buildChildren(context),
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    final children = <Widget>[];

    for (int i = 0; i < cells.length; i++) {
      // Add cell
      children.add(
        MaterialPinCell(
          data: cells[i],
          theme: theme,
          obscureText: obscureText,
          hintCharacter: hintCharacter,
          hintStyle: hintStyle,
        ),
      );

      // Add separator or spacing
      if (i < cells.length - 1) {
        if (separatorBuilder != null) {
          children.add(separatorBuilder!(context, i));
        } else {
          children.add(SizedBox(width: theme.spacing));
        }
      }
    }

    return children;
  }
}
