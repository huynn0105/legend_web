import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/widgets/images.dart';

class HierRankText extends StatelessWidget {
  const HierRankText({
    super.key,
    required this.title,
    required this.star,
    required this.color,
    this.splitBy = ' • ',
    this.showShortStar = true,
  });

  final String title;
  final int star;
  final Color color;
  final String splitBy;
  final bool showShortStar;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: UITextStyle.bold.copyWith(
              fontSize: 16,
              color: color,
              height: 1.2,
            ),
          ),
          if (star > 0) ...[
            TextSpan(
              text: splitBy,
              style: UITextStyle.semiBold.copyWith(
                fontSize: 16,
                color: UIColors.grayText,
                height: 1.2,
              ),
            ),
            if (showShortStar) ...[
              TextSpan(
                text: '$star ',
                style: UITextStyle.semiBold.copyWith(
                  fontSize: 18,
                  color: color,
                  height: 1.2,
                ),
              ),
              WidgetSpan(
                baseline: TextBaseline.ideographic,
                alignment: PlaceholderAlignment.baseline,
                child: AppImage.asset(
                  asset: 'ic_star',
                  width: 20,
                  height: 20,
                  color: color,
                ),
              ),
            ],
            if (!showShortStar) ...[
              WidgetSpan(
                baseline: TextBaseline.ideographic,
                alignment: PlaceholderAlignment.middle,
                child: SizedBox(
                  height: 24,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      star,
                      (index) {
                        return AppImage.asset(
                          asset: 'ic_star',
                          width: 20,
                          height: 20,
                          color: color,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
