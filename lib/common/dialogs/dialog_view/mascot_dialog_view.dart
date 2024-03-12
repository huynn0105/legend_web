import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/html_widget.dart';
import 'package:legend_mfast/common/widgets/images.dart';

class MascotDialogView extends StatelessWidget {
  const MascotDialogView({
    Key? key,
    required this.asset,
    this.isNetworkAsset = false,
    this.title,
    this.message,
    this.htmlTitle,
    this.htmlMessage,
    this.customContent,
    this.positiveTitle,
    this.negativeTitle,
    this.positiveCallback,
    this.negativeCallback,
    this.titleColor = UIColors.darkBlue,
    this.messageColor = UIColors.defaultText,
    this.showDottedDivider = false,
    this.enableAutoPop = true,
    this.messageAlign = TextAlign.center,
    this.borderRadius = 8,
  }) : super(key: key);

  final String asset;
  final bool isNetworkAsset;
  final String? title;
  final String? message;
  final String? htmlTitle;
  final String? htmlMessage;
  final Widget? customContent;
  final String? positiveTitle;
  final String? negativeTitle;
  final VoidCallback? positiveCallback;
  final VoidCallback? negativeCallback;
  final Color titleColor;
  final Color messageColor;
  final bool enableAutoPop;
  final bool showDottedDivider;
  final TextAlign messageAlign;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final bool showAllButton = negativeTitle?.isNotEmpty == true && positiveTitle?.isNotEmpty == true;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          decoration: BoxDecoration(
            color: UIColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 80,
                width: 140,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -50,
                      left: 0,
                      right: 0,
                      child: isNetworkAsset
                          ? AppImage.network(
                        url: asset,
                        width: 140,
                        height: 140,
                        fit: BoxFit.contain,
                      )
                          : AppImage.asset(
                        asset: asset,
                        width: 140,
                        height: 140,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              if (TextUtils.isNotEmpty(title)) ...[
                const SizedBox(
                  height: 12,
                ),
                Text(
                  title!,
                  style: UITextStyle.semiBold.copyWith(
                    fontSize: 18,
                    color: titleColor,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (TextUtils.isNotEmpty(htmlTitle)) ...[
                const SizedBox(
                  height: 12,
                ),
                HtmlWidget(
                  data: htmlTitle!,
                  fontSize: 18,
                  alignment: Alignment.center,
                ),
              ],
              if (showDottedDivider) ...[
                const SizedBox(
                  height: 12,
                ),
                const DottedLine(
                  dashGapLength: 5,
                  dashLength: 10,
                  dashColor: UIColors.lightGray,
                ),
              ],
              if (TextUtils.isNotEmpty(htmlMessage)) ...[
                HtmlWidget(
                  data: htmlMessage!,
                  fontSize: 16,
                  alignment: Alignment.center,
                ),
              ],
              if (TextUtils.isNotEmpty(message)) ...[
                SizedBox(
                  height: TextUtils.isNotEmpty(message) && showDottedDivider ? 12 : 16,
                ),
                Text(
                  message!,
                  style: UITextStyle.regular.copyWith(
                    color: messageColor,
                  ),
                  textAlign: messageAlign,
                ),
              ],
              if (customContent != null) ...[
                const SizedBox(
                  height: 12,
                ),
                customContent!,
              ],
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (TextUtils.isNotEmpty(negativeTitle))
              Flexible(
                fit: showAllButton ? FlexFit.tight : FlexFit.loose,
                child: AppOutlinedButton(
                  onPressed: () {
                    if (enableAutoPop) {
                      Navigator.of(context).pop();
                    }
                    negativeCallback?.call();
                  },
                  backgroundColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  textColor: UIColors.white,
                  title: negativeTitle!,
                ),
              ),
            if (showAllButton)
              const SizedBox(
                width: 16.5,
              ),
            if (TextUtils.isNotEmpty(positiveTitle))
              Flexible(
                fit: showAllButton ? FlexFit.tight : FlexFit.loose,
                child: PrimaryButton(
                  onPressed: () {
                    if (enableAutoPop) {
                      Navigator.of(context).pop();
                    }
                    positiveCallback?.call();
                  },
                  radius: borderRadius,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  title: positiveTitle!,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
