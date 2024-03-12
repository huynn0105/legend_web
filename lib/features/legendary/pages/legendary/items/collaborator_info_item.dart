import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/images.dart';

class CollaboratorInfoItem extends StatelessWidget {
  const CollaboratorInfoItem({
    super.key,
    required this.title,
    required this.asset,
    required this.onTap,
  });

  final String title;
  final String asset;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SplashButton(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: UITextStyle.medium.copyWith(
              fontSize: 16,
              color: UIColors.primaryColor,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          AppImage.asset(
            asset: asset,
            width: 24,
            height: 24,
            color: UIColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
