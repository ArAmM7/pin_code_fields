import 'package:flutter/widgets.dart';

/// Controller for [PinInput] widget.
///
/// This controller provides programmatic access to:
/// - **Text**: Get/set the PIN value, clear it
/// - **Error**: Trigger or clear error state
/// - **Focus**: Request or remove focus
///
/// Example:
/// ```dart
/// final controller = PinInputController();
///
/// // In your widget
/// PinInput(
///   length: 6,
///   pinController: controller,
///   builder: (context, cells) => ...,
/// )
///
/// // Programmatic control
/// controller.setText('1234');
/// controller.triggerError();  // Shows error + shake animation
/// controller.clearError();    // Clears error state
/// controller.clear();         // Clears text
/// controller.requestFocus();  // Opens keyboard
/// ```
///
/// You can also provide your own [TextEditingController] or [FocusNode]:
/// ```dart
/// final textController = TextEditingController();
/// final focusNode = FocusNode();
/// final controller = PinInputController(
///   textController: textController,
///   focusNode: focusNode,
/// );
/// ```
class PinInputController extends ChangeNotifier {
  /// Creates a PIN input controller.
  ///
  /// Optionally provide:
  /// - [text]: Initial text value
  /// - [textController]: External TextEditingController to use
  /// - [focusNode]: External FocusNode to use
  ///
  /// If [textController] or [focusNode] are not provided, internal ones
  /// will be created and managed automatically.
  PinInputController({
    String? text,
    TextEditingController? textController,
    FocusNode? focusNode,
  })  : _textController = textController ?? TextEditingController(text: text),
        _focusNode = focusNode ?? FocusNode(),
        _ownsTextController = textController == null,
        _ownsFocusNode = focusNode == null {
    // If external controller provided with no text, set initial text
    if (textController != null && text != null && textController.text.isEmpty) {
      textController.text = text;
    }
  }

  final TextEditingController _textController;
  final FocusNode _focusNode;
  final bool _ownsTextController;
  final bool _ownsFocusNode;

  bool _hasError = false;
  VoidCallback? _onErrorTriggered;
  bool _isAttached = false;

  /// The underlying [TextEditingController].
  ///
  /// Use this if you need direct access to the text controller.
  TextEditingController get textController => _textController;

  /// The underlying [FocusNode].
  ///
  /// Use this if you need direct access to the focus node.
  FocusNode get focusNode => _focusNode;

  /// Whether the controller is attached to a [PinInput] widget.
  bool get isAttached => _isAttached;

  // ============== Text ==============

  /// The current PIN text.
  String get text => _textController.text;

  /// Sets the PIN text.
  ///
  /// The text will be truncated to the PIN length if it exceeds it.
  set text(String value) {
    _textController.text = value;
  }

  /// Sets the PIN text programmatically.
  ///
  /// This is equivalent to setting [text] directly.
  void setText(String value) {
    text = value;
  }

  /// Clears the PIN text and error state.
  void clear() {
    _textController.clear();
    clearError();
  }

  // ============== Error ==============

  /// Whether the PIN field is in error state.
  bool get hasError => _hasError;

  /// Triggers error state and shake animation.
  ///
  /// The error state will persist until [clearError] is called or
  /// the user starts typing (auto-clear on input).
  void triggerError() {
    if (_hasError) return;
    _hasError = true;
    _onErrorTriggered?.call();
    notifyListeners();
  }

  /// Clears the error state.
  void clearError() {
    if (!_hasError) return;
    _hasError = false;
    notifyListeners();
  }

  // ============== Focus ==============

  /// Whether the PIN field has focus.
  bool get hasFocus => _focusNode.hasFocus;

  /// Requests focus for the PIN field (opens keyboard).
  void requestFocus() {
    _focusNode.requestFocus();
  }

  /// Removes focus from the PIN field (closes keyboard).
  void unfocus() {
    _focusNode.unfocus();
  }

  // ============== Internal (used by PinInput widget) ==============

  /// Attaches the controller to the widget.
  ///
  /// **Internal**: Called by [PinInput]. Do not call directly.
  void attach({required VoidCallback onErrorTriggered}) {
    _onErrorTriggered = onErrorTriggered;
    _isAttached = true;
  }

  /// Detaches the controller from the widget.
  ///
  /// **Internal**: Called by [PinInput]. Do not call directly.
  void detach() {
    _onErrorTriggered = null;
    _isAttached = false;
  }

  /// Updates error state from widget (e.g., when auto-clearing on input).
  ///
  /// **Internal**: Called by [PinInput]. Do not call directly.
  void setErrorState(bool hasError) {
    if (_hasError != hasError) {
      _hasError = hasError;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    if (_ownsTextController) {
      _textController.dispose();
    }
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }
}
