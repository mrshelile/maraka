import 'package:maraka/themes/color.dart';
import 'package:flutter/material.dart';

class BackgroundDesign extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final path = Path();
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5;
    // paint.color = Colors.blueAccent;
    var rect = Offset.zero & size;
    paint.shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.centerRight,
        colors: [MyColors.blue2, MyColors.blue3]).createShader(rect);
    ;
    path.moveTo(size.width * 0.0, 0);
    path.quadraticBezierTo(
        size.width, size.height * 0.2, size.width, size.height);
    // path.quadraticBezierTo(
    //     size.width, 0, size.width, 0);
    //     path.quadraticBezierTo(
    //     size.width, 0, size.width, 0);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    // path.moveTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
