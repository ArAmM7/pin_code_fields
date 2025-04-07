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

class BasicExample extends StatefulWidget {
  final PinConfig config;
  final StreamController<ErrorAnimationType>? errorController;

  const BasicExample({super.key, required this.config, this.errorController});

  @override
  State<BasicExample> createState() => _BasicExampleState();
}

class _BasicExampleState extends State<BasicExample> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Basic Box Shape with Animated Cursor"),
        const SizedBox(height: 10),
        PinCodeTextField(
          length: 6,
          obscureText: widget.config['obscureText'] ?? false,
          readOnly: widget.config['readOnly'] ?? false,
          enableContextMenu: widget.config['enableContextMenu'] ?? true,
          onChanged: widget.config['onChanged'] ?? (value) {},
          onCompleted: widget.config['onCompleted'] ?? (value) {},
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
          errorAnimationController: widget.errorController,
          // controller: textEditingController, // Pass controller if needed
          keyboardType: TextInputType.number,
          onTap: () {
            print("Pressed");
          },
          // Cursor animation properties
          showCursor: true,
          cursorColor: colorScheme.primary,
          animateCursor: true,
          cursorBlinkDuration: const Duration(milliseconds: 800),
          cursorBlinkCurve: Curves.easeInOut,
        ),
      ],
    );
  }

  void triggerErrorAnimation() {
    widget.errorController?.add(ErrorAnimationType.shake);
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
          obscureText: config['obscureText'] ?? false,
          readOnly: config['readOnly'] ?? false,
          enableContextMenu: config['enableContextMenu'] ?? true,
          onChanged: config['onChanged'] ?? (value) {},
          onCompleted: config['onCompleted'] ?? (value) {},
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
          showCursor: true,
          cursorColor: Theme.of(context).colorScheme.primary,
          animateCursor: true,
          cursorBlinkDuration: const Duration(milliseconds: 800),
          cursorBlinkCurve: Curves.easeInOut,
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
        const Text("Circle Shape with Fast Cursor Animation"),
        const SizedBox(height: 10),
        PinCodeTextField(
          length: 6,
          obscureText: config['obscureText'] ?? false,
          readOnly: config['readOnly'] ?? false,
          enableContextMenu: config['enableContextMenu'] ?? true,
          onChanged: config['onChanged'] ?? (value) {},
          onCompleted: config['onCompleted'] ?? (value) {},
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
          // Cursor animation properties with faster blinking
          showCursor: true,
          cursorColor: colorScheme.secondary,
          cursorWidth: 3,
          cursorHeight: 30,
          animateCursor: true,
          cursorBlinkDuration: const Duration(milliseconds: 400),
          cursorBlinkCurve: Curves.easeIn,
        ),
      ],
    );
  }
}

class CustomExample extends StatefulWidget {
  final PinConfig config;
  final StreamController<ErrorAnimationType>? errorController;

  const CustomExample({super.key, required this.config, this.errorController});

  @override
  State<CustomExample> createState() => _CustomExampleState();
}

class _CustomExampleState extends State<CustomExample> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Custom Shape (Box + Separator)"),
        const SizedBox(height: 10),
        PinCodeTextField(
          length: 5, // Example length
          obscureText: widget.config['obscureText'] ?? false,
          readOnly: widget.config['readOnly'] ?? false,
          enableContextMenu: widget.config['enableContextMenu'] ?? true,
          onChanged: widget.config['onChanged'] ?? (value) {},
          onCompleted: widget.config['onCompleted'] ?? (value) {},
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
          errorAnimationController: widget.errorController,
          keyboardType: TextInputType.number,
          separatorBuilder: (context, index) =>
              const SizedBox(width: 8), // Adds space between cells
          mainAxisAlignment: MainAxisAlignment.center, // Center the cells
          showCursor: true,
          cursorColor: Colors.green.shade600,
          animateCursor: true,
          cursorBlinkDuration: const Duration(milliseconds: 800),
          cursorBlinkCurve: Curves.easeInOut,
        ),
      ],
    );
  }

  void triggerErrorAnimation() {
    widget.errorController?.add(ErrorAnimationType.shake);
  }
}

class ReadOnlyExample extends StatelessWidget {
  final PinConfig config;

