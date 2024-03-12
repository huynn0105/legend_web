import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:legend_mfast/common/colors.dart';

class DottedDivider extends StatelessWidget {
  const DottedDivider({
    super.key,
    this.height = 0,
    this.indent = 0,
    this.endIndent = 0,
    this.color = UIColors.lightGray,
    this.direction = Axis.horizontal,
  });

  final double height;
  final double indent;
  final double endIndent;
  final Color color;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: indent, right: endIndent, top: height, bottom: height),
      child: DottedLine(
        dashLength: 5,
        dashGapLength: 5,
        dashColor: color,
        direction: direction,
      ),
    );
  }
}
