import 'package:flutter/material.dart';
import 'package:speech_highlighter/src/highlight_decoration.dart';

class HighlightedText extends StatefulWidget {
  final String text;
  final int highlightStart;
  final int highlightEnd;
  final TextStyle textStyle;
  final Duration animationDuration;
  final HighlightDecoration decoration;

  const HighlightedText({
    super.key,
    required this.text,
    required this.highlightStart,
    required this.highlightEnd,
    this.decoration = const HighlightDecoration(color: Colors.yellow),
    this.textStyle = const TextStyle(fontSize: 16, color: Colors.black),
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<HighlightedText> createState() => _HighlightedTextState();
}

class _HighlightedTextState extends State<HighlightedText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _startAnimation;
  late Animation<int> _endAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.animationDuration, vsync: this);
    _startAnimation = IntTween(begin: widget.highlightStart, end: widget.highlightStart).animate(_controller);
    _endAnimation = IntTween(begin: widget.highlightEnd, end: widget.highlightEnd).animate(_controller);
  }

  @override
  void didUpdateWidget(HighlightedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.highlightStart != widget.highlightStart || oldWidget.highlightEnd != widget.highlightEnd) {
      _updateAnimations();
      _controller.forward(from: 0);
    }
  }

  void _updateAnimations() {
    _startAnimation = IntTween(begin: _startAnimation.value, end: widget.highlightStart).animate(_controller);
    _endAnimation = IntTween(begin: _endAnimation.value, end: widget.highlightEnd).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: _HighlightPainter(
                  text: widget.text,
                  textStyle: widget.textStyle,
                  decoration: widget.decoration,
                  highlightStart: _startAnimation.value,
                  highlightEnd: _endAnimation.value,
                ),
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    color: Colors.transparent,
                  ), // Workaround to avoid double text rendering. Should fix this
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _HighlightPainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;
  final HighlightDecoration decoration;
  final int highlightStart;
  final int highlightEnd;

  _HighlightPainter({
    required this.text,
    required this.textStyle,
    required this.decoration,
    required this.highlightStart,
    required this.highlightEnd,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
      maxLines: null,
    );
    textPainter.layout(maxWidth: size.width);

    final paint = Paint()..color = decoration.color;

    final List<TextBox> boxes = textPainter.getBoxesForSelection(
      TextSelection(baseOffset: highlightStart, extentOffset: highlightEnd),
    );

    for (final box in boxes) {
      final highlightRect = Rect.fromLTRB(
        box.left,
        box.top,
        box.right,
        box.bottom,
      ).inflate(2);

      canvas.drawRRect(
        RRect.fromRectAndRadius(highlightRect, decoration.borderRadius),
        paint,
      );
    }

    textPainter.paint(canvas, Offset.zero);
  }

  @override
  bool shouldRepaint(_HighlightPainter oldDelegate) {
    return oldDelegate.highlightStart != highlightStart ||
        oldDelegate.highlightEnd != highlightEnd ||
        oldDelegate.decoration != decoration ||
        oldDelegate.text != text ||
        oldDelegate.textStyle != textStyle;
  }
}
