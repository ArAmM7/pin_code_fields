part of '../../pin_code_fields.dart'; // Use library name

// --- Gradiented class remains the same ---
class Gradiented extends StatelessWidget {
  const Gradiented({required this.child, required this.gradient, super.key});

  final Widget child;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) =>
      ShaderMask(shaderCallback: gradient.createShader, child: child);
}
