// --- Example Widgets ---

// Helper type for shared config
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_text_fields/pin_code_text_fields.dart';

typedef PinConfig = Map<String, dynamic>;

// Helper to create a subtle BoxShadow list
List<BoxShadow> _defaultBoxShadow(BuildContext context) => [
      BoxShadow(
        color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
        blurRadius: 4,
        offset: const Offset(0, 2),
      )
    ];

class BasicExample extends StatelessWidget {
  final PinConfig config;
  final StreamController<ErrorAnimationType>? errorController;

  const BasicExample({super.key, required this.config, this.errorController});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Basic Box Shape"),
        const SizedBox(height: 10),
        PinCodeTextField(
          length: 6,
          obscureText: config['obscureText'],
          readOnly: config['readOnly'],
          enableContextMenu: config['enableContextMenu'],
          onChanged: config['onChanged'],
          onCompleted: config['onCompleted'],
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            // --- Appearance ---
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            fieldHeight: 50,
            fieldWidth: 45,
            // --- Spacing ---
            fieldOuterPadding:
                const EdgeInsets.symmetric(horizontal: 4), // Add spacing
            // --- Colors ---
            activeFillColor: colorScheme.primary.withOpacity(0.1),
            inactiveFillColor: colorScheme.surfaceVariant,
            selectedFillColor: colorScheme.secondary.withOpacity(0.1),
            activeColor: colorScheme.primary,
            inactiveColor: colorScheme.onSurface.withOpacity(0.3),
            selectedColor: colorScheme.secondary,
            errorBorderColor: colorScheme.error,
            borderWidth: 1.5,
          ),
          boxShadows: _defaultBoxShadow(context),
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          errorAnimationController: errorController,
          // controller: textEditingController, // Pass controller if needed
          keyboardType: TextInputType.number,
          onTap: () {
            print("Pressed");
          },
        ),
      ],
    );
  }
}

class UnderlineExample extends StatelessWidget {
  final PinConfig config;

  const UnderlineExample({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Underline Shape"),
        const SizedBox(height: 10),
        PinCodeTextField(
          length: 6,
          obscureText: config['obscureText'],
          readOnly: config['readOnly'],
          enableContextMenu: config['enableContextMenu'],
          onChanged: config['onChanged'],
          onCompleted: config['onCompleted'],
          animationType: AnimationType.slide,
          pinTheme: PinTheme(
            // --- Appearance ---
            shape: PinCodeFieldShape.underline,
            fieldHeight: 60,
            fieldWidth: 50,
            // --- Spacing ---
            fieldOuterPadding:
                const EdgeInsets.symmetric(horizontal: 5), // Add spacing
            // --- Colors ---
            activeColor: Theme.of(context).colorScheme.primary,
            inactiveColor:
                Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            selectedColor: Theme.of(context).colorScheme.secondary,
            errorBorderColor: Theme.of(context).colorScheme.error,
            // Fill colors don't apply to underline
            activeFillColor: Colors.transparent,
            inactiveFillColor: Colors.transparent,
            selectedFillColor: Colors.transparent,
            borderWidth: 2, // Thickness of the underline
          ),
          animationDuration: const Duration(milliseconds: 250),
          enableActiveFill: false,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}

class CircleExample extends StatelessWidget {
  final PinConfig config;

  const CircleExample({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Circle Shape"),
        const SizedBox(height: 10),
        PinCodeTextField(
          length: 6,
          obscureText: config['obscureText'],
          readOnly: config['readOnly'],
          enableContextMenu: config['enableContextMenu'],
          onChanged: config['onChanged'],
          onCompleted: config['onCompleted'],
          animationType: AnimationType.scale,
          pinTheme: PinTheme(
            // --- Appearance ---
            shape: PinCodeFieldShape.circle,
            fieldHeight: 60,
            fieldWidth: 60,
            // --- Spacing ---
            fieldOuterPadding:
                const EdgeInsets.symmetric(horizontal: 5), // Add spacing
            // --- Colors ---
            activeFillColor: colorScheme.primary.withOpacity(0.1),
            inactiveFillColor: colorScheme.surfaceVariant,
            selectedFillColor: colorScheme.secondary.withOpacity(0.1),
            activeColor: colorScheme.primary,
            inactiveColor: colorScheme.onSurface.withOpacity(0.3),
            selectedColor: colorScheme.secondary,
            errorBorderColor: colorScheme.error,
            borderWidth: 1.5,
          ),
          boxShadows:
              _defaultBoxShadow(context), // Add subtle shadow to circles too
          animationDuration: const Duration(milliseconds: 350),
          enableActiveFill: true,
          hintCharacter: '-', // Optional hint for empty cells
          obscuringCharacter: '*', // Optional obscuring char
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}

class CustomExample extends StatelessWidget {
  final PinConfig config;
  final StreamController<ErrorAnimationType>? errorController;

  const CustomExample({super.key, required this.config, this.errorController});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Custom Shape (Box + Separator)"),
        const SizedBox(height: 10),
        PinCodeTextField(
          length: 5, // Example length
          obscureText: config['obscureText'],
          readOnly: config['readOnly'],
          enableContextMenu: config['enableContextMenu'],
          onChanged: config['onChanged'],
          onCompleted: config['onCompleted'],
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            // --- Appearance ---
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(10),
            fieldHeight: 55,
            fieldWidth: 45,
            // --- Spacing (separator provides some) ---
            fieldOuterPadding: const EdgeInsets.symmetric(
                horizontal: 2), // Less needed due to separator
            // --- Colors (Keep custom colors, but maybe refine slightly) ---
            activeColor: Colors.green.shade600,
            inactiveColor: Colors.grey.shade400,
            selectedColor: Colors.blue.shade600,
            errorBorderColor: Colors.red.shade600,
            activeFillColor: Colors.green.shade50,
            inactiveFillColor: Colors.grey.shade100,
            selectedFillColor: Colors.blue.shade50,
            borderWidth: 1.5,
          ),
          boxShadows: _defaultBoxShadow(context),
          animationDuration: const Duration(milliseconds: 200),
          enableActiveFill: true,
          errorAnimationController: errorController,
          keyboardType: TextInputType.number,
          separatorBuilder: (context, index) =>
              const SizedBox(width: 8), // Adds space between cells
          mainAxisAlignment: MainAxisAlignment.center, // Center the cells
        ),
      ],
    );
  }
}

class ReadOnlyExample extends StatelessWidget {
  final PinConfig config;
  final TextEditingController? controller;

  const ReadOnlyExample({super.key, required this.config, this.controller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Read-Only Example"),
        const SizedBox(height: 10),
        PinCodeTextField(
          length: 4, // Match controller text length
          controller: controller, // Pre-fill with controller
          readOnly: true, // Make it read-only
          obscureText: false, // Don't obscure read-only
          enableContextMenu: false, // Disable menu for read-only
          onChanged: (value) {}, // No change expected
          onCompleted: (value) {}, // No completion expected
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            fieldHeight: 50,
            fieldWidth: 45,
            // --- Spacing ---
            fieldOuterPadding:
                const EdgeInsets.symmetric(horizontal: 4), // Add spacing
            // Use greyed-out style for read-only
            activeFillColor: colorScheme.onSurface.withOpacity(0.1),
            inactiveFillColor: colorScheme.onSurface.withOpacity(0.1),
            selectedFillColor: colorScheme.onSurface.withOpacity(0.1),
            activeColor: colorScheme.onSurface.withOpacity(0.2),
            inactiveColor: colorScheme.onSurface.withOpacity(0.2),
            selectedColor: colorScheme.onSurface.withOpacity(0.2),
            borderWidth: 1.5,
          ),
          boxShadows: _defaultBoxShadow(context),
          enableActiveFill: true,
        ),
      ],
    );
  }
}

