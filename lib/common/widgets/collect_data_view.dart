import 'dart:math';

import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/size.dart';
import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/common/widgets/images.dart';

import '../constants.dart';
import '../styles.dart';

class CollectDataView extends StatelessWidget {
  const CollectDataView({
    Key? key,
    required this.child,
    this.errorMsg,
    this.description,
    this.errorAlignment,
    this.spacing = 8,
    this.visibleReplacement,
  }) : super(key: key);
  final Widget child;
  final String? errorMsg;
  final Widget? description;
  final double spacing;
  final MainAxisAlignment? errorAlignment;
  final SizedBox? visibleReplacement;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
        if (description != null)
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 8),
            child: description!,
          ),
        AnimatedSize(
          duration: const Duration(milliseconds: 800),
          alignment: Alignment.topCenter,
          curve: Curves.linearToEaseOut,
          child: SizedBox(
            width: double.infinity,
            child: Visibility(
              visible: TextUtils.isNotEmpty(errorMsg),
              replacement: visibleReplacement ?? const SizedBox.shrink(),
              child: Container(
                constraints: BoxConstraints(
                  minHeight: visibleReplacement?.height ?? 0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: spacing,
                    ),
                    ErrorText(
                      errorMsg: errorMsg,
                      errorAlignment: errorAlignment,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ErrorText extends StatelessWidget {
  const ErrorText({
    Key? key,
    this.errorMsg,
    this.errorAlignment,
  }) : super(key: key);
  final String? errorMsg;
  final MainAxisAlignment? errorAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: errorAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 1),
          child: AppImage.asset(
            asset: "ic_warning_outline",
            width: 18,
            height: 18,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        if (errorAlignment == MainAxisAlignment.center)
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                minWidth: 0,
                maxWidth: min(AppConstants.responsiveSize, AppSize.instance.width) - 80,
              ),
              child: Text(
                errorMsg ?? '',
                style: UITextStyle.regular.copyWith(
                  fontSize: 14,
                  color: UIColors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        if (errorAlignment != MainAxisAlignment.center)
          Expanded(
            child: Text(
              errorMsg ?? '',
              style: UITextStyle.regular.copyWith(
                fontSize: 14,
                color: UIColors.red,
              ),
            ),
          ),
      ],
    );
  }
}
