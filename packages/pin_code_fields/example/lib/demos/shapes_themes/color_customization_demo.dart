import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/// Color Customization - Interactive color picker
class ColorCustomizationDemo extends StatefulWidget {
  const ColorCustomizationDemo({super.key});

  @override
  State<ColorCustomizationDemo> createState() => _ColorCustomizationDemoState();
}

class _ColorCustomizationDemoState extends State<ColorCustomizationDemo> {
  Color _borderColor = Colors.indigo;
  Color _focusedBorderColor = Colors.indigo;
  Color _fillColor = Colors.transparent;
  Color _focusedFillColor = Colors.indigo.withValues(alpha: 0.1);

  final _colors = [
    Colors.indigo,
    Colors.blue,
    Colors.teal,
    Colors.green,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Color Customization')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Preview
          MaterialPinField(
            length: 4,
            theme: MaterialPinTheme(
              shape: MaterialPinShape.outlined,
              cellSize: const Size(56, 64),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderColor: _borderColor,
              focusedBorderColor: _focusedBorderColor,
              fillColor: _fillColor,
              focusedFillColor: _focusedFillColor,
            ),
            onCompleted: (_) {},
          ),
          const SizedBox(height: 32),

          // Border color picker
          _ColorPickerSection(
            title: 'Border Color',
            colors: _colors,
            selectedColor: _borderColor,
            onColorSelected: (c) => setState(() => _borderColor = c),
          ),
          const SizedBox(height: 16),

          // Focused border color picker
          _ColorPickerSection(
            title: 'Focused Border Color',
            colors: _colors,
            selectedColor: _focusedBorderColor,
            onColorSelected: (c) => setState(() => _focusedBorderColor = c),
          ),
          const SizedBox(height: 16),

          // Fill color picker
          _ColorPickerSection(
            title: 'Fill Color',
            colors: [..._colors.map((c) => c.withValues(alpha: 0.1)), Colors.transparent],
            selectedColor: _fillColor,
            onColorSelected: (c) => setState(() => _fillColor = c),
          ),
          const SizedBox(height: 16),

          // Focused fill color picker
          _ColorPickerSection(
            title: 'Focused Fill Color',
            colors: [..._colors.map((c) => c.withValues(alpha: 0.15)), Colors.transparent],
            selectedColor: _focusedFillColor,
            onColorSelected: (c) => setState(() => _focusedFillColor = c),
          ),
        ],
      ),
    );
  }
}

class _ColorPickerSection extends StatelessWidget {
  const _ColorPickerSection({
    required this.title,
    required this.colors,
    required this.selectedColor,
    required this.onColorSelected,
  });

  final String title;
  final List<Color> colors;
  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: colors.map((color) {
            final isSelected = color == selectedColor;
            return GestureDetector(
              onTap: () => onColorSelected(color),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color == Colors.transparent ? null : color,
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline,
                    width: isSelected ? 3 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: color == Colors.transparent
                    ? Icon(
                        Icons.block,
                        size: 20,
                        color: Theme.of(context).colorScheme.outline,
                      )
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
