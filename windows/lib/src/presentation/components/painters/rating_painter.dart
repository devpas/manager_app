import 'package:flutter/material.dart';

class RatingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint shadowPaint = Paint()
      ..color = const Color.fromRGBO(181, 134, 21, 1)
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 15);

    canvas.drawPath(
      Path()
        ..addRect(
          Rect.fromPoints(
            Offset(20, size.height - 10),
            Offset(size.width - 20, size.height),
          ),
        )
        ..fillType = PathFillType.evenOdd,
      shadowPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