  const ReadOnlyExample({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Read-Only Mode"),
        const SizedBox(height: 10),
        PinCodeTextField(
          length: 6,
          obscureText: config['obscureText'] ?? false,
          readOnly: true, // Force read-only
          enableContextMenu: config['enableContextMenu'] ?? true,
          onChanged: config['onChanged'] ?? (value) {},
          onCompleted: config['onCompleted'] ?? (value) {},
          animationType: AnimationType.none,
          controller: TextEditingController(text: "123456"), // Pre-filled
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            fieldHeight: 50,
            fieldWidth: 45,
            activeFillColor: Theme.of(context).colorScheme.surfaceVariant,
            inactiveFillColor: Theme.of(context).colorScheme.surfaceVariant,
            selectedFillColor: Theme.of(context).colorScheme.surfaceVariant,
            activeColor: Theme.of(context).colorScheme.outline,
            inactiveColor: Theme.of(context).colorScheme.outline,
            selectedColor: Theme.of(context).colorScheme.outline,
            borderWidth: 1,
          ),
          enableActiveFill: true,
          showCursor: false, // No cursor in read-only mode
          cursorColor: Theme.of(context).colorScheme.outline,
          animateCursor: false,
          cursorBlinkDuration: const Duration(milliseconds: 800),
          cursorBlinkCurve: Curves.easeInOut,
        ),
      ],
    );
  }
}

class GradientExample extends StatelessWidget {
  final PinConfig config;

  const GradientExample({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Define gradients
    final textGradient = LinearGradient(
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.green,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final backgroundGradient = LinearGradient(
      colors: [
        colorScheme.primaryContainer.withOpacity(0.2),
        colorScheme.secondaryContainer.withOpacity(0.2),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final borderGradient = LinearGradient(
      colors: [
        Colors.purple,
        Colors.blue,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "This example demonstrates how to apply gradient effects to the PIN code cells.",
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),
        Text(
          "Text Gradient:",
          style: textTheme.titleSmall,
        ),
        const SizedBox(height: 12),
        PinCodeTextField(
          length: 6,
          obscureText: config['obscureText'] ?? false,
          readOnly: config['readOnly'] ?? false,
          enableContextMenu: config['enableContextMenu'] ?? true,
          onChanged: config['onChanged'] ?? (value) {},
          onCompleted: config['onCompleted'] ?? (value) {},
          textGradient: textGradient,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            fieldHeight: 50,
            fieldWidth: 45,
            fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 4),
            activeColor: Colors.purple,
            inactiveColor: Colors.blue.withOpacity(0.5),
            selectedColor: Colors.green,
            borderWidth: 1.5,
          ),
          animationType: AnimationType.scale,
          animationDuration: const Duration(milliseconds: 300),
          keyboardType: TextInputType.number,
          textStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          showCursor: true,
          cursorColor: Colors.purple,
          animateCursor: true,
          cursorBlinkDuration: const Duration(milliseconds: 800),
          cursorBlinkCurve: Curves.easeInOut,
        ),
        const SizedBox(height: 32),
        Text(
          "Background Gradient (with shader mask for borders):",
          style: textTheme.titleSmall,
        ),
        const SizedBox(height: 12),
        ShaderMask(
          shaderCallback: (bounds) => borderGradient.createShader(bounds),
          child: PinCodeTextField(
            length: 6,
            obscureText: config['obscureText'] ?? false,
            readOnly: config['readOnly'] ?? false,
            enableContextMenu: config['enableContextMenu'] ?? true,
            onChanged: config['onChanged'] ?? (value) {},
            onCompleted: config['onCompleted'] ?? (value) {},
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(8),
              fieldHeight: 50,
              fieldWidth: 45,
              fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 4),
              activeColor: Colors.white, // Will be masked by gradient
              inactiveColor: Colors.white, // Will be masked by gradient
              selectedColor: Colors.white, // Will be masked by gradient
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.white,
              borderWidth: 2.0,
            ),
            animationType: AnimationType.fade,
            animationDuration: const Duration(milliseconds: 300),
            keyboardType: TextInputType.number,
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: colorScheme.onBackground,
            ),
            enableActiveFill: true,
            showCursor: true,
            cursorColor: Colors.purple,
            animateCursor: true,
            cursorBlinkDuration: const Duration(milliseconds: 800),
            cursorBlinkCurve: Curves.easeInOut,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          "Combined Effects:",
          style: textTheme.titleSmall,
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            gradient: backgroundGradient,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.primary.withOpacity(0.3),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: PinCodeTextField(
            length: 6,
            obscureText: config['obscureText'] ?? false,
            readOnly: config['readOnly'] ?? false,
            enableContextMenu: config['enableContextMenu'] ?? true,
            onChanged: config['onChanged'] ?? (value) {},
            onCompleted: config['onCompleted'] ?? (value) {},
            textGradient: textGradient,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.circle,
              borderRadius: BorderRadius.circular(30),
              fieldHeight: 40,
              fieldWidth: 40,
              fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 4),
              activeColor: Colors.purple,
              inactiveColor: Colors.blue.withOpacity(0.5),
              selectedColor: Colors.green,
              activeFillColor: Colors.white.withOpacity(0.8),
              inactiveFillColor: Colors.white.withOpacity(0.5),
              selectedFillColor: Colors.white,
              borderWidth: 1.5,
            ),
            animationType: AnimationType.scale,
            animationDuration: const Duration(milliseconds: 300),
            keyboardType: TextInputType.number,
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            enableActiveFill: true,
            showCursor: true,
            cursorColor: Colors.purple,
            animateCursor: true,
            cursorBlinkDuration: const Duration(milliseconds: 800),
            cursorBlinkCurve: Curves.easeInOut,
            cursorHeight: 24,
          ),
        ),
      ],
    );
  }
}

