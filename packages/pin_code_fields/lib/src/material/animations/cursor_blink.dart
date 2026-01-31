import 'package:flutter/material.dart';

/// A widget that displays a blinking cursor.
///
/// The cursor blinks by animating its opacity from 0 to 1.
class CursorBlink extends StatefulWidget {
  const CursorBlink({
    super.key,
    required this.color,
    required this.width,
    required this.height,
    this.animate = true,
    this.duration = const Duration(milliseconds: 500),
  });

  /// The color of the cursor.
  final Color color;

  /// The width of the cursor.
  final double width;

  /// The height of the cursor.
  final double height;

  /// Whether to animate the cursor.
  final bool animate;

  /// Duration of one blink cycle.
  final Duration duration;

  @override
  State<CursorBlink> createState() => _CursorBlinkState();
}

class _CursorBlinkState extends State<CursorBlink>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    if (widget.animate) {
      _controller.repeat(reverse: true);
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(CursorBlink oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate != oldWidget.animate) {
      if (widget.animate) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
        _controller.value = 1.0;
      }
    }
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.animate) {
      return _buildCursor(1.0);
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => _buildCursor(_animation.value),
    );
  }

  Widget _buildCursor(double opacity) {
    return Center(
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: widget.width,
          height: widget.height,
          color: widget.color,
        ),
      ),
    );
  }
}
