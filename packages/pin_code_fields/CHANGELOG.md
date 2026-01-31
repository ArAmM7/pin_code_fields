# Changelog

## [9.0.0] - Major Architecture Refactor

### Breaking Changes ⚠️

This is a complete rewrite with a new headless architecture. Migration required.

- **New Headless Architecture**: The package now provides both a headless core (`PinInput`) and a Material Design implementation (`MaterialPinField`)
- **Unified Controller**: `PinInputController` replaces separate `TextEditingController`, `FocusNode`, and `errorAnimationController`
- **Theme System**: New `MaterialPinTheme` with automatic `ColorScheme` resolution
- **Renamed Parameters**: See migration guide below

### Features ✨

- **Headless Core**: Build completely custom PIN UIs with `PinInput` and `PinCellData`
- **Material Design Ready**: Use `MaterialPinField` for beautiful, ready-to-use PIN fields
- **PinInputController**: Single controller for text, focus, and error state management
  - `setText()`, `clear()`, `text` - Text control
  - `triggerError()`, `clearError()`, `hasError` - Error control
  - `requestFocus()`, `unfocus()`, `hasFocus` - Focus control
- **Improved Animations**: Scale, fade, slide, and none animation types
- **All Cell Shapes**: Outlined, filled, underlined, and circle
- **Text Gradient**: Apply gradients to PIN text via `MaterialPinTheme.textGradient`
- **Custom Obscuring Widget**: Use any widget for obscuring with `obscuringWidget`
- **Form Integration**: `PinInputFormField` for form validation
- **SMS Autofill**: Full autofill support with `enableAutofill` and `autofillHints`
- **Haptic Feedback**: Configurable haptic feedback types

### Migration Guide

#### Parameter Renames

| Old Name | New Name |
|----------|----------|
| `controller` | `pinController.textController` |
| `focusNode` | `pinController.focusNode` |
| `useHapticFeedback` | `enableHapticFeedback` |
| `hapticFeedbackTypes` | `hapticFeedbackType` |
| `animationType` | `theme.entryAnimation` |
| `enableContextMenu` | `enablePaste` |
| `errorAnimationController` | `pinController.triggerError()` |
| `pinTheme` | `theme` (MaterialPinTheme) |
| `enablePinAutofill` | `enableAutofill` |

#### Basic Migration

**Before (v8.x):**
```dart
PinCodeTextField(
  appContext: context,
  length: 6,
  controller: textController,
  focusNode: focusNode,
  pinTheme: PinTheme(
    shape: PinCodeFieldShape.box,
    activeColor: Colors.blue,
  ),
  onChanged: (value) {},
  onCompleted: (value) {},
)
```

**After (v9.0):**
```dart
final pinController = PinInputController();

MaterialPinField(
  length: 6,
  pinController: pinController,
  theme: MaterialPinTheme(
    shape: MaterialPinShape.outlined,
    focusedBorderColor: Colors.blue,
  ),
  onChanged: (value) {},
  onCompleted: (value) {},
)
```

#### Error Handling Migration

**Before:**
```dart
final errorController = StreamController<ErrorAnimationType>();
errorController.add(ErrorAnimationType.shake);
```

**After:**
```dart
final pinController = PinInputController();
pinController.triggerError();  // Triggers shake + sets error state
pinController.clearError();    // Clears error state
```

---

## [8.0.1]

- Added `activeBorderWidth`, `selectedBorderWidth`, `inactiveBorderWidth`, `disabledBorderWidth`, `errorBorderWidth`

## [8.0.0]

- Updated Dart SDK constraint `sdk: ">=2.12.0 <4.0.0"`
- Use `PinCodePlatform` instead `Platform` enum
- Numerous bug fixes, thanks to each and every contributor for resolving issues

## [7.4.0]

- Added new attributes `readOnly`, `textGradient`, `errorTextDirection`, `errorTextMargin`, `autoUnfocus`
- Resolved blinkDebounce `setState()` after `dispose()` bug
- Example app refactor

## [7.3.0]

- Fixed extra padding if autoValidate is not provided
- Added ScrollPadding, errorBorderColor

## [7.2.0]

- Much requested feature placeholder has been added `hintCharacter`
- `hintStyle` has been added to customize the hint TextStyle

## [7.1.0]

- Added `useExternalAutoFillGroup` to use this widget with external `AutofillGroup`
- Added `fieldOuterPadding` to add extra padding on each cells. Default to 0.0

## [7.0.0]

- Added null-safety to the main branch

## [6.1.0]

- Added haptic feedback
- Added animated obscure widget support `obscuringWidget` and `blinkWhenObscuring`

## [6.0.0]

- Added Cursor support
- Added boxShadows
- Minimum Flutter version is set to 1.22.0

## [5.0.0]

- Added iOS autofill with Flutter version 1.20.0
- Added onSave, onTap callbacks
- Added PastedTextStyle

## [4.0.0]

- Added support for flutter-web

## [3.0.0]

- Introduced `PinTheme` & `DialogConfig`
- Added `beforeTextPaste` callback
- Added `onCompleted` callback

## [2.0.0]

- Added animations while changing value
- Added multiple customization parameters
- Pressing backspace focuses previous field
