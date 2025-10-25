part of '../../pin_code_fields.dart';

/// A private widget that handles the underlying EditableText for input handling.
class _UnderlyingEditableText extends StatelessWidget {
  const _UnderlyingEditableText({
    required this.editableTextKey,
    required this.controller,
    required this.focusNode,
    required this.readOnly,
    required this.selectionEnabled,
    required this.selectionControls,
    required this.contextMenuBuilder,
    required this.keyboardType,
    required this.inputFormatters,
    required this.textCapitalization,
    required this.textInputAction,
    required this.onSubmitted,
    required this.onEditingComplete,
    required this.onSelectionChanged,
    required this.keyboardAppearance,
    required this.scrollPadding,
    required this.length,
  });

  final GlobalKey<EditableTextState> editableTextKey;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool readOnly;
  final bool selectionEnabled;
  final TextSelectionControls? selectionControls;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final SelectionChangedCallback onSelectionChanged;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final int length;

  @override
  Widget build(BuildContext context) {
    return EditableText(
      key: editableTextKey,
      controller: controller,
      focusNode: focusNode,
      readOnly: readOnly,
      // Styling & Behavior
      style: const TextStyle(
        color: Colors.transparent,
        fontSize: 0.1,
        height: 0,
      ),
      cursorColor: Colors.transparent,
      backgroundCursorColor: Colors.transparent,
      selectionColor: Colors.transparent,
      showCursor: false,
      showSelectionHandles: false,
      rendererIgnoresPointer: true,
      enableInteractiveSelection: selectionEnabled,
      selectionControls: selectionEnabled ? selectionControls : null,
      contextMenuBuilder: selectionEnabled ? contextMenuBuilder : null,
      // Standard Properties
      keyboardType: keyboardType,
      inputFormatters: [
        LengthLimitingTextInputFormatter(length), // Ensure length limit first
        ...inputFormatters, // Add custom formatters
        if (keyboardType == TextInputType.number)
          FilteringTextInputFormatter
              .digitsOnly, // Apply digit filter last if needed
      ],
      autofocus: false, // Handled in initState
      autocorrect: false,
      enableSuggestions: false,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted, // Pass through callbacks
      onEditingComplete: onEditingComplete,
      onSelectionChanged: onSelectionChanged,
      keyboardAppearance: keyboardAppearance ?? Theme.of(context).brightness,
      scrollPadding: scrollPadding,
      textAlign: TextAlign.center, // Helps with logical cursor positioning
      maxLines: 1,
      clipBehavior: Clip.none, // Allow potential overflow for calculations
    );
  }
}
