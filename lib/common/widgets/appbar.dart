import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/common/constants.dart';
import 'package:legend_mfast/common/utils/redirect_util.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/widget_layout.dart';

import '../../app_data.dart';
import '../colors.dart';
import '../styles.dart';
import 'images.dart';

class MFastAdvanceAppBar extends PreferredSize {
  MFastAdvanceAppBar({
    Key? key,
    required BuildContext context,
    required String title,
    VoidCallback? onNotify,
    VoidCallback? onHome,
    VoidCallback? onBack,
    bool autoEnablePop = true,
    bool centerTitle = false,
    List<Widget>? actions,
  }) : super(
    key: key,
    child: WidgetLayout(
      child: AppBar(
        elevation: 0,
        titleSpacing: 0,
        centerTitle: kIsWeb || centerTitle,
        automaticallyImplyLeading: false,
        backgroundColor: UIColors.background,
        leadingWidth: !autoEnablePop ? 16 : 56,
        leading: !autoEnablePop
            ? const SizedBox()
            : AppSplashButton(
          onTap: onBack ?? Navigator.of(context).pop,
          child: const AppImage.asset(
            asset: "ic_arrow_left",
            width: 24,
            height: 24,
            color: UIColors.grayText,
          ),
        ),
        title: Text(
          title,
          style: UITextStyle.semiBold.copyWith(
            fontSize: 18,
          ),
        ),
        actions: [
          ...?actions,
          if (onNotify != null)
            AppSplashButton(
              padding: const EdgeInsets.all(8),
              onTap: onNotify,
              child: const AppImage.asset(
                asset: "ic_notification_outline",
                width: 24,
                height: 24,
                color: UIColors.grayText,
              ),
            ),
          if (!kIsWeb)
            AppSplashButton(
              padding: const EdgeInsets.all(8),
              onTap: onHome,
              child: const AppImage.asset(
                asset: "ic_home",
                width: 20,
                height: 20,
                color: UIColors.grayText,
              ),
            ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
    ),
    preferredSize: const Size.fromHeight(AppConstants.appbarHeight),
  );

  MFastAdvanceAppBar.setting({
    Key? key,
    required BuildContext context,
    required String title,
    Color backgroundColor = UIColors.background,
    VoidCallback? onMore,
    VoidCallback? onSetting,
  }) : super(
    key: key,
    child: WidgetLayout(
      child: AppBar(
        elevation: 0,
        titleSpacing: 0,
        centerTitle: kIsWeb,
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        leading: AppSplashButton(
          onTap: Navigator.of(context).pop,
          child: const AppImage.asset(
            asset: "ic_arrow_left",
            width: 24,
            height: 24,
            color: UIColors.grayText,
          ),
        ),
        title: Text(
          title,
          style: UITextStyle.semiBold.copyWith(
            fontSize: 18,
          ),
        ),
        actions: [
          AppSplashButton(
            onTap: () {
              onMore?.call();
            },
            child: const AppImage.asset(
              asset: "ic_more_horizontal_outline",
              width: 24,
              height: 24,
              color: UIColors.grayText,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: AppSplashButton(
              onTap: () {
                onSetting?.call();
              },
              child: const AppImage.asset(
                asset: "ic_setting_outline",
                width: 24,
                height: 24,
                color: UIColors.grayText,
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    ),
    preferredSize: const Size.fromHeight(AppConstants.appbarHeight),
  );
}

class MFastSimpleAppBar extends PreferredSize {
  MFastSimpleAppBar({
    Key? key,
    required String title,
    required BuildContext context,
    VoidCallback? onBack,
    VoidCallback? onHome,
    List<Widget>? actions,
    bool centerTitle = true,
    Color backgroundColor = UIColors.background,
    Color? titleColor,
  }) : super(
    key: key,
    child: WidgetLayout(
      child: AppBar(
        elevation: 0,
        titleSpacing: 0,
        centerTitle: centerTitle,
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        leading: AppSplashButton(
          onTap: onBack ?? Navigator.of(context).pop,
          child: const AppImage.asset(
            asset: "ic_arrow_left",
            width: 24,
            height: 24,
            color: UIColors.grayText,
          ),
        ),
        title: Text(
          title,
          style: UITextStyle.semiBold.copyWith(
            fontSize: 18,
            color: titleColor,
          ),
        ),
        actions: [
          ...?actions,
          if (kIsWeb && onHome != null)
            Padding(
              padding: const EdgeInsets.all(10),
              child: SplashButton(
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: onHome,
                child: const AppImage.asset(
                  asset: "ic_mfast_logo",
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
    ),
    preferredSize: const Size.fromHeight(AppConstants.appbarHeight),
  );
}

class MFastGradientAppBar extends PreferredSize {
  MFastGradientAppBar({
    Key? key,
    required BuildContext context,
    required String title,
    VoidCallback? onBack,
    VoidCallback? onHome,
    List<Widget>? actions,
    bool centerTitle = true,
    Color backgroundColor = UIColors.background,
    Color titleColor = UIColors.white,
    bool showBackButton = true,
    bool showHomeButton = false,
  }) : super(
    key: key,
    child: WidgetLayout(
      child: AppBar(
        elevation: 0,
        titleSpacing: 0,
        centerTitle: centerTitle,
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        flexibleSpace: const AppImage.asset(
          asset: 'ic_app_bar_gradient_background',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        leading: !kIsWeb && showBackButton
            ? AppSplashButton(
          onTap: onBack ?? Navigator.of(context).pop,
          child: const AppImage.asset(
            asset: "ic_back_arrow_circle",
            width: 32,
            height: 32,
          ),
        )
            : null,
        title: Text(
          title,
          style: UITextStyle.semiBold.copyWith(
            fontSize: 18,
            color: titleColor,
          ),
        ),
        actions: [
          ...?actions,
          Visibility(
            visible: showHomeButton,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SplashButton(
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  onHome?.call();
                },
                child: const AppImage.asset(
                  asset: "ic_home_fill",
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
    ),
    preferredSize: const Size.fromHeight(56),
  );
}
