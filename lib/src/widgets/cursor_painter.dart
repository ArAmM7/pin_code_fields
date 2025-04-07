part of '../../pin_code_text_fields.dart'; // Use library name

class CursorPainter extends CustomPainter {
  CursorPainter({this.cursorColor = Colors.black, this.cursorWidth = 2});

  final Color cursorColor;
  final double cursorWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(cursorWidth / 2, 0); // Center the line horizontally
    final p2 = Offset(cursorWidth / 2, size.height);
    final paint = Paint()
      ..color = cursorColor
      ..strokeWidth = cursorWidth;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
