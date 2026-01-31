# Pin Code Fields - Feature Comparison

This document lists all features from the existing `pin_code_fields` package (v9.0.0-dev.1) and tracks their implementation status in the new headless architecture.

---

## 1. Core Widget Parameters

### PinCodeTextField

| Parameter | Type | Default | Description | New Package Status |
|-----------|------|---------|-------------|-------------------|
| `length` | `int` | **required** | Number of PIN cells (3-8 recommended) | ✅ Implemented |
| `controller` | `TextEditingController?` | `null` | External text controller | ✅ Via `PinInputController` |
| `focusNode` | `FocusNode?` | `null` | External focus node | ✅ Via `PinInputController` |
| `pinController` | `PinInputController?` | `null` | Unified controller for text, focus, and error | ✅ **New** |
| `enabled` | `bool` | `true` | Enable/disable the field | ✅ Implemented (as `readOnly`) |
| `readOnly` | `bool` | `false` | Make cells read-only | ✅ Implemented |
| `autoFocus` | `bool` | `false` | Auto-focus on mount | ✅ Implemented |
| `autoDismissKeyboard` | `bool` | `true` | Dismiss keyboard when PIN complete | ✅ Implemented |

---

## 2. Text Obscuring Features

| Parameter | Type | Default | Description | New Package Status |
|-----------|------|---------|-------------|-------------------|
| `obscureText` | `bool` | `false` | Hide entered characters | ✅ Implemented |
| `obscuringCharacter` | `String` | `'●'` | Character for obscuring | ✅ Implemented |
| `obscuringWidget` | `Widget?` | `null` | Custom widget for obscuring | ✅ Implemented |
| `blinkWhenObscuring` | `bool` | `false` | Briefly show char before obscuring | ✅ Implemented |
| `blinkDuration` | `Duration` | `500ms` | Duration to show char | ✅ Implemented |

---

## 3. Keyboard & Input Configuration

| Parameter | Type | Default | Description | New Package Status |
|-----------|------|---------|-------------|-------------------|
| `keyboardType` | `TextInputType` | `visiblePassword` | Keyboard type | ✅ Implemented |
| `textInputAction` | `TextInputAction` | `done` | Keyboard action button | ✅ Implemented |
| `textCapitalization` | `TextCapitalization` | `none` | Text capitalization | ✅ Implemented |
| `inputFormatters` | `List<TextInputFormatter>` | `[]` | Custom input formatters | ✅ Implemented |
| `keyboardAppearance` | `Brightness?` | `null` | iOS keyboard brightness | ✅ Implemented |
| `scrollPadding` | `EdgeInsets` | `EdgeInsets.all(20)` | Scroll padding | ✅ Implemented |

---

## 4. Autofill Support

| Parameter | Type | Default | Description | New Package Status |
|-----------|------|---------|-------------|-------------------|
| `enablePinAutofill` | `bool` | `true` | Enable SMS autofill | ✅ Implemented (as `enableAutofill`) |
| `onAutoFillDisposeAction` | `AutofillContextAction` | `commit` | Autofill cleanup action | ✅ Implemented (as `autofillContextAction`) |
| `autofillHints` | `Iterable<String>?` | `null` | Autofill hints | ✅ Implemented |

---

## 5. Haptic Feedback

| Parameter | Type | Default | Description | New Package Status |
|-----------|------|---------|-------------|-------------------|
| `useHapticFeedback` | `bool` | `false` | Enable haptic feedback | ✅ Implemented (as `enableHapticFeedback`) |
| `hapticFeedbackTypes` | `HapticFeedbackTypes` | `light` | Type of haptic feedback | ✅ Implemented (as `hapticFeedbackType`) |

### HapticFeedbackTypes Enum

| Value | Description | New Package Status |
|-------|-------------|-------------------|
| `light` | Light impact | ✅ Implemented |
| `medium` | Medium impact | ✅ Implemented |
| `heavy` | Heavy impact | ✅ Implemented |
| `selection` | Selection click | ✅ Implemented |
| `vibrate` | Full vibration | ✅ Implemented |

---

## 6. Callbacks

| Parameter | Type | Description | New Package Status |
|-----------|------|-------------|-------------------|
| `onChanged` | `ValueChanged<String>?` | Called on every text change | ✅ Implemented |
| `onCompleted` | `ValueChanged<String>?` | Called when all cells filled | ✅ Implemented |
| `onSubmitted` | `ValueChanged<String>?` | Called on keyboard submit | ✅ Implemented |
| `onEditingComplete` | `VoidCallback?` | Called when editing complete | ✅ Implemented |
| `onTap` | `GestureTapCallback?` | Called when widget tapped | ✅ Implemented |

