import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/dialogs/dialog_view/confirm_dialog.dart';
import 'package:legend_mfast/common/dialogs/dialog_view/mascot_dialog_view.dart';
import 'package:legend_mfast/common/utils/text_util.dart';

import '../widgets/widget_layout.dart';
import 'dialog_view/error_msg_dialog.dart';

class DialogProvider {
  DialogProvider._();

  static final DialogProvider instance = DialogProvider._();
  bool expiredTokenIsShowing = false;

  Widget _mainDialog({
    Widget? child,
    Color? backgroundColor,
    EdgeInsets insetPadding = const EdgeInsets.all(16),
  }) {
    return Dialog(
      elevation: 0,
      insetPadding: insetPadding,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  showConfirmDialog(
      BuildContext context, {
        required String message,
        String? title,
        String positiveTitle = 'OK',
        String? negativeTitle,
        Function()? positiveCallback,
        Function()? negativeCallback,
        bool barrierDismissible = true,
      }) {
    if (expiredTokenIsShowing || TextUtils.isEmpty(message)) return;
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return barrierDismissible;
          },
          child: _mainDialog(
            child: WidgetLayout(
              child: ConfirmDialog(
                message: message,
                title: title,
                positiveTitle: positiveTitle,
                positiveCallback: positiveCallback,
                negativeTitle: negativeTitle,
                negativeCallback: negativeCallback,
              ),
            ),
          ),
        );
      },
    );
  }

  showErrorMsgDialog({
    required BuildContext context,
    String? message,
    String? title,
    required String btnTitle,
    Function()? callback,
    bool barrierDismissible = true,
  }) {
    if (TextUtils.isEmpty(title) && TextUtils.isEmpty(message)) return;
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return barrierDismissible;
          },
          child: WidgetLayout(
            child: _mainDialog(
              child: ErrorMsgDialog(
                title: title,
                message: message,
                btnTitle: btnTitle,
                callback: callback,
              ),
            ),
          ),
        );
      },
    );
  }

  show({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = false,
    EdgeInsets insetPadding = const EdgeInsets.all(16),
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: UIColors.blurBackground,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return barrierDismissible;
          },
          child: WidgetLayout(
            child: _mainDialog(
              backgroundColor: Colors.transparent,
              child: child,
              insetPadding: insetPadding,
            ),
          ),
        );
      },
    );
  }

  showBuilder({
    required BuildContext context,
    required WidgetBuilder builder,
    bool barrierDismissible = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: UIColors.blurBackground,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return barrierDismissible;
          },
          child: WidgetLayout(
            child: _mainDialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              child: builder(context),
            ),
          ),
        );
      },
    );
  }

  showMascotDialog({
    required BuildContext context,
    required String asset,
    bool isNetworkAsset = false,
    Widget? customContent,
    String? title,
    String? message,
    String? htmlTitle,
    String? htmlMessage,
    String? positiveTitle,
    String? negativeTitle,
    VoidCallback? positiveCallback,
    VoidCallback? negativeCallback,
    Color titleColor = UIColors.darkBlue,
    Color messageColor = UIColors.grayText,
    bool showDottedDivider = true,
    bool barrierDismissible = true,
    bool enableAutoPop = true,
    TextAlign messageAlign = TextAlign.center,
    double borderRadius = 8,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: UIColors.blurBackground,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return barrierDismissible;
          },
          child: _mainDialog(
            backgroundColor: Colors.transparent,
            child: WidgetLayout(
              child: MascotDialogView(
                asset: asset,
                isNetworkAsset: isNetworkAsset,
                title: title,
                message: message,
                htmlTitle: htmlTitle,
                htmlMessage: htmlMessage,
                titleColor: titleColor,
                messageColor: messageColor,
                positiveTitle: positiveTitle,
                negativeTitle: negativeTitle,
                positiveCallback: positiveCallback,
                negativeCallback: negativeCallback,
                enableAutoPop: enableAutoPop,
                showDottedDivider: showDottedDivider,
                messageAlign: messageAlign,
                customContent: customContent,
                borderRadius: borderRadius,
              ),
            ),
          ),
        );
      },
    );
  }

  showMascotErrorDialog({
    required BuildContext context,
    String? title = "Thất bại",
    String? message,
    String? positiveTitle = "Đã hiểu và quay lại",
    VoidCallback? positiveCallback,
    TextAlign messageAlign = TextAlign.center,
    bool barrierDismissible = true,
    bool enableAutoPop = true,
    bool showDottedDivider = true,
  }) {
    showMascotDialog(
      context: context,
      asset: "ic_mtrade_mascot_error",
      title: title,
      message: message,
      titleColor: UIColors.red,
      messageColor: UIColors.defaultText,
      positiveTitle: positiveTitle,
      positiveCallback: positiveCallback,
      messageAlign: messageAlign,
      barrierDismissible: barrierDismissible,
      enableAutoPop: enableAutoPop,
      showDottedDivider: showDottedDivider,
    );
  }

}