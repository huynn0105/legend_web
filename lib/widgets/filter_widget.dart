import 'package:flutter/material.dart';
import '../common/colors.dart';
import '../common/styles.dart';
import '../common/widgets/images.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    Key? key,
    this.hint,
    required this.value,
    required this.icon,
    this.borderColor,
    this.suffixIcon,
  }) : super(key: key);
  final String? hint;
  final String? value;
  final String icon;
  final Color? borderColor;
  final String? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 10, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: UIColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor ?? UIColors.lightGray, width: 1),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: AppImage.asset(
              asset: icon,
              width: 20,
              height: 20,
              color: UIColors.grayText,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              value ?? hint ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: value != null ? UITextStyle.semiBold.copyWith(
                color: UIColors.lightBlack,
              ) : UITextStyle.regular.copyWith(
                color: UIColors.grayText,
              ),
            ),
          ),
          if (suffixIcon != null)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: AppImage.asset(
                asset: suffixIcon,
                width: 24,
                height: 24,
                color: UIColors.grayText,
              ),
            ),
        ],
      )
    );
  }
}