---

## 7. Styling - Text

| Parameter | Type | Default | Description | New Package Status |
|-----------|------|---------|-------------|-------------------|
| `textStyle` | `TextStyle?` | `fontSize: 20, fontWeight: bold` | Style for PIN text | ✅ Implemented (in theme) |
| `hintCharacter` | `String?` | `null` | Hint in empty cells | ✅ Implemented |
| `hintStyle` | `TextStyle?` | uses `textStyle` | Style for hint | ✅ Implemented |
| `textGradient` | `Gradient?` | `null` | Gradient for text | ✅ Implemented (in theme) |

---

## 8. Styling - Cursor

| Parameter | Type | Default | Description | New Package Status |
|-----------|------|---------|-------------|-------------------|
| `showCursor` | `bool` | `true` | Show cursor in focused cell | ✅ Implemented |
| `cursorColor` | `Color?` | `Theme.accentColor` | Cursor color | ✅ Implemented |
| `cursorWidth` | `double` | `2` | Cursor width | ✅ Implemented |
| `cursorHeight` | `double?` | `fontSize + 8` | Cursor height | ✅ Implemented |
| `animateCursor` | `bool` | `false` | Animate cursor blinking | ✅ Implemented |
| `cursorBlinkDuration` | `Duration` | `500ms` | Cursor blink cycle duration | ✅ Implemented |
| `cursorBlinkCurve` | `Curve` | `easeInOut` | Cursor blink animation curve | ✅ Implemented (fixed curve) |

---

## 9. Styling - Cell Theme (PinTheme)

### Cell Dimensions

| Parameter | Type | Default | Description | New Package Status |
|-----------|------|---------|-------------|-------------------|
| `fieldWidth` | `double` | `40` | Cell width | ✅ Implemented (as `cellSize.width`) |
| `fieldHeight` | `double` | `50` | Cell height | ✅ Implemented (as `cellSize.height`) |
| `borderRadius` | `BorderRadius` | `zero` | Cell border radius | ✅ Implemented |
| `fieldOuterPadding` | `EdgeInsetsGeometry` | `zero` | Padding around each cell | ✅ Implemented (as `spacing`) |

### Cell Shape

| Value | Description | New Package Status |
|-------|-------------|-------------------|
| `PinCodeFieldShape.box` | Bordered box | ✅ Implemented (as `outlined`) |
| `PinCodeFieldShape.underline` | Bottom border only | ✅ Implemented |
| `PinCodeFieldShape.circle` | Circular shape | ✅ Implemented (as `circle`) |

### Border Colors

| Parameter | Type | Default | Description | New Package Status |
|-----------|------|---------|-------------|-------------------|
| `activeColor` | `Color` | `green` | Border color for filled cells | ✅ Implemented (as `filledBorderColor`) |
| `selectedColor` | `Color` | `blue` | Border color for focused cell | ✅ Implemented (as `focusedBorderColor`) |
| `inactiveColor` | `Color` | `red` | Border color for empty cells | ✅ Implemented (as `borderColor`) |
| `disabledColor` | `Color` | `grey` | Border color when disabled | ✅ Implemented |
| `errorBorderColor` | `Color` | `redAccent` | Border color in error state | ✅ Implemented (as `errorColor`) |

### Fill Colors

| Parameter | Type | Default | Description | New Package Status |
|-----------|------|---------|-------------|-------------------|
| `activeFillColor` | `Color` | `green` | Fill for filled cells | ✅ Implemented (as `filledFillColor`) |
| `selectedFillColor` | `Color` | `blue` | Fill for focused cell | ✅ Implemented (as `focusedFillColor`) |
| `inactiveFillColor` | `Color` | `red` | Fill for empty cells | ✅ Implemented (as `fillColor`) |
| `enableActiveFill` | `bool` | `true` | Enable fill colors | ✅ Implemented (always enabled, use transparent) |

### Border Widths

| Parameter | Type | Default | Description | New Package Status |
|-----------|------|---------|-------------|-------------------|
| `borderWidth` | `double?` | `null` | Default border width | ✅ Implemented |
| `activeBorderWidth` | `double` | `2` | Border width for filled cells | ✅ Implemented (uses `borderWidth`) |
| `selectedBorderWidth` | `double` | `2` | Border width for focused cell | ✅ Implemented (as `focusedBorderWidth`) |
| `inactiveBorderWidth` | `double` | `2` | Border width for empty cells | ✅ Implemented (as `borderWidth`) |
| `disabledBorderWidth` | `double` | `2` | Border width when disabled | ✅ Implemented (uses `borderWidth`) |
| `errorBorderWidth` | `double` | `2` | Border width in error state | ✅ Implemented (uses `focusedBorderWidth`) |

