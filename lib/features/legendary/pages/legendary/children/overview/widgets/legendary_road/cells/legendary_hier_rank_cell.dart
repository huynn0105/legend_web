import 'package:legend_mfast/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/widgets/legendary_hier_rank_text.dart';

class LegendaryHierRankCell extends StatelessWidget {
  const LegendaryHierRankCell({
    super.key,
    required this.title,
    required this.star,
    required this.primaryColor,
    required this.backgroundColor,
    required this.width,
    required this.height,
    this.showRightBorder = true,
    this.showCornerBorder = true,
  });

  final String title;
  final int star;
  final Color backgroundColor;
  final Color primaryColor;
  final double width;
  final double height;
  final bool showRightBorder;
  final bool showCornerBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      constraints: BoxConstraints(
        minWidth: width,
      ),
      decoration: BoxDecoration(
        color: primaryColor,
      ),
      padding: EdgeInsets.only(bottom: 2, right: showRightBorder ? 2 : 0),
      child: Material(
        elevation: 0,
        color: UIColors.white,
        clipBehavior: Clip.antiAlias,
        shape: !showCornerBorder
            ? null
            : const BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12),
                ),
              ),
        child: Center(
          child: HierRankText(
            title: title,
            star: star,
            color: primaryColor,
            splitBy: '\n',
            showShortStar: true,
          ),
        ),
      ),
    );
  }
}
