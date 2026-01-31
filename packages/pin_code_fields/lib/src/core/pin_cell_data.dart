import 'package:flutter/foundation.dart';

/// Immutable data describing a single PIN cell's state.
///
/// This model contains NO visual properties - just state information
/// that consumers can use to render cells however they want.
@immutable
class PinCellData {
  /// The index of this cell in the PIN field (0-based).
  final int index;

  /// The character at this cell position, or null if empty.
  final String? character;

  /// Whether this cell should show a cursor (is the next input position).
  final bool isFocused;

  /// Whether this cell has a character entered.
  final bool isFilled;

  /// Whether the PIN field is in an error state.
  final bool isError;

  /// Whether the PIN field is disabled or read-only.
  final bool isDisabled;

  /// Whether a character was just entered at this cell (true for one frame only).
  ///
  /// Use this to trigger entry animations.
  final bool wasJustEntered;

  /// Whether a character was just removed from this cell (true for one frame only).
  ///
  /// Use this to trigger removal animations.
  final bool wasJustRemoved;

  /// Whether currently in blink phase (show real char before obscuring).
  ///
  /// When [obscureText] is enabled and [blinkWhenObscuring] is true,
  /// this will be true briefly after a character is entered to show
  /// the actual character before it gets obscured.
  final bool isBlinking;

  const PinCellData({
    required this.index,
    this.character,
    this.isFocused = false,
    this.isFilled = false,
    this.isError = false,
    this.isDisabled = false,
    this.wasJustEntered = false,
    this.wasJustRemoved = false,
    this.isBlinking = false,
  });

  /// Creates a copy of this [PinCellData] with the given fields replaced.
  PinCellData copyWith({
    int? index,
    String? character,
    bool? isFocused,
    bool? isFilled,
    bool? isError,
    bool? isDisabled,
    bool? wasJustEntered,
    bool? wasJustRemoved,
    bool? isBlinking,
  }) {
    return PinCellData(
      index: index ?? this.index,
      character: character ?? this.character,
      isFocused: isFocused ?? this.isFocused,
      isFilled: isFilled ?? this.isFilled,
      isError: isError ?? this.isError,
      isDisabled: isDisabled ?? this.isDisabled,
      wasJustEntered: wasJustEntered ?? this.wasJustEntered,
      wasJustRemoved: wasJustRemoved ?? this.wasJustRemoved,
      isBlinking: isBlinking ?? this.isBlinking,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PinCellData &&
        other.index == index &&
        other.character == character &&
        other.isFocused == isFocused &&
        other.isFilled == isFilled &&
        other.isError == isError &&
        other.isDisabled == isDisabled &&
        other.wasJustEntered == wasJustEntered &&
        other.wasJustRemoved == wasJustRemoved &&
        other.isBlinking == isBlinking;
  }

  @override
  int get hashCode => Object.hash(
        index,
        character,
        isFocused,
        isFilled,
        isError,
        isDisabled,
        wasJustEntered,
        wasJustRemoved,
        isBlinking,
      );

  @override
  String toString() {
    return 'PinCellData(index: $index, character: $character, '
        'isFocused: $isFocused, isFilled: $isFilled, isError: $isError, '
        'isDisabled: $isDisabled, wasJustEntered: $wasJustEntered, '
        'wasJustRemoved: $wasJustRemoved, isBlinking: $isBlinking)';
  }
}
