import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'theme/liquid_glass_pin_theme.dart';
import 'cells/separate_glass_cells.dart';
import 'cells/unified_glass_cell.dart';
import 'cells/blended_glass_cells.dart';

/// A PIN input field with iOS 26 Liquid Glass styling.
///
/// This widget uses [liquid_glass_renderer] for GPU-accelerated glass effects
/// and builds on [pin_code_fields] for the input handling.
///
/// **Note:** This widget requires Impeller rendering engine and only works on
/// iOS, Android, and macOS. Web, Windows, and Linux are not supported.
///
/// ## Example
///
/// ```dart
/// LiquidGlassPinField(
///   length: 6,
///   theme: LiquidGlassPinTheme.blended(
///     blur: 10,
///     glassColor: Colors.white.withOpacity(0.2),
///   ),
///   onCompleted: (pin) => print('PIN: $pin'),
/// )
/// ```
///
/// ## Styles
///
/// Three styles are available via [LiquidGlassPinTheme]:
/// - [LiquidGlassPinTheme.separate] - Individual glass cells with spacing
/// - [LiquidGlassPinTheme.unified] - One glass container with dividers
/// - [LiquidGlassPinTheme.blended] - Cells that blend together (iOS 26 style)
class LiquidGlassPinField extends StatefulWidget {
  const LiquidGlassPinField({
    super.key,
    required this.length,
    this.theme = const SeparateGlassTheme(),
    // Controller
    this.pinController,
    this.initialValue,
    // Input behavior
    this.keyboardType = TextInputType.number,
    this.textInputAction = TextInputAction.done,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints = const [AutofillHints.oneTimeCode],
    // Behavior
    this.enabled = true,
    this.autoFocus = false,
    this.readOnly = false,
    this.autoDismissKeyboard = true,
    this.clearErrorOnInput = true,
    this.obscureText = false,
    this.obscuringCharacter = '●',
    this.obscuringWidget,
    this.blinkWhenObscuring = true,
    this.blinkDuration = const Duration(milliseconds: 500),
    // Haptics
    this.enableHapticFeedback = true,
    this.hapticFeedbackType = HapticFeedbackType.light,
    // Gestures
    this.enablePaste = true,
    this.selectionControls,
    this.contextMenuBuilder,
    // Clipboard
    this.onClipboardFound,
    this.clipboardValidator,
    // Callbacks
    this.onChanged,
    this.onCompleted,
    this.onSubmitted,
    this.onEditingComplete,
    this.onTap,
    this.onLongPress,
    this.onTapOutside,
    // Cursor
    this.mouseCursor,
    // Keyboard
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20),
    // Autofill
    this.enableAutofill = true,
    this.autofillContextAction = AutofillContextAction.commit,
    // Error display
    this.errorText,
  });

  /// Number of PIN digits.
  final int length;

  /// Theme configuration for the liquid glass style.
  final LiquidGlassPinTheme theme;

  /// Controller for programmatic control of the PIN field.
  ///
  /// Provides programmatic access to text, error state, and focus.
  /// If not provided, an internal controller will be created and managed.
  final PinInputController? pinController;

  /// Initial value for the PIN input.
  ///
  /// If provided, the PIN field will start with this value pre-filled.
  /// This is a convenience parameter - you can also set initial value
  /// via the controller: `PinInputController(text: '1234')`.
  final String? initialValue;

  /// The type of keyboard to display.
  final TextInputType keyboardType;

  /// The action button to display on the keyboard.
  final TextInputAction textInputAction;

  /// Additional input formatters to apply.
  final List<TextInputFormatter>? inputFormatters;

  /// How to capitalize text input.
  final TextCapitalization textCapitalization;

  /// Autofill hints for the text field.
  final Iterable<String> autofillHints;

  /// Whether the field is enabled.
  ///
  /// When `false`, the field is visually grayed out and does not accept input.
  final bool enabled;

  /// Whether to auto-focus on mount.
  final bool autoFocus;

  /// Whether the field is read-only.
  final bool readOnly;

  /// Whether to dismiss the keyboard when PIN is complete.
  final bool autoDismissKeyboard;

  /// Whether to automatically clear error state when user types.
  ///
  /// When `true` (default), any error state is cleared as soon as the user
  /// enters a new character. Set to `false` if you want the error to persist
  /// until explicitly cleared via `controller.clearError()`.
  final bool clearErrorOnInput;

  /// Whether to obscure the entered text.
  final bool obscureText;

  /// Character used to obscure text.
  final String obscuringCharacter;

  /// Widget to use when obscuring (overrides [obscuringCharacter]).
  final Widget? obscuringWidget;

  /// Whether to briefly show the character before obscuring.
  final bool blinkWhenObscuring;

  /// Duration to show the character before obscuring.
  final Duration blinkDuration;

  /// Whether to trigger haptic feedback on input.
  final bool enableHapticFeedback;

  /// Type of haptic feedback to trigger.
  final HapticFeedbackType hapticFeedbackType;

  /// Whether to enable paste functionality.
  final bool enablePaste;

  /// Custom text selection controls.
  final TextSelectionControls? selectionControls;

  /// Builder for the context menu (paste functionality).
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// Called when the clipboard contains valid PIN-like content on focus.
  ///
  /// This callback is triggered when the field gains focus and the clipboard
  /// contains content that could be pasted.
  final ValueChanged<String>? onClipboardFound;

  /// Custom validator for clipboard content.
  ///
  /// If provided, this function is used instead of the default validation
  /// to determine if clipboard content should trigger [onClipboardFound].
  final bool Function(String text, int length)? clipboardValidator;

  /// Called when the PIN value changes.
  final ValueChanged<String>? onChanged;

  /// Called when all digits are entered.
  final ValueChanged<String>? onCompleted;

  /// Called when the user submits (presses done on keyboard).
  final ValueChanged<String>? onSubmitted;

  /// Called when editing is complete.
  final VoidCallback? onEditingComplete;

  /// Called when the field is tapped.
  final VoidCallback? onTap;

  /// Called when the field is long-pressed.
  final VoidCallback? onLongPress;

  /// Called when user taps outside the field.
  final void Function(PointerDownEvent event)? onTapOutside;

  /// The mouse cursor to show when hovering over the widget.
  final MouseCursor? mouseCursor;

  /// The brightness of the keyboard.
  final Brightness? keyboardAppearance;

  /// Padding when scrolling the field into view.
  final EdgeInsets scrollPadding;

  /// Whether autofill is enabled (e.g., SMS OTP autofill).
  final bool enableAutofill;

  /// Action to perform when the autofill context is disposed.
  final AutofillContextAction autofillContextAction;

  /// Error text to display below the field.
  final String? errorText;

  @override
  State<LiquidGlassPinField> createState() => _LiquidGlassPinFieldState();
}

