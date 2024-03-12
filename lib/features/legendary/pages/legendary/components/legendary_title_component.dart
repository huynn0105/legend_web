import 'package:flutter/material.dart';
import 'package:legend_mfast/common/widgets/images.dart';

import '../../../../../common/colors.dart';
import '../../../../../common/styles.dart';

class LegendaryTitleComponent extends StatelessWidget {
  const LegendaryTitleComponent({
    super.key,
    required this.title,
    required this.star,
  });

  final String title;
  final int star;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: UITextStyle.semiBold.copyWith(
            color: UIColors.boldBlue,
            fontSize: 20,
          ),
        ),
        if (star > 0) ...[
          Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: UIColors.darkGray,
            ),
            margin: const EdgeInsets.only(left: 8, right: 8),
          ),
          SizedBox(
            height: 24,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const AppImage.asset(
                  asset: "ic_big_star",
                  height: 24,
                  width: 24,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 4,
                );
              },
              itemCount: star,
            ),
          ),
        ],
      ],
    );
  }
}
