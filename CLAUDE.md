# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**pin_code_fields** is a Flutter package for creating highly customizable PIN code and OTP input fields with native-like behavior. The package is at version 9.0.0-dev.1 and has recently undergone a major refactoring.

- **Repository**: https://github.com/adar2378/pin_code_fields
- **Min SDK**: Dart 3.5.4, Flutter 1.17.0+
- **Dependencies**: Only Flutter SDK (minimal dependencies approach)

## Development Commands

### Testing
```bash
flutter test
```

### Running Example
```bash
cd example
flutter run
```

### Linting
```bash
flutter analyze
```
Uses `flutter_lints: ^4.0.0` with configuration in `analysis_options.yaml`

### Publishing (Dry Run)
```bash
flutter pub get
flutter pub publish --dry-run
```

## Architecture

The package uses a **three-layer architecture** with strict separation of concerns:

### Layer 1: Visual Rendering
- `_PinCodeFieldRow`: Container for all PIN cells
- `_PinCodeCell`: Individual cell wrapper with AnimatedContainer
- `_PinCodeCellContent`: Stateful widget handling actual content rendering (text, cursor, obscuring)
- **Responsibility**: Pure visual representation with animations, no input handling

### Layer 2: Input Handling
- `_UnderlyingEditableText`: Wrapper around Flutter's `EditableText`
- Styled to be **completely invisible** (transparent text, hidden cursor)
- Positioned behind visual cells in a Stack to capture keyboard input
- **Responsibility**: All keyboard input, text formatting, length limiting

### Layer 3: Gesture Handling
- `TextSelectionGestureDetectorBuilder` wraps the entire widget tree
- Handles selection gestures, context menu (paste), cut/copy operations
- Platform-adaptive behavior (iOS, Android, Windows, macOS, Linux)
- **Responsibility**: User interactions beyond typing (long press for paste, etc.)

### File Organization

The codebase uses `part`/`part of` pattern for logical file organization:

```
lib/
├── pin_code_fields.dart        # Main library file (imports all parts)
└── src/
    ├── pin_code_fields_state.dart           # _PinCodeTextFieldState
    ├── models/
    │   └── pin_theme.dart                   # PinTheme configuration model
    ├── utils/
    │   └── enums.dart                       # AnimationType, HapticFeedbackTypes, etc.
    └── widgets/
        ├── pin_code_field_row.dart          # _PinCodeFieldRow
        ├── pin_code_cell.dart               # _PinCodeCell, _PinCodeCellContent
        ├── underlying_editable_text.dart    # _UnderlyingEditableText
        ├── gradiented.dart                  # Gradient text wrapper
        └── cursor_painter.dart              # Custom cursor painter
```

## Critical Design Patterns

### 1. TextSelectionGestureDetectorBuilderDelegate Implementation

The state class implements this delegate to enable native text selection behavior:

```dart
class _PinCodeTextFieldState extends State<PinCodeTextField>
    with TickerProviderStateMixin
    implements TextSelectionGestureDetectorBuilderDelegate
```

Key delegate properties:
- `selectionEnabled`: Returns `widget.enableContextMenu && !widget.readOnly`
- `editableTextKey`: GlobalKey for accessing EditableTextState
- `forcePressEnabled`: Always false

### 2. Text Change Flow

Keyboard Input → EditableText → Controller → Listener → Validation → setState

The `_textEditingControllerListener` method orchestrates:
1. Haptic feedback
2. Error state clearing
3. Text length limiting via `_getLimitedText()`
4. onChanged callback
5. onCompleted callback (when length reached)
6. Auto-dismiss keyboard
7. Blink effect for obscured text

### 3. Safe State Management Pattern

Always use the custom `_setState` helper to prevent errors when widget is disposed:

```dart
void _setState(VoidCallback fn) {
  if (mounted) {
    setState(fn);
  }
}
```

### 4. Post-Frame Callbacks

Frequently used to avoid state modification conflicts during build:

```dart
WidgetsBinding.instance.addPostFrameCallback((_) {
  if (mounted) {
    // Safe to modify state after frame
  }
});
```

Used for:
- Initial text selection positioning
- Autofocus handling
- Text correction after validation
- Selection forcing to end of text

## Important Implementation Details

### Input Formatting Order

Applied in `_UnderlyingEditableText.build()`:

1. `LengthLimitingTextInputFormatter(length)` - Applied FIRST
2. Custom user-provided formatters (`widget.inputFormatters`)
3. `FilteringTextInputFormatter.digitsOnly` - Applied LAST if `keyboardType == TextInputType.number`

