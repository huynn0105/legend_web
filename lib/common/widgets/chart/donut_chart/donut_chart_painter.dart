import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../colors.dart';
import '../../../styles.dart';
import 'donut_chart_data.dart';
import 'donut_chart_helper.dart';
import 'line.dart';

class DonutChartPainter extends CustomPainter {
  DonutChartPainter({
    required this.data,
    required this.donutSize,
  });

  final double donutSize;
  final DonutChartData data;

  final TextStyle titleStyle = UITextStyle.semiBold.copyWith(
    height: 1.2,
    fontSize: 20,
  );
  final TextStyle subtitleStyle = UITextStyle.regular.copyWith(
    fontSize: 13,
    height: 1.2,
    color: UIColors.grayText,
  );
  final TextStyle labelStyle = UITextStyle.regular.copyWith(
    height: 1.2,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final diameter = math.min(size.width, size.height);
    final radius = diameter / 2.0;
    final center = Offset(radius, radius);
    final rect = Rect.fromCenter(
      center: center,
      width: diameter,
      height: diameter,
    );

    drawBaseSection(canvas, center, radius);

    drawChart(canvas, center, diameter, radius, rect);

    drawCenterCircle(canvas, center, radius - donutSize);
  }

  void drawChart(
      Canvas canvas,
      Offset center,
      double diameter,
      double radius,
      Rect rect,
      ) {
    double startDegreeAngle = data.startDegreeAngle;
    List<double> sectionsAngles = data.calculateSectionDegreeAngles();

    // draw sections
    for (int i = 0; i < data.sections.length; i++) {
      final section = data.sections[i];
      final sweepDegreeAngle = (sectionsAngles[i] / 360) * data.animatedAngle;

      if (sweepDegreeAngle >= 360) {
        final paint = Paint()
          ..color = section.color
          ..strokeWidth = section.radius
          ..style = PaintingStyle.fill;
        canvas.drawCircle(
          center,
          radius + section.radius,
          paint,
        );
        return;
      }

      final paths = generateSectionPath(
        section,
        data.dividerWidth,
        startDegreeAngle,
        sweepDegreeAngle,
        center,
        radius - donutSize,
      );
      for (int index = 0; index < paths.length; index++) {
        if (index == 0) {
          drawSection(section, paths[index], canvas);
        } else {
          drawSection(section, paths[index], canvas, color: UIColors.white);
        }
      }
      if (!data.isLoading) {
        drawSectionDivider(canvas, center, radius, startDegreeAngle);
      }
      startDegreeAngle += sweepDegreeAngle;
    }
  }

