import 'package:flutter_test/flutter_test.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

void main() {
  group('PinCellData', () {
    test('creates with required index', () {
      const cell = PinCellData(index: 0);

      expect(cell.index, 0);
      expect(cell.character, isNull);
      expect(cell.isFocused, false);
      expect(cell.isFilled, false);
      expect(cell.isError, false);
      expect(cell.isDisabled, false);
      expect(cell.wasJustEntered, false);
      expect(cell.wasJustRemoved, false);
      expect(cell.isBlinking, false);
    });

    test('creates with all properties', () {
      const cell = PinCellData(
        index: 1,
        character: '5',
        isFocused: true,
        isFilled: true,
        isError: true,
        isDisabled: true,
        wasJustEntered: true,
        wasJustRemoved: true,
        isBlinking: true,
      );

      expect(cell.index, 1);
      expect(cell.character, '5');
      expect(cell.isFocused, true);
      expect(cell.isFilled, true);
      expect(cell.isError, true);
      expect(cell.isDisabled, true);
      expect(cell.wasJustEntered, true);
      expect(cell.wasJustRemoved, true);
      expect(cell.isBlinking, true);
    });

    test('copyWith creates new instance with updated values', () {
      const original = PinCellData(index: 0);
      final updated = original.copyWith(
        character: '1',
        isFilled: true,
        isFocused: true,
      );

      expect(updated.index, 0);
      expect(updated.character, '1');
      expect(updated.isFilled, true);
      expect(updated.isFocused, true);
      expect(updated.isError, false);
    });

    test('copyWith preserves original when null passed', () {
      const original = PinCellData(
        index: 2,
        character: '3',
        isFilled: true,
      );
      final updated = original.copyWith();

      expect(updated.index, 2);
      expect(updated.character, '3');
      expect(updated.isFilled, true);
    });

    test('equality works correctly', () {
      const cell1 = PinCellData(index: 0, character: '1', isFilled: true);
      const cell2 = PinCellData(index: 0, character: '1', isFilled: true);
      const cell3 = PinCellData(index: 0, character: '2', isFilled: true);

      expect(cell1, equals(cell2));
      expect(cell1, isNot(equals(cell3)));
    });

    test('hashCode is consistent with equality', () {
      const cell1 = PinCellData(index: 0, character: '1');
      const cell2 = PinCellData(index: 0, character: '1');

      expect(cell1.hashCode, equals(cell2.hashCode));
    });

    test('toString provides useful debug output', () {
      const cell = PinCellData(index: 0, character: '1');
      final str = cell.toString();

      expect(str, contains('PinCellData'));
      expect(str, contains('index: 0'));
      expect(str, contains('character: 1'));
    });
  });
}
