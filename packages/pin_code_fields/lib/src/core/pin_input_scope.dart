import 'package:flutter/widgets.dart';

import 'pin_cell_data.dart';

/// InheritedWidget providing PIN state to descendant cells.
///
/// This allows custom cell implementations to access the current PIN state
/// without needing to pass data through every widget in the tree.
class PinInputScope extends InheritedWidget {
  const PinInputScope({
    super.key,
    required this.cells,
    required this.obscureText,
    required this.obscuringCharacter,
    required this.hasFocus,
    required this.requestFocus,
    required super.child,
  });

  /// List of cell data for each PIN position.
  final List<PinCellData> cells;

  /// Whether text should be obscured.
  final bool obscureText;

  /// Character used to obscure text.
  final String obscuringCharacter;

  /// Whether the PIN field has focus.
  final bool hasFocus;

  /// Callback to request focus on the PIN field.
  final VoidCallback requestFocus;

  /// Gets the [PinInputScope] from the widget tree.
  ///
  /// Throws if not found.
  static PinInputScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<PinInputScope>();
    assert(scope != null, 'No PinInputScope found in context');
    return scope!;
  }

  /// Gets the [PinInputScope] from the widget tree, or null if not found.
  static PinInputScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PinInputScope>();
  }

  @override
  bool updateShouldNotify(PinInputScope oldWidget) {
    return cells != oldWidget.cells ||
        obscureText != oldWidget.obscureText ||
        obscuringCharacter != oldWidget.obscuringCharacter ||
        hasFocus != oldWidget.hasFocus;
  }
}