  void drawCenterCircle(
      Canvas canvas,
      Offset center,
      double radius,
      ) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = UIColors.white;
    canvas.drawCircle(center, radius, paint);
  }

  void drawSection(DonutChartSectionData section, Path sectionPath, Canvas canvasWrapper, {Color? color}) {
    final paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = color ?? section.color;

    canvasWrapper.drawPath(sectionPath, paint);
  }

  void drawBaseSection(
      Canvas canvas,
      Offset center,
      double radius, [
        Color color = UIColors.lightGray,
      ]) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    canvas.drawCircle(center, radius, paint);
  }

  void drawSectionDivider(
      Canvas canvas,
      Offset center,
      double radius,
      double startDegreeAngle,
      ) {
    final startRadianAngel = DonutChartHelper.degreeToRadian(startDegreeAngle);
    final dx = radius * math.cos(startRadianAngel);
    final dy = radius * math.sin(startRadianAngel);
    final point = center + Offset(dx, dy);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = data.dividerWidth
      ..color = UIColors.white;
    canvas.drawLine(center, point, paint);
  }

  List<Path> generateSectionPath(
      DonutChartSectionData section,
      double sectionSpace,
      double tempAngle,
      double sectionDegree,
      Offset center,
      double centerRadius,
      ) {
    final radius = donutSize + (section.radius);
    final sectionRadiusRect = Rect.fromCircle(
      center: center,
      radius: centerRadius + radius,
    );

    final centerRadiusRect = Rect.fromCircle(
      center: center,
      radius: centerRadius,
    );

    final startRadians = DonutChartHelper.degreeToRadian(tempAngle);
    final sweepRadians = DonutChartHelper.degreeToRadian(sectionDegree);
    final endRadians = startRadians + sweepRadians;

    final startLineDirection = Offset(
      math.cos(startRadians),
      math.sin(startRadians),
    );

    final startLineFrom = center + startLineDirection * centerRadius;
    final startLineTo = startLineFrom + startLineDirection * radius;
    final startLine = Line(startLineFrom, startLineTo);

    final endLineDirection = Offset(math.cos(endRadians), math.sin(endRadians));

    final endLineFrom = center + endLineDirection * centerRadius;
    final endLineTo = endLineFrom + endLineDirection * radius;
    final endLine = Line(endLineFrom, endLineTo);

    var sectionPath = Path()
      ..moveTo(startLine.from.dx, startLine.from.dy)
      ..lineTo(startLine.to.dx, startLine.to.dy)
      ..arcTo(sectionRadiusRect, startRadians, sweepRadians, false)
      ..lineTo(endLine.from.dx, endLine.from.dy)
      ..arcTo(centerRadiusRect, endRadians, -sweepRadians, false)
      ..moveTo(startLine.from.dx, startLine.from.dy)
      ..close();

    /// Subtract section space from the sectionPath
    if (sectionSpace != 0) {
      final startLineSeparatorPath = createRectPathAroundLine(
        Line(startLineFrom, startLineTo),
        sectionSpace,
      );
      // Path.combine error in web
      // sectionPath = Path.combine(
      //   PathOperation.difference,
      //   sectionPath,
      //   startLineSeparatorPath,
      // );

      final endLineSeparatorPath = createRectPathAroundLine(
        Line(endLineFrom, endLineTo),
        sectionSpace,
      );

      // sectionPath = Path.combine(
      //   PathOperation.difference,
      //   sectionPath,
      //   endLineSeparatorPath,
      // );
      return [sectionPath, startLineSeparatorPath, endLineSeparatorPath];
    }

    return [sectionPath];
  }

  Path createRectPathAroundLine(
      Line line,
      double width,
      ) {
    width = width / 2;
    final normalized = line.normalize();

    final verticalAngle = line.direction() + (math.pi / 2);
    final verticalDirection = Offset(math.cos(verticalAngle), math.sin(verticalAngle));

    final startPoint1 = Offset(
      line.from.dx - (normalized * (width / 2)).dx - (verticalDirection * width).dx,
      line.from.dy - (normalized * (width / 2)).dy - (verticalDirection * width).dy,
    );

    final startPoint2 = Offset(
      line.to.dx + (normalized * (width / 2)).dx - (verticalDirection * width).dx,
      line.to.dy + (normalized * (width / 2)).dy - (verticalDirection * width).dy,
    );

    final startPoint3 = Offset(
      startPoint2.dx + (verticalDirection * (width * 2)).dx,
      startPoint2.dy + (verticalDirection * (width * 2)).dy,
    );

    final startPoint4 = Offset(
      startPoint1.dx + (verticalDirection * (width * 2)).dx,
      startPoint1.dy + (verticalDirection * (width * 2)).dy,
    );

    return Path()
      ..moveTo(startPoint1.dx, startPoint1.dy)
      ..lineTo(startPoint2.dx, startPoint2.dy)
      ..lineTo(startPoint3.dx, startPoint3.dy)
      ..lineTo(startPoint4.dx, startPoint4.dy)
      ..lineTo(startPoint1.dx, startPoint1.dy);
  }

  // void drawSectionStroke(
  //   DonutChartSectionData section,
  //   Path sectionPath,
  //   Canvas canvasWrapper,
  //   Size viewSize,
  // ) {
  //   const borderSide = BorderSide(
  //     width: 1,
  //     color: UIColors.defaultText,
  //   );
  //   if (borderSide.width != 0.0 && borderSide.color.opacity != 0.0) {
  //     canvasWrapper
  //       ..saveLayer(
  //         Rect.fromLTWH(
  //           0,
  //           0,
  //           viewSize.width,
  //           viewSize.height,
  //         ),
  //         Paint(),
  //       )
  //       ..clipPath(sectionPath);
  //
  //     final sectionStrokePaint = Paint()
  //       ..style = PaintingStyle.stroke
  //       ..strokeWidth = borderSide.width * 2
  //       ..color = borderSide.color;
  //
  //     canvasWrapper
  //       ..drawPath(
  //         sectionPath,
  //         sectionStrokePaint,
  //       )
  //       ..restore();
  //   }
  // }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    final old = (oldDelegate as DonutChartPainter);
    return old.data.animatedAngle != data.animatedAngle || old.data.sections != data.sections;
  }
}
