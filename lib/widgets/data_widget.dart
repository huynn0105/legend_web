import 'package:flutter/material.dart';

import '../common/colors.dart';
import '../common/styles.dart';
import '../common/widgets/buttons.dart';
import '../common/widgets/images.dart';

class DataWidget extends StatelessWidget {
  const DataWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.textColor,
    this.onTap,
  }) : super(key: key);
  final String title;
  final String value;
  final Color textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SplashButton(
      onTap: onTap,
      child: Container(
        width: 110,
        padding: const EdgeInsets.only(left: 12, top: 10),
        decoration: BoxDecoration(
          color: UIColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: UITextStyle.regular.copyWith(
                color: UIColors.grayText,
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: UITextStyle.semiBold.copyWith(
                    color: textColor,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                if (onTap != null)
                  const AppImage.asset(
                    asset: "ic_arrow_right",
                    width: 17,
                    height: 17,
                    color: UIColors.grayText,
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