class FormValidationExample extends StatefulWidget {
  final PinConfig config;

  const FormValidationExample({super.key, required this.config});

  @override
  State<FormValidationExample> createState() => _FormValidationExampleState();
}

class _FormValidationExampleState extends State<FormValidationExample> {
  // --- Form State ---
  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;
  String? _submittedValue;
  final _pinController = TextEditingController();

  // --- Dispose Controllers ---
  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Form validation demonstrates how to integrate the PIN code field with Flutter's form system.",
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter a 6-digit PIN code:",
                style: textTheme.titleSmall,
              ),
              const SizedBox(height: 12),
              PinCodeFormField(
                length: 6,
                controller: _pinController,
                obscureText: widget.config['obscureText'] ?? false,
                readOnly: widget.config['readOnly'] ?? false,
                enableContextMenu: widget.config['enableContextMenu'] ?? true,
                onChanged: (value) {
                  widget.config['onChanged']?.call(value);
                  setState(() {
                    _isValid = _formKey.currentState?.validate() ?? false;
                    _submittedValue = null; // Clear submitted value on change
                  });
                },
                onCompleted: (value) {
                  widget.config['onCompleted']?.call(value);
                  setState(() {
                    _isValid = _formKey.currentState?.validate() ?? false;
                  });
                },
                onSaved: (value) {
                  setState(() {
                    _submittedValue = value;
                  });
                },
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 45,
                  fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 4),
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
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'PIN code is required';
                  }
                  if (value.length < 6) {
                    return 'Please enter all 6 digits';
                  }
                  if (value == '123456') {
                    return 'Please use a more secure PIN';
                  }
                  return null;
                },
                errorTextStyle: TextStyle(
                  color: colorScheme.error,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                showCursor: true,
                cursorColor: colorScheme.primary,
                animateCursor: true,
                cursorBlinkDuration: const Duration(milliseconds: 800),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isValid
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                setState(() {
                                  _submittedValue = _pinController.text;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'PIN code validated successfully!'),
                                    backgroundColor: Colors.green,
                                    behavior: SnackBarBehavior.floating,
                                    width: 300,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              }
                            }
                          : null,
                      icon: const Icon(Icons.check_circle),
                      label: const Text('Submit'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _formKey.currentState?.reset();
                        setState(() {
                          _isValid = false;
                          _submittedValue = null;
                        });
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              if (_submittedValue != null) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Form submitted successfully with PIN: ${widget.config['obscureText'] ?? false ? '******' : _submittedValue}',
                          style: TextStyle(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class CustomPlaceholderExample extends StatelessWidget {
  final PinConfig config;

  const CustomPlaceholderExample({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "This example demonstrates how to customize placeholders in PIN code fields.",
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),
        Text(
          "Text Character Placeholder:",
          style: textTheme.titleSmall,
        ),
        const SizedBox(height: 12),
        PinCodeTextField(
          length: 6,
          obscureText: config['obscureText'] ?? false,
          readOnly: config['readOnly'] ?? false,
          enableContextMenu: config['enableContextMenu'] ?? true,
          onChanged: config['onChanged'] ?? (value) {},
          onCompleted: config['onCompleted'] ?? (value) {},
          hintCharacter: "?",
          hintStyle: TextStyle(
            color: colorScheme.primary.withOpacity(0.5),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            fieldHeight: 50,
            fieldWidth: 45,
            fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 4),
            activeColor: colorScheme.primary,
            inactiveColor: colorScheme.outline,
            selectedColor: colorScheme.secondary,
            activeFillColor: colorScheme.primaryContainer.withOpacity(0.3),
            inactiveFillColor: colorScheme.surfaceVariant,
            selectedFillColor: colorScheme.secondaryContainer.withOpacity(0.3),
            borderWidth: 1.5,
          ),
          animationType: AnimationType.fade,
          animationDuration: const Duration(milliseconds: 300),
          keyboardType: TextInputType.number,
          textStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: colorScheme.onBackground,
          ),
          enableActiveFill: true,
          showCursor: true,
          cursorColor: colorScheme.primary,
          animateCursor: true,
          cursorBlinkDuration: const Duration(milliseconds: 800),
          cursorBlinkCurve: Curves.easeInOut,
        ),
        const SizedBox(height: 32),
        Text(
          "Dash Placeholder:",
          style: textTheme.titleSmall,
        ),
        const SizedBox(height: 12),
        PinCodeTextField(
          length: 6,
          obscureText: config['obscureText'] ?? false,
          readOnly: config['readOnly'] ?? false,
          enableContextMenu: config['enableContextMenu'] ?? true,
          onChanged: config['onChanged'] ?? (value) {},
          onCompleted: config['onCompleted'] ?? (value) {},
          hintCharacter: "-",
          hintStyle: TextStyle(
            color: colorScheme.onSurface.withOpacity(0.5),
            fontSize: 32,
            fontWeight: FontWeight.w300,
          ),
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.underline,
            fieldHeight: 50,
            fieldWidth: 45,
            fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 4),
            activeColor: colorScheme.primary,
            inactiveColor: colorScheme.outline.withOpacity(0.5),
            selectedColor: colorScheme.secondary,
            borderWidth: 2,
          ),
          animationType: AnimationType.slide,
          animationDuration: const Duration(milliseconds: 300),
          keyboardType: TextInputType.number,
          textStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: colorScheme.onBackground,
          ),
          showCursor: true,
          cursorColor: colorScheme.primary,
          animateCursor: true,
          cursorBlinkDuration: const Duration(milliseconds: 800),
          cursorBlinkCurve: Curves.easeInOut,
        ),
        const SizedBox(height: 32),
        Text(
          "Custom Obscuring Widget:",
          style: textTheme.titleSmall,
        ),
        const SizedBox(height: 12),
        PinCodeTextField(
          length: 6,
          obscureText: true, // Force obscure for this example
          readOnly: config['readOnly'] ?? false,
          enableContextMenu: config['enableContextMenu'] ?? true,
          onChanged: config['onChanged'] ?? (value) {},
          onCompleted: config['onCompleted'] ?? (value) {},
          obscuringWidget: Container(
            decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
            width: 15,
            height: 15,
          ),
          blinkWhenObscuring: true,
          blinkDuration: const Duration(milliseconds: 800),
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            fieldHeight: 50,
            fieldWidth: 45,
            fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 4),
            activeColor: colorScheme.primary,
            inactiveColor: colorScheme.outline,
            selectedColor: colorScheme.secondary,
            activeFillColor: colorScheme.primaryContainer.withOpacity(0.3),
            inactiveFillColor: colorScheme.surfaceVariant,
            selectedFillColor: colorScheme.secondaryContainer.withOpacity(0.3),
            borderWidth: 1.5,
          ),
          animationType: AnimationType.fade,
          animationDuration: const Duration(milliseconds: 300),
          keyboardType: TextInputType.number,
          textStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: colorScheme.onBackground,
          ),
          enableActiveFill: true,
          showCursor: true,
          cursorColor: colorScheme.primary,
          animateCursor: true,
          cursorBlinkDuration: const Duration(milliseconds: 800),
          cursorBlinkCurve: Curves.easeInOut,
        ),
      ],
    );
  }
}

