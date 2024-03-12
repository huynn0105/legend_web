import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../styles.dart';
import '../../widgets/buttons.dart';
import '../../widgets/images.dart';

class ErrorMsgDialog extends StatelessWidget {
  const ErrorMsgDialog({
    Key? key,
    this.title,
    this.message,
    required this.btnTitle,
    this.callback,
  }) : super(key: key);

  final String? title;
  final String? message;
  final String btnTitle;
  final Function? callback;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 343,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
              child: Column(
                children: [
                  const AppImage.asset(
                    asset: "ic_popup_error_icon",
                    width: 56,
                    height: 56,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (title != null)
                    Text(
                      title!,
                      textAlign: TextAlign.center,
                      style: UITextStyle.semiBold.copyWith(
                        fontSize: 16,
                        color: UIColors.red,
                      ),
                    ),
                  if (title != null && message != null)
                    const SizedBox(
                      height: 12,
                    ),
                  if (message != null)
                    Text(
                      message!,
                      textAlign: TextAlign.center,
                      style: UITextStyle.regular.copyWith(
                        fontSize: 14,
                        color: UIColors.grayText,
                      ),
                    ),
                ],
              ),
            ),
            const Divider(
              height: 1,
            ),
            SplashButton(
              onTap: () {
                callback?.call();
                Navigator.of(context).pop();
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 17, top: 13),
                color: UIColors.lightBlue,
                child: Text(
                  btnTitle,
                  style: UITextStyle.semiBold.copyWith(
                    color: UIColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