### Platform-Specific Text Selection Controls

```dart
final TextSelectionControls selectionControls = widget.selectionControls ??
  switch (platform) {
    TargetPlatform.iOS || TargetPlatform.macOS => cupertinoTextSelectionHandleControls,
    TargetPlatform.android || TargetPlatform.fuchsia => materialTextSelectionHandleControls,
    TargetPlatform.linux || TargetPlatform.windows => desktopTextSelectionHandleControls,
  };
```

### Context Menu Trigger

The context menu (with paste functionality) is triggered by **long press** gesture, handled automatically by `TextSelectionGestureDetectorBuilder`. It only appears when:
- `enableContextMenu` is true
- Field is not in `readOnly` mode
- A `contextMenuBuilder` is provided (or default is used)

### Animation Controllers

The state manages multiple animation controllers:

1. **Error Shake Animation**: `_errorAnimationController`
   - Duration: `widget.errorAnimationDuration`
   - Curve: `Curves.elasticIn`
   - Tween: `Offset.zero` to `Offset(.1, 0.0)`

2. **Cursor Blink**: Managed in `_PinCodeCellContent` (if `animateCursor` is enabled)

3. **Cell Transitions**: `AnimatedContainer` with configurable duration/curve

### Focus Management

- Custom focus listener in `_onFocusChanged()`
- Hides toolbar on focus lost via `editableTextKey.currentState?.hideToolbar()`
- Supports `autoDismissKeyboard` to unfocus when PIN complete
- Safe focus request method `_requestFocusSafely()` handles edge cases

## Key Models and Enums

### PinTheme

Comprehensive styling model supporting all visual states:
- Colors: active, selected, inactive, disabled, error (border and fill)
- Dimensions: fieldWidth (default 40), fieldHeight (default 50)
- Borders: Different widths for each state
- Shapes: box, underline, circle
- Shadows: activeBoxShadows, inActiveBoxShadows
- Spacing: fieldOuterPadding

Factory pattern: `PinTheme.defaults()` provides sensible defaults

### Enums

- `AnimationType`: scale, slide, fade, none (for text entry animations)
- `HapticFeedbackTypes`: heavy, light, medium, selection, vibrate
- `PinCodeFieldShape`: box, underline, circle
- `ErrorAnimationType`: shake, clear (for external error animation control)

## Common Pitfalls to Avoid

1. **Never skip `mounted` checks** before setState/callbacks after async operations
2. **Don't modify controller directly** during listener execution - use post-frame callback
3. **Platform-specific testing required** - behaviors differ on iOS, Android, Web, Desktop
4. **Always dispose properly**: AnimationControllers, Timers, StreamSubscriptions, listeners
5. **Don't hardcode colors** in cell widgets - use PinTheme for all styling
6. **Selection is forced to end** - `_handleSelectionChanged` always moves cursor to text end

## Widget Lifecycle Critical Points

### initState()
- Assigns controller (creates new if none provided)
- Adds listener to controller
- Initializes FocusNode (or uses provided one)
- Creates `_gestureDetectorBuilder`
- Initializes error animation controller
- Subscribes to external error stream if provided
- Sets initial selection to end of text (post-frame)
- Handles autofocus (post-frame)

### didUpdateWidget()
- Re-assigns controller if changed
- Swaps FocusNode if changed
- Re-evaluates text if length changed
- Updates error stream subscription if changed
- Rebuilds if readOnly or enableContextMenu changed

### dispose()
- Cancels error stream subscription
- Disposes error animation controller
- Cancels blink debounce timer
- Removes controller listener
- Disposes controller (if internally created)
- Removes focus listener and disposes FocusNode (if internally created)

## Form Integration

`PinCodeFormField` extends `FormField<String>` and wraps `PinCodeTextField`:
- Supports standard form validation via `validator`
- Includes `onSaved` callback
- Displays error text below field
- Supports `autovalidateMode`

## Recent Refactoring Context

Recent commits indicate major restructuring:
- Renamed from `pin_code_text_fields` to `pin_code_fields`
- Improved variable naming throughout
- Removed unnecessary/deprecated fields
- Fixed late initialization errors
- Better separation of concerns in widget hierarchy

Files were renamed:
- `lib/pin_code_text_fields.dart` → `lib/pin_code_fields.dart`
- `lib/src/pin_code_text_fields_state.dart` → `lib/src/pin_code_fields_state.dart`

## Known TODOs

- Add custom cell builder for complete developer freedom in rendering
- Complete test coverage (currently empty)
- Finalize CHANGELOG
- Add LICENSE information
- Pin autofill integration needs re-implementation
