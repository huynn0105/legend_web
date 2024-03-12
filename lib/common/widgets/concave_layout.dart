
import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';

class ConcaveLayout extends StatelessWidget {
  const ConcaveLayout({super.key, this.child, this.height = 250});
  final Widget? child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CustomPaint(
        painter: const ConcavePainter(),
        child: SizedBox(
          width: double.infinity,
          height: height,
          child: child,
        ),
      ),
    );
  }
}

class ConcavePainter extends CustomPainter {
  const ConcavePainter();

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    Paint paint = Paint();
    paint.shader = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        UIColors.white,
        UIColors.background,
      ],
    ).createShader(rect);

    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(size.width / 2, size.height / 4, size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}