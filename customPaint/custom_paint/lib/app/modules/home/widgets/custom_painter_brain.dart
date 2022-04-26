import 'dart:ui';

import 'package:custom_paint/app/modules/home/widgets/points_model.dart';
import 'package:flutter/material.dart';

class CustomPainterBrain extends CustomPainter {
  final List<GroupPoints> offsets;
  final bool isPageViewopen;
  final Color backgrounColor;
  const CustomPainterBrain({
    required this.offsets,
    required this.backgrounColor,
    required this.isPageViewopen,
    Key? key,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (var i = 0; i < offsets.length - 1; i++) {
      paint.color = offsets[i].color;
      paint.strokeWidth = offsets[i].size;
      var x = offsets[i].offsetX;
      var y = offsets[i].offsetY;
      var x1 = offsets[i + 1].offsetX;
      var y1 = offsets[i + 1].offsetY;

      if (isPageViewopen) {
        if (x > 308 || y > 592 || y < 0 || x < 2) {
          x = 0;
          y = 0;
        }
        if (x1 > 308 || y1 > 592 || y1 < 0 || x1 < 2) {
          x1 = 0;
          y1 = 0;
        }
      }
      if (offsets[i].color == Colors.transparent) {
        canvas.drawPoints(
            PointMode.points, [Offset(x, y)], paint..color = backgrounColor);
      } else {
        if (offsets.length < 2 && Offset(x, y) != Offset.zero) {
          if (Offset(x, y) == Offset.zero) {
            continue;
          }
          canvas.drawLine(Offset(x, y), Offset(x1, y1), paint);
        } else if (Offset(x, y) != Offset.zero &&
            Offset(x1, y1) != Offset.zero) {
          canvas.drawLine(Offset(x, y), Offset(x1, y1), paint);
        } else if (Offset(x, y) != Offset.zero &&
            Offset(x1, y1) == Offset.zero) {
          canvas.drawPoints(PointMode.points, [Offset(x, y)], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      this != oldDelegate;
}