### Box Shadows

| Parameter | Type | Default | Description | New Package Status |
|-----------|------|---------|-------------|-------------------|
| `boxShadows` | `List<BoxShadow>?` | `null` | Global box shadows | ✅ Implemented |
| `activeBoxShadows` | `List<BoxShadow>?` | `null` | Shadows for active cells | ✅ Implemented (as `boxShadows`) |
| `inActiveBoxShadows` | `List<BoxShadow>?` | `null` | Shadows for inactive cells | ✅ Implemented (merged with `boxShadows`) |

---

## 10. Animations

### Entry Animation

| Parameter | Type | Default | Description | New Package Status |
|-----------|------|---------|-------------|-------------------|
| `animationType` | `AnimationType` | `slide` | Character entry animation | ✅ Implemented (as `entryAnimation`) |
| `animationDuration` | `Duration` | `150ms` | Animation duration | ✅ Implemented |
| `animationCurve` | `Curve` | `easeInOut` | Animation curve | ✅ Implemented |

### AnimationType Enum

| Value | Description | New Package Status |
|-------|-------------|-------------------|
| `scale` | Scale in animation | ✅ Implemented |
| `slide` | Slide up animation | ✅ Implemented |
| `fade` | Fade in animation | ✅ Implemented |
| `none` | No animation | ✅ Implemented |

### Error Animation

| Parameter | Type | Default | Description | New Package Status |
|-----------|------|---------|-------------|-------------------|
| `errorAnimationController` | `StreamController<ErrorAnimationType>?` | `null` | External error trigger | ✅ Implemented (as `errorTrigger: Stream<void>`) |
| `errorAnimationDuration` | `int` | `500` | Shake animation duration (ms) | ✅ Implemented |

### ErrorAnimationType Enum

| Value | Description | New Package Status |
|-------|-------------|-------------------|
| `shake` | Trigger shake animation | ✅ Implemented (via `PinInputController.triggerError()`) |
| `clear` | Clear error state | ✅ Implemented (via `PinInputController.clearError()`) |

---

## 11. Layout

| Parameter | Type | Default | Description | New Package Status |
|-----------|------|---------|-------------|-------------------|
| `mainAxisAlignment` | `MainAxisAlignment` | `center` | Row alignment | ✅ Implemented |
| `separatorBuilder` | `IndexedWidgetBuilder?` | `null` | Custom separator between cells | ✅ Implemented |

---

## 12. Context Menu (Paste)

| Parameter | Type | Default | Description | New Package Status |
|-----------|------|---------|-------------|-------------------|
| `enableContextMenu` | `bool` | `true` | Enable long-press paste menu | ✅ Implemented (as `enablePaste`) |
| `selectionControls` | `TextSelectionControls?` | platform-based | Selection controls | ✅ Implemented |
| `contextMenuBuilder` | `EditableTextContextMenuBuilder?` | paste-only menu | Custom context menu | ✅ Implemented |

---

## 13. Form Integration

### PinCodeFormField Parameters

| Parameter | Type | Default | Description | New Package Status |
|-----------|------|---------|-------------|-------------------|
| `validator` | `FormFieldValidator<String>?` | `null` | Validation function | ✅ Implemented |
| `onSaved` | `FormFieldSetter<String>?` | `null` | On form save callback | ✅ Implemented |
| `initialValue` | `String?` | `null` | Initial PIN value | ✅ Implemented |
| `autovalidateMode` | `AutovalidateMode` | `disabled` | Auto validation mode | ✅ Implemented |
| `errorTextSpace` | `double` | `16.0` | Space before error text | ✅ Implemented |
| `errorTextStyle` | `TextStyle?` | `null` | Error text style | ✅ Implemented |

---

## 14. Deprecated/Removed Parameters

| Parameter | Status | Reason |
|-----------|--------|--------|
| `appContext` | Removed | Can get from context |
| `pastedTextStyle` | Removed | Handled by context menu |
| `backgroundColor` | Removed | Apply via container |
| `autoUnfocus` | Deprecated | Use `autoDismissKeyboard` |

---

## Summary

