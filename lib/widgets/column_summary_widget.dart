import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';

import '../common/widgets/images.dart';

class ColumnSummaryWidget extends StatelessWidget {
  const ColumnSummaryWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.backgroundColor,
  }) : super(key: key);
  final String title;
  final String value;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 14, top: 8, bottom: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: UITextStyle.regular.copyWith(
              color: UIColors.white.withOpacity(0.7),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: UITextStyle.semiBold.copyWith(
                    color: UIColors.whiteSmoke,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              const AppImage.asset(
                asset: "ic_arrow_right",
                width: 16,
                height: 16,
                color: UIColors.white,
              ),
            ],
          )
        ],
      ),
    );
  }
}
