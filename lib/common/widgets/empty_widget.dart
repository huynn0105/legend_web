import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/widgets/images.dart';

import '../styles.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
    this.icon = "ic_mtrade_mascot_no_data",
    this.message = "Không tìm thấy sản phẩm",
    this.iconWidth,
    this.iconHeight,
  }) : super(key: key);

  final String icon;
  final String message;
  final double? iconWidth;
  final double? iconHeight;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppImage.asset(
            asset: icon,
            width: iconWidth ?? 140,
            height: iconHeight ?? 140,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            message,
            style: UITextStyle.regular.copyWith(
              fontSize: 14,
              color: UIColors.grayText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