### Fully Implemented ✅
- Core input handling
- Text obscuring (character and custom widget)
- Text gradient support
- Keyboard configuration
- Autofill support (SMS OTP, password managers)
- Haptic feedback
- All callbacks
- Cursor styling & animation
- All cell shapes (outlined, filled, underlined, circle)
- All theme properties
- Entry animations (scale, fade, slide, none)
- Error shake animation
- Context menu (paste)
- Form integration
- Separator builder

### Partially Implemented ⚠️
- None! All features are implemented.

### Missing Features ❌
- None! All features from the original package are implemented.

---

## Migration Guide

### Parameter Renames

| Old Name | New Name |
|----------|----------|
| `controller` | `pinController.textController` (via `PinInputController`) |
| `focusNode` | `pinController.focusNode` (via `PinInputController`) |
| `useHapticFeedback` | `enableHapticFeedback` |
| `hapticFeedbackTypes` | `hapticFeedbackType` |
| `animationType` | `entryAnimation` (in theme) |
| `enableContextMenu` | `enablePaste` |
| `errorAnimationController` | `pinController.triggerError()` (via `PinInputController`) |
| `pinTheme.activeColor` | `theme.filledBorderColor` |
| `pinTheme.selectedColor` | `theme.focusedBorderColor` |
| `pinTheme.inactiveColor` | `theme.borderColor` |
| `pinTheme.fieldWidth/Height` | `theme.cellSize` |
| `pinTheme.fieldOuterPadding` | `theme.spacing` |
| `enablePinAutofill` | `enableAutofill` |
| `onAutoFillDisposeAction` | `autofillContextAction` |

### Structural Changes

1. **Headless Architecture**: Core `PinInput` widget is now headless - you provide the UI via `builder`
2. **Material Implementation**: `MaterialPinField` provides ready-to-use Material Design UI
3. **Theme System**: `MaterialPinTheme` resolves colors from `ColorScheme` if not specified
4. **Unified Controller**: `PinInputController` consolidates `TextEditingController`, `FocusNode`, and `errorAnimationController` into a single controller
5. **Separate Packages**: Import `pin_field_core` for core types and `pin_field_material` for Material widgets

### PinInputController (New)

The new `PinInputController` replaces both `TextEditingController`, `FocusNode`, and `errorAnimationController` with a single unified controller:

```dart
final controller = PinInputController();

MaterialPinField(
  length: 6,
  pinController: controller,
)

// Text control
controller.setText('1234');
controller.clear();
print(controller.text);

// Error control (replaces StreamController<ErrorAnimationType>)
controller.triggerError();  // Triggers error + shake animation
controller.clearError();    // Clears error state programmatically
print(controller.hasError);

// Focus control
controller.requestFocus();
controller.unfocus();
print(controller.hasFocus);

// Access underlying controllers if needed
controller.textController;  // TextEditingController
controller.focusNode;       // FocusNode
```

If you need to provide your own TextEditingController or FocusNode:
```dart
final textController = TextEditingController();
final focusNode = FocusNode();
final controller = PinInputController(
  textController: textController,
  focusNode: focusNode,
);
```

---

## New Architecture Benefits

The new headless architecture provides several advantages:

### For Quick Implementation
Use `MaterialPinField` from `pin_field_material` package:
```dart
import 'package:pin_field_core/pin_field_core.dart';
import 'package:pin_field_material/pin_field_material.dart';

final controller = PinInputController();

MaterialPinField(
  length: 6,
  pinController: controller,
  onCompleted: (pin) => print('PIN: $pin'),
  theme: MaterialPinTheme(
    shape: MaterialPinShape.circle,
    entryAnimation: MaterialPinAnimation.scale,
  ),
)
```

### For Custom UI
Use `PinInput` from `pin_field_core` package with complete control:
```dart
import 'package:pin_field_core/pin_field_core.dart';

PinInput(
  length: 4,
  builder: (context, cells) {
    return Row(
      children: cells.map((cell) => MyCustomCell(
        character: cell.character,
        isFocused: cell.isFocused,
        isFilled: cell.isFilled,
        isError: cell.isError,
      )).toList(),
    );
  },
)
```

### Key Benefits
- **Separation of Concerns**: Input logic is completely separate from visuals
- **Full Customization**: Build any UI you want with the headless core
- **Material Ready**: Use the Material package for quick, beautiful implementations
- **Unified Controller**: Single `PinInputController` manages text, focus, and error state
- **Future-Proof**: Easy to add new design implementations (e.g., Cupertino, custom themes)
- **Testable**: Core logic can be tested independently of UI
