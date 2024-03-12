import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';

import '../../colors.dart';
import '../../constants.dart';
import '../../size.dart';
import '../../styles.dart';
import '../../widgets/images.dart';

class BottomSheetView extends StatelessWidget {
  const BottomSheetView({
    Key? key,
    required this.title,
    required this.child,
    this.closeOnRight = true,
    this.isDismissible = true,
    this.enabledOnDone = false,
    this.headerColor,
    this.backgroundColor,
    this.enabledSafeBottom = true,
    this.onDone,
  }) : super(key: key);

  final String title;
  final Widget child;
  final bool closeOnRight;
  final bool isDismissible;
  final bool enabledOnDone;
  final Color? headerColor;
  final Color? backgroundColor;
  final bool enabledSafeBottom;
  final Function()? onDone;

  @override
  Widget build(BuildContext context) {
    Widget closeWidget = SplashButton(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: const Icon(
        Icons.clear_rounded,
        color: UIColors.grayText,
        size: 24,
      ),
    );
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isDismissible)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    transform: Matrix4.translationValues(0, 2, 0),
                    child: ConvexButton(
                      top: 23,
                      size: 65,
                      sigma: 0,
                      thickness: 0,
                      backgroundColor: UIColors.white,
                      child: Container(
                        transform: Matrix4.translationValues(0, 5, 0),
                        child: const AppImage.asset(
                          asset: "ic_arrow_down",
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                width: constraints.maxWidth >= AppConstants.responsiveSize ? AppConstants.responsiveSize : null,
                decoration: BoxDecoration(
                  color: headerColor ?? UIColors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      height: 24,
                      child: closeOnRight ? null : closeWidget,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          title,
                          style: UITextStyle.semiBold.copyWith(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    if (onDone != null)
                      IgnorePointer(
                        ignoring: !enabledOnDone,
                        child: SplashButton(
                          onTap: onDone,
                          child: Container(
                            width: 40,
                            height: 24,
                            alignment: Alignment.center,
                            child: Text(
                              "Xong",
                              style: UITextStyle.bold.copyWith(
                                fontSize: 14,
                                color: enabledOnDone ? UIColors.primaryColor : UIColors.gray,
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      Container(
                        width: 40,
                        height: 24,
                        alignment: Alignment.centerRight,
                        child: closeOnRight ? closeWidget : null,
                      ),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  padding: kIsWeb
                      ? null
                      : EdgeInsets.only(
                    bottom: AppSize.instance.keyboardHeight,
                  ),
                  decoration: BoxDecoration(
                    color: backgroundColor ?? UIColors.background,
                  ),
                  width: constraints.maxWidth >= AppConstants.responsiveSize ? AppConstants.responsiveSize : null,
                  child: child,
                ),
              ),
              Visibility(
                visible: enabledSafeBottom,
                child: Container(
                  height: AppSize.instance.safeBottom,
                  color: backgroundColor ?? UIColors.background,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}