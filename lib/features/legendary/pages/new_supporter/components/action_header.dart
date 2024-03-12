import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

import '../../../../../common/colors.dart';
import '../../../../../common/size.dart';
import '../../../../../common/styles.dart';
import '../../../../../common/widgets/buttons.dart';
import '../../../../../common/widgets/images.dart';

class ActionHeader extends StatelessWidget {
  const ActionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return AppSplashButton(
          onTap: () {
            showPopover(
              context: context,
              width: AppSize.instance.width * 0.75,
              arrowWidth: 10,
              arrowHeight: 10,
              bodyBuilder: (BuildContext context) {
                return Container(
                  color: Colors.white,
                  margin: const EdgeInsets.all(12),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Người dẫn dắt",
                          style: UITextStyle.bold.copyWith(
                            color: UIColors.darkBlue,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text:
                              " là người đã mời bạn tham gia MFast, cũng là người giải đáp những thắc mắc của bạn trong quá trình tạo ra thu nhập trên MFast\n\nNgoài ra, bạn cũng có thể",
                          style: UITextStyle.regular.copyWith(
                            color: UIColors.grayText,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: " thay đổi ",
                          style: UITextStyle.bold.copyWith(
                            color: UIColors.darkBlue,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: "hoặc",
                          style: UITextStyle.regular.copyWith(
                            color: UIColors.grayText,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: " tìm người dẫn dắt mới ",
                          style: UITextStyle.bold.copyWith(
                            color: UIColors.darkBlue,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: "nếu muốn",
                          style: UITextStyle.regular.copyWith(
                            color: UIColors.grayText,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            child: const AppImage.asset(
              asset: "ic_info_outline",
              width: 20,
              height: 20,
            ),
          ),
        );
      },
    );
  }
}
