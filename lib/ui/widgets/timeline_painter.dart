import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class TimelineCurvePainter extends CustomPainter {
  final Color lineColor;
  final double progress;

  TimelineCurvePainter({required this.lineColor, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final double cx = size.width / 2;

    path.moveTo(cx, 100);
    path.cubicTo(cx + 100, 150, cx - 100, 300, cx, 450);
    path.cubicTo(cx + 100, 600, cx - 100, 750, cx, 900);

    canvas.drawPath(path, paint);

    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) return;
    final metric = metrics.first;

    final double distance = metric.length * progress.clamp(0.0, 1.0);
    final tangent = metric.getTangentForOffset(distance);
    if (tangent == null) return;

    final Offset pos = tangent.position;
    const double radius = 22.0;

    final circlePaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(pos, radius, circlePaint);

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(pos, radius, borderPaint);

    const icon = Icons.favorite;
    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: 25,
          fontFamily: icon.fontFamily,
          color: Colors.white,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    )..layout();

    final iconOffset =
        pos - Offset(textPainter.width / 2, textPainter.height / 2);
    textPainter.paint(canvas, iconOffset);
  }

  @override
  bool shouldRepaint(covariant TimelineCurvePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.lineColor != lineColor;
  }
}