class CustomAnimationExample extends StatefulWidget {
  final PinConfig config;

  const CustomAnimationExample({super.key, required this.config});

  @override
  State<CustomAnimationExample> createState() => _CustomAnimationExampleState();
}

class _CustomAnimationExampleState extends State<CustomAnimationExample> {
  AnimationType _selectedAnimationType = AnimationType.fade;
  Duration _animationDuration = const Duration(milliseconds: 300);
  Curve _animationCurve = Curves.easeInOut;
  bool _animateCursor = true;

  final List<AnimationType> _animationTypes = [
    AnimationType.none,
    AnimationType.fade,
    AnimationType.scale,
    AnimationType.slide,
  ];

  final Map<Curve, String> _curves = {
    Curves.linear: 'Linear',
    Curves.easeIn: 'Ease In',
    Curves.easeOut: 'Ease Out',
    Curves.easeInOut: 'Ease In Out',
    Curves.elasticIn: 'Elastic In',
    Curves.elasticOut: 'Elastic Out',
    Curves.bounceIn: 'Bounce In',
    Curves.bounceOut: 'Bounce Out',
  };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "This example demonstrates different animation types and customizations for PIN code fields.",
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),
        PinCodeTextField(
          length: 6,
          obscureText: widget.config['obscureText'] ?? false,
          readOnly: widget.config['readOnly'] ?? false,
          enableContextMenu: widget.config['enableContextMenu'] ?? true,
          onChanged: widget.config['onChanged'] ?? (value) {},
          onCompleted: widget.config['onCompleted'] ?? (value) {},
          animationType: _selectedAnimationType,
          animationDuration: _animationDuration,
          animationCurve: _animationCurve,
          animateCursor: _animateCursor,
          cursorBlinkDuration: const Duration(milliseconds: 800),
          cursorBlinkCurve: Curves.easeInOut,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            fieldHeight: 60,
            fieldWidth: 50,
            fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 4),
            activeColor: colorScheme.primary,
            inactiveColor: colorScheme.outline,
            selectedColor: colorScheme.secondary,
            activeFillColor: colorScheme.primaryContainer.withOpacity(0.3),
            inactiveFillColor: colorScheme.surfaceVariant,
            selectedFillColor: colorScheme.secondaryContainer.withOpacity(0.3),
            borderWidth: 1.5,
          ),
          keyboardType: TextInputType.number,
          textStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: colorScheme.onBackground,
          ),
          enableActiveFill: true,
          showCursor: true,
          cursorColor: colorScheme.primary,
          cursorWidth: 2,
          cursorHeight: 24,
        ),
        const SizedBox(height: 32),
        Card(
          elevation: 0,
          color: colorScheme.surfaceVariant.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Animation Controls",
                  style: textTheme.titleSmall,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text("Animation Type:", style: textTheme.bodyMedium),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButton<AnimationType>(
                        value: _selectedAnimationType,
                        isExpanded: true,
                        onChanged: (AnimationType? value) {
                          if (value != null) {
                            setState(() {
                              _selectedAnimationType = value;
                            });
                          }
                        },
                        items: _animationTypes
                            .map<DropdownMenuItem<AnimationType>>(
                                (AnimationType value) {
                          return DropdownMenuItem<AnimationType>(
                            value: value,
                            child: Text(_getAnimationTypeName(value)),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text("Animation Curve:", style: textTheme.bodyMedium),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButton<Curve>(
                        value: _animationCurve,
                        isExpanded: true,
                        onChanged: (Curve? value) {
                          if (value != null) {
                            setState(() {
                              _animationCurve = value;
                            });
                          }
                        },
                        items: _curves.entries
                            .map<DropdownMenuItem<Curve>>((entry) {
                          return DropdownMenuItem<Curve>(
                            value: entry.key,
                            child: Text(entry.value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                    "Animation Duration: ${_animationDuration.inMilliseconds}ms",
                    style: textTheme.bodyMedium),
                Slider(
                  value: _animationDuration.inMilliseconds.toDouble(),
                  min: 100,
                  max: 1000,
                  divisions: 9,
                  label: "${_animationDuration.inMilliseconds}ms",
                  onChanged: (double value) {
                    setState(() {
                      _animationDuration =
                          Duration(milliseconds: value.round());
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text("Animate Cursor:", style: textTheme.bodyMedium),
                    const Spacer(),
                    Switch(
                      value: _animateCursor,
                      onChanged: (bool value) {
                        setState(() {
                          _animateCursor = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getAnimationTypeName(AnimationType type) {
    switch (type) {
      case AnimationType.none:
        return 'None';
      case AnimationType.fade:
        return 'Fade';
      case AnimationType.scale:
        return 'Scale';
      case AnimationType.slide:
        return 'Slide';
    }
  }
}

class PinCodeTextFieldsExampleApp extends StatelessWidget {
  const PinCodeTextFieldsExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pin Code Text Fields Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  ExampleType _selectedExample = ExampleType.basic;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Initialize shared config with default values to avoid late initialization errors
  final Map<String, dynamic> sharedConfig = {
    'obscureText': false,
    'readOnly': false,
    'enableContextMenu': true,
    'onChanged': (String value) {},
    'onCompleted': (String value) {},
  };

  // Error controllers for examples that need them
  final StreamController<ErrorAnimationType> _errorController =
      StreamController<ErrorAnimationType>.broadcast();
  final GlobalKey<_BasicExampleState> _basicExampleKey =
      GlobalKey<_BasicExampleState>();
  final GlobalKey<_CustomExampleState> _customExampleKey =
      GlobalKey<_CustomExampleState>();

  @override
  void dispose() {
    _errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Pin Code Text Fields Demo'),
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Example Type',
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    _buildExampleSelector(isSmallScreen),
                    const SizedBox(height: 24),
                    Card(
                      elevation: 0,
                      color: colorScheme.surfaceVariant.withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getExampleTitle(_selectedExample),
                              style: textTheme.titleLarge,
                            ),
                            const Divider(),
                            const SizedBox(height: 16),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: constraints.maxWidth,
                                minHeight: 100,
                              ),
                              child: _buildExample(_selectedExample),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildControlPanel(isSmallScreen),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildExampleSelector(bool isSmallScreen) {
    if (isSmallScreen) {
      // For small screens, use a dropdown
      return DropdownButton<ExampleType>(
        isExpanded: true,
        value: _selectedExample,
        onChanged: (ExampleType? value) {
          if (value != null) {
            setState(() {
              _selectedExample = value;
            });
          }
        },
        items: ExampleType.values
            .map<DropdownMenuItem<ExampleType>>((ExampleType value) {
          return DropdownMenuItem<ExampleType>(
            value: value,
            child: Text(_getExampleTitle(value)),
          );
        }).toList(),
      );
    } else {
      // For larger screens, use segmented buttons
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SegmentedButton<ExampleType>(
          segments: [
            ButtonSegment<ExampleType>(
              value: ExampleType.basic,
              label: const Text('Basic'),
              icon: const Icon(Icons.pin),
            ),
            ButtonSegment<ExampleType>(
              value: ExampleType.underline,
              label: const Text('Underline'),
              icon: const Icon(Icons.horizontal_rule),
            ),
            ButtonSegment<ExampleType>(
              value: ExampleType.circle,
              label: const Text('Circle'),
              icon: const Icon(Icons.circle_outlined),
            ),
            ButtonSegment<ExampleType>(
              value: ExampleType.custom,
              label: const Text('Custom'),
              icon: const Icon(Icons.dashboard_customize),
            ),
            ButtonSegment<ExampleType>(
              value: ExampleType.readOnly,
              label: const Text('Read-Only'),
              icon: const Icon(Icons.lock),
            ),
            ButtonSegment<ExampleType>(
              value: ExampleType.formValidation,
              label: const Text('Form'),
              icon: const Icon(Icons.check_circle),
            ),
            ButtonSegment<ExampleType>(
              value: ExampleType.gradient,
              label: const Text('Gradient'),
              icon: const Icon(Icons.gradient),
            ),
            ButtonSegment<ExampleType>(
              value: ExampleType.customPlaceholder,
              label: const Text('Custom Placeholder'),
              icon: const Icon(Icons.text_fields),
            ),
            ButtonSegment<ExampleType>(
              value: ExampleType.customAnimation,
              label: const Text('Custom Animation'),
              icon: const Icon(Icons.animation),
            ),
          ],
          selected: <ExampleType>{_selectedExample},
          onSelectionChanged: (Set<ExampleType> newSelection) {
            setState(() {
              _selectedExample = newSelection.first;
            });
          },
        ),
      );
    }
  }

  Widget _buildControlPanel(bool isSmallScreen) {
    final controlButtons = [
      _buildControlButton(
        'Toggle Obscure',
        Icons.remove_red_eye,
        () {
          setState(() {
            sharedConfig['obscureText'] =
                !(sharedConfig['obscureText'] ?? false);
          });
        },
      ),
      _buildControlButton(
        'Toggle Read-Only',
        Icons.lock,
        () {
          setState(() {
            sharedConfig['readOnly'] = !(sharedConfig['readOnly'] ?? false);
          });
        },
      ),
      _buildControlButton(
        'Toggle Context Menu',
        Icons.menu,
        () {
          setState(() {
            sharedConfig['enableContextMenu'] =
                !(sharedConfig['enableContextMenu'] ?? true);
          });
        },
      ),
      if (_selectedExample == ExampleType.basic ||
          _selectedExample == ExampleType.custom)
        _buildControlButton(
          'Trigger Error Shake',
          Icons.error_outline,
          () {
            _triggerErrorAnimation();
          },
        ),
    ];

    if (isSmallScreen) {
      // For small screens, stack buttons vertically
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: controlButtons.map((button) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: button,
          );
        }).toList(),
      );
    } else {
      // For larger screens, arrange buttons horizontally
      return Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: controlButtons,
      );
    }
  }

  Widget _buildControlButton(
      String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  void _triggerErrorAnimation() {
    if (_selectedExample == ExampleType.basic) {
      _basicExampleKey.currentState?.triggerErrorAnimation();
    } else if (_selectedExample == ExampleType.custom) {
      _customExampleKey.currentState?.triggerErrorAnimation();
    }
  }

  Widget _buildExample(ExampleType type) {
    switch (type) {
      case ExampleType.basic:
        return BasicExample(
          key: _basicExampleKey,
          config: sharedConfig,
          errorController: _errorController,
        );
      case ExampleType.underline:
        return UnderlineExample(config: sharedConfig);
      case ExampleType.circle:
        return CircleExample(config: sharedConfig);
      case ExampleType.custom:
        return CustomExample(
          key: _customExampleKey,
          config: sharedConfig,
          errorController: _errorController,
        );
      case ExampleType.readOnly:
        return ReadOnlyExample(config: sharedConfig);
      case ExampleType.formValidation:
        return FormValidationExample(config: sharedConfig);
      case ExampleType.gradient:
        return GradientExample(config: sharedConfig);
      case ExampleType.customPlaceholder:
        return CustomPlaceholderExample(config: sharedConfig);
      case ExampleType.customAnimation:
        return CustomAnimationExample(config: sharedConfig);
    }
  }

  String _getExampleTitle(ExampleType type) {
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
      case ExampleType.formValidation:
        return 'Form Validation Example';
      case ExampleType.gradient:
        return 'Gradient Example';
      case ExampleType.customPlaceholder:
        return 'Custom Placeholder Example';
      case ExampleType.customAnimation:
        return 'Custom Animation Example';
    }
  }
}

enum ExampleType {
  basic,
  underline,
  circle,
  custom,
  readOnly,
  formValidation,
  gradient,
  customPlaceholder,
  customAnimation,
}

void main() {
  runApp(const PinCodeTextFieldsExampleApp());
}