void main() {
  runApp(const PinCodeTextFieldsExampleApp());
}

// Enum to identify examples
enum ExampleType {
  basic,
  underline,
  circle,
  custom,
  readOnly,
}

class PinCodeTextFieldsExampleApp extends StatelessWidget {
  const PinCodeTextFieldsExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PIN Code Text Fields Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.blue,
          selectionColor: Colors.blueAccent,
          selectionHandleColor: Colors.blue,
        ),
      ),
      home: const PinCodeDemoPage(),
    );
  }
}

class PinCodeDemoPage extends StatefulWidget {
  const PinCodeDemoPage({super.key});

  @override
  State<PinCodeDemoPage> createState() => _PinCodeDemoPageState();
}

class _PinCodeDemoPageState extends State<PinCodeDemoPage> {
  // --- State for Controls ---
  String _currentCode = "";
  bool _obscureText = false;
  bool _showContextMenu = true;
  bool _isReadOnly = false;
  ExampleType _selectedExample = ExampleType.basic;

  // --- Controllers (Specific examples might need their own) ---
  final StreamController<ErrorAnimationType> _basicErrorController =
      StreamController<ErrorAnimationType>.broadcast();
  final StreamController<ErrorAnimationType> _customErrorController =
      StreamController<ErrorAnimationType>.broadcast();
  final TextEditingController _readOnlyController =
      TextEditingController(text: "1234");

