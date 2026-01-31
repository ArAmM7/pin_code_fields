import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pin Field Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pin Field Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            'Material Pin Field',
            'Ready-to-use Material Design styled PIN input',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MaterialPinFieldDemo()),
            ),
          ),
          _buildSection(
            context,
            'Core Pin Input',
            'Build your own custom PIN UI using the headless core',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CorePinInputDemo()),
            ),
          ),
          _buildSection(
            context,
            'Shape Variants',
            'See outlined, filled, underlined, and circle shapes',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ShapeVariantsDemo()),
            ),
          ),
          _buildSection(
            context,
            'Error Handling',
            'Demonstrate error states and shake animation',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ErrorHandlingDemo()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    String subtitle, {
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

// Material Pin Field Demo
class MaterialPinFieldDemo extends StatefulWidget {
  const MaterialPinFieldDemo({super.key});

  @override
  State<MaterialPinFieldDemo> createState() => _MaterialPinFieldDemoState();
}

class _MaterialPinFieldDemoState extends State<MaterialPinFieldDemo> {
  String _enteredPin = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Material Pin Field')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter your PIN',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            MaterialPinField(
              length: 6,
              autoFocus: true,
              theme: const MaterialPinTheme(
                shape: MaterialPinShape.outlined,
                cellSize: Size(48, 56),
                borderRadius: BorderRadius.all(Radius.circular(12)),
                entryAnimation: MaterialPinAnimation.scale,
              ),
              onChanged: (value) {
                setState(() => _enteredPin = value);
              },
              onCompleted: (pin) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('PIN entered: $pin')),
                );
              },
            ),
            const SizedBox(height: 24),
            Text('Entered: $_enteredPin'),
          ],
        ),
      ),
    );
  }
}

// Core Pin Input Demo - Custom UI
class CorePinInputDemo extends StatefulWidget {
  const CorePinInputDemo({super.key});

  @override
  State<CorePinInputDemo> createState() => _CorePinInputDemoState();
}

class _CorePinInputDemoState extends State<CorePinInputDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Core Pin Input')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Custom PIN UI',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            PinInput(
              length: 4,
              autoFocus: true,
              builder: (context, cells) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: cells.map((cell) {
                    return Container(
                      width: 60,
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: cell.isFilled
                            ? Theme.of(context).colorScheme.primary
                            : cell.isFocused
                                ? Theme.of(context).colorScheme.primaryContainer
                                : Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                        border: Border.all(
                          color: cell.isFocused
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.outline,
                          width: cell.isFocused ? 2 : 1,
                        ),
                      ),
                      child: Center(
                        child: cell.isFilled
                            ? Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              )
                            : cell.isFocused
                                ? Container(
                                    width: 2,
                                    height: 24,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )
                                : null,
                      ),
                    );
                  }).toList(),
                );
              },
              onCompleted: (pin) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('PIN: $pin')),
                );
              },
            ),
            const SizedBox(height: 32),
            const Text(
              'This demonstrates building a completely custom UI\n'
              'using the headless PinInput from pin_field_core.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// Shape Variants Demo
class ShapeVariantsDemo extends StatelessWidget {
  const ShapeVariantsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shape Variants')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildShapeSection(
            context,
            'Outlined',
            MaterialPinShape.outlined,
          ),
          const SizedBox(height: 32),
          _buildShapeSection(
            context,
            'Filled',
            MaterialPinShape.filled,
          ),
          const SizedBox(height: 32),
          _buildShapeSection(
            context,
            'Underlined',
            MaterialPinShape.underlined,
          ),
          const SizedBox(height: 32),
          _buildShapeSection(
            context,
            'Circle',
            MaterialPinShape.circle,
          ),
        ],
      ),
    );
  }

  Widget _buildShapeSection(
    BuildContext context,
    String title,
    MaterialPinShape shape,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        MaterialPinField(
          length: 4,
          theme: MaterialPinTheme(
            shape: shape,
            cellSize: const Size(56, 64),
          ),
          onCompleted: (pin) {},
        ),
      ],
    );
  }
}

// Error Handling Demo
class ErrorHandlingDemo extends StatefulWidget {
  const ErrorHandlingDemo({super.key});

  @override
  State<ErrorHandlingDemo> createState() => _ErrorHandlingDemoState();
}

class _ErrorHandlingDemoState extends State<ErrorHandlingDemo> {
  // Use the new PinInputController for full control!
  final _pinController = PinInputController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error Handling')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter incorrect PIN (not 1234)',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 32),
            MaterialPinField(
              length: 4,
              pinController: _pinController,
              autoFocus: true,
              theme: MaterialPinTheme(
                shape: MaterialPinShape.outlined,
                cellSize: const Size(56, 64),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                errorColor: Theme.of(context).colorScheme.error,
              ),
              onCompleted: (pin) {
                if (pin != '1234') {
                  // Trigger error using the controller!
                  _pinController.triggerError();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Correct PIN!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            // Use ListenableBuilder to react to controller changes
            ListenableBuilder(
              listenable: _pinController,
              builder: (context, _) {
                if (_pinController.hasError) {
                  return Text(
                    'Incorrect PIN. Try 1234.',
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Clear using the controller!
                _pinController.clear();
              },
              child: const Text('Clear'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Programmatically clear error without clearing text
                _pinController.clearError();
              },
              child: const Text('Clear Error Only'),
            ),
          ],
        ),
      ),
    );
  }
}