class _LiquidGlassPinFieldState extends State<LiquidGlassPinField> {
  @override
  Widget build(BuildContext context) {
    final resolvedTheme = widget.theme.resolve(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // The PIN field wrapped in LiquidGlassLayer
        LiquidGlassLayer(
          settings: LiquidGlassSettings(
            // Core glass properties
            thickness: widget.theme.thickness,
            blur: widget.theme.blur,
            glassColor: resolvedTheme.glassColor,
            visibility: widget.theme.visibility,
            chromaticAberration: widget.theme.chromaticAberration,
            lightAngle: resolvedTheme.lightAngle,
            lightIntensity: widget.theme.lightIntensity,
            ambientStrength: widget.theme.ambientStrength,
            refractiveIndex: widget.theme.refractiveIndex,
            saturation: widget.theme.saturation,
          ),
          child: PinInput(
            length: widget.length,
            // Controller
            pinController: widget.pinController,
            initialValue: widget.initialValue,
            // Input behavior
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            inputFormatters: widget.inputFormatters,
            textCapitalization: widget.textCapitalization,
            autofillHints: widget.autofillHints,
            // Behavior
            enabled: widget.enabled,
            autoFocus: widget.autoFocus,
            readOnly: widget.readOnly,
            autoDismissKeyboard: widget.autoDismissKeyboard,
            clearErrorOnInput: widget.clearErrorOnInput,
            obscureText: widget.obscureText,
            obscuringCharacter: widget.obscuringCharacter,
            blinkWhenObscuring: widget.blinkWhenObscuring,
            blinkDuration: widget.blinkDuration,
            // Haptics
            enableHapticFeedback: widget.enableHapticFeedback,
            hapticFeedbackType: widget.hapticFeedbackType,
            // Gestures
            enablePaste: widget.enablePaste,
            selectionControls: widget.selectionControls,
            contextMenuBuilder: widget.contextMenuBuilder,
            // Clipboard
            onClipboardFound: widget.onClipboardFound,
            clipboardValidator: widget.clipboardValidator,
            // Callbacks
            onChanged: widget.onChanged,
            onCompleted: widget.onCompleted,
            onSubmitted: widget.onSubmitted,
            onEditingComplete: widget.onEditingComplete,
            onTap: widget.onTap,
            onLongPress: widget.onLongPress,
            onTapOutside: widget.onTapOutside,
            // Cursor
            mouseCursor: widget.mouseCursor,
            // Keyboard
            keyboardAppearance: widget.keyboardAppearance,
            scrollPadding: widget.scrollPadding,
            // Autofill
            enableAutofill: widget.enableAutofill,
            autofillContextAction: widget.autofillContextAction,
            // Builder
            builder: (context, cells) {
              return _buildCells(context, cells, resolvedTheme);
            },
          ),
        ),

        // Error text
        if (widget.errorText != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.errorText!,
            style: TextStyle(
              color: resolvedTheme.errorGlowColor,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCells(
    BuildContext context,
    List<PinCellData> cells,
    ResolvedLiquidGlassTheme resolvedTheme,
  ) {
    final theme = widget.theme;

    return switch (theme) {
      SeparateGlassTheme() => SeparateGlassCells(
          cells: cells,
          theme: theme,
          resolvedTheme: resolvedTheme,
          obscureText: widget.obscureText,
          obscuringCharacter: widget.obscuringCharacter,
          obscuringWidget: widget.obscuringWidget,
        ),
      UnifiedGlassTheme() => UnifiedGlassCell(
          cells: cells,
          theme: theme,
          resolvedTheme: resolvedTheme,
          obscureText: widget.obscureText,
          obscuringCharacter: widget.obscuringCharacter,
          obscuringWidget: widget.obscuringWidget,
        ),
      BlendedGlassTheme() => BlendedGlassCells(
          cells: cells,
          theme: theme,
          resolvedTheme: resolvedTheme,
          obscureText: widget.obscureText,
          obscuringCharacter: widget.obscuringCharacter,
          obscuringWidget: widget.obscuringWidget,
        ),
    };
  }
}
