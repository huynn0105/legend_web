import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/widgets/images.dart';

class RatingComponent extends StatelessWidget {
  const RatingComponent({
    super.key,
    this.maxStar = 5,
    this.star = 0,
    this.size = 16,
    this.spacing = 0,
  });

  final int maxStar;
  final double star;
  final double size;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final ceilStar = star.ceil();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStar, (index) {
        index = index + 1;
        final isActive = index < star;
        final isHalf = !isActive && index == ceilStar;
        final double padding = index > 1 ? spacing : 0;

        if (isHalf) {
          final activeRatio = (1 - (ceilStar - star));
          return Padding(
            padding: EdgeInsets.only(left: padding),
            child: Stack(
              children: [
                AppImage.asset(
                  asset: "ic_star",
                  width: size,
                  height: size,
                  color: UIColors.lightGray,
                ),
                AppImage.asset(
                  asset: "ic_star",
                  width: size * activeRatio,
                  height: size,
                  color: UIColors.green,
                  fit: BoxFit.cover,
                  alignment: Alignment.centerLeft,
                ),
              ],
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.only(left: padding),
          child: AppImage.asset(
            asset: "ic_star",
            width: size,
            height: size,
            color: isActive ? UIColors.green : UIColors.lightGray,
          ),
        );
      }),
    );
  }
}