  // --- Snackbar Helper ---
  final Duration _snackBarDuration = const Duration(milliseconds: 1200);
  void _showSnackBar(String message) {
    if (!mounted) return; // Check if the state is still mounted
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: _snackBarDuration),
    );
  }

  @override
  void dispose() {
    _basicErrorController.close();
    _customErrorController.close();
    _readOnlyController.dispose(); // Dispose controller managed here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PIN Code Examples'),
      ),
      body: Column(
        // Use Column: Dropdown, Example, Controls
        children: [
          // --- Example Selector Dropdown ---
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: DropdownButton<ExampleType>(
              value: _selectedExample,
              isExpanded: true,
              onChanged: (ExampleType? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedExample = newValue;
                    _currentCode = ""; // Reset code display on example change
                  });
                }
              },
              items: ExampleType.values
                  .map<DropdownMenuItem<ExampleType>>((ExampleType value) {
                return DropdownMenuItem<ExampleType>(
                  value: value,
                  child: Text(_getExampleName(value)),
                );
              }).toList(),
            ),
          ),
          const Divider(),

          // --- Selected Example Area ---
          Expanded(
            // Allow the example to take available space
            child: SingleChildScrollView(
              // Make the example area scrollable if needed
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: _buildSelectedExample(),
            ),
          ),
          const Divider(),

          // --- Control Pad ---
          _buildControlPad(context),

          // --- Current Code Display ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Center(
              child: Text(
                'Current Code: $_currentCode',
                style: theme.textTheme.headlineSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper to get readable names for enum values
  String _getExampleName(ExampleType type) {
    switch (type) {
      case ExampleType.basic:
        return 'Basic (Box Shape)';
      case ExampleType.underline:
        return 'Underline Shape';
      case ExampleType.circle:
        return 'Circle Shape (Custom Obscuring & Hint)';
      case ExampleType.custom:
        return 'Custom Theme (Gradient & Separator)';
      case ExampleType.readOnly:
        return 'Read-Only Example';
    }
  }

  // Builds the currently selected example widget
  Widget _buildSelectedExample() {
    final sharedConfig = {
      'obscureText': _obscureText,
      'enableContextMenu': _showContextMenu,
      'readOnly': _isReadOnly && _selectedExample != ExampleType.readOnly,
      'onChanged': (value) => setState(() => _currentCode = value),
      'onCompleted': (value) => _showSnackBar("Completed: $value"),
    };

    switch (_selectedExample) {
      case ExampleType.basic:
        return BasicExample(
          config: sharedConfig,
          errorController: _basicErrorController,
        );
      case ExampleType.underline:
        return UnderlineExample(config: sharedConfig);
      case ExampleType.circle:
        return CircleExample(config: sharedConfig);
      case ExampleType.custom:
        return CustomExample(
          config: sharedConfig,
          errorController: _customErrorController,
        );
      case ExampleType.readOnly:
        // Override readOnly for the specific example
        final readOnlyConfig = Map<String, dynamic>.from(sharedConfig);
        readOnlyConfig['readOnly'] = true;
        readOnlyConfig['enableContextMenu'] = false; // Disable context menu too
        return ReadOnlyExample(
          config: readOnlyConfig,
          controller: _readOnlyController,
        );
    }
  }

  // Control Pad Widget
  Widget _buildControlPad(BuildContext context) {
    // ReadOnly example should ignore the toggle
    final bool canToggleReadOnly = _selectedExample != ExampleType.readOnly;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Wrap(
        spacing: 10,
        runSpacing: 5,
        alignment: WrapAlignment.center,
        children: [
          Chip(
            label: const Text('Obscure'),
            avatar: CircleAvatar(
                child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility)),
            deleteIcon: Switch(
              value: _obscureText,
              onChanged: (bool value) => setState(() => _obscureText = value),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onDeleted: () {},
          ),
          Chip(
            label: const Text('Context Menu'),
            avatar: CircleAvatar(
                child: Icon(_showContextMenu
                    ? Icons.content_paste
                    : Icons.content_paste_off)),
            deleteIcon: Switch(
              value: _showContextMenu,
              // Disable toggle for read-only example
              onChanged: canToggleReadOnly
                  ? (bool value) => setState(() => _showContextMenu = value)
                  : null,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onDeleted: () {},
          ),
          Chip(
            label: const Text('ReadOnly'),
            avatar: CircleAvatar(
                child:
                    Icon(_isReadOnly ? Icons.lock_outline : Icons.lock_open)),
            deleteIcon: Switch(
              value: _isReadOnly,
              // Disable toggle for read-only example itself
              onChanged: canToggleReadOnly
                  ? (bool value) => setState(() => _isReadOnly = value)
                  : null,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onDeleted: () {},
          ),
          // Conditionally show error buttons
          if (_selectedExample == ExampleType.basic ||
              _selectedExample == ExampleType.custom)
            ElevatedButton(
              onPressed: () {
                if (_selectedExample == ExampleType.basic) {
                  _basicErrorController.add(ErrorAnimationType.shake);
                } else if (_selectedExample == ExampleType.custom) {
                  _customErrorController.add(ErrorAnimationType.shake);
                }
              },
              child: const Text("Trigger Error Shake"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent),
            ),
          ElevatedButton.icon(
            icon: const Icon(Icons.clear),
            label: const Text("Clear Displayed Code"),
            onPressed: () {
              // This only clears the displayed string, not the field itself easily
              setState(() => _currentCode = "");
              _showSnackBar("Displayed code cleared");
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
          ),
        ],
      ),
    );
  }
}
