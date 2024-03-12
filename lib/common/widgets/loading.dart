import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../env_config.dart';
import '../colors.dart';
import '../styles.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    this.backgroundColor = Colors.transparent,
  })  : isDark = false,
        showText = false,
        super(key: key);

  const LoadingWidget.dark({
    Key? key,
    this.backgroundColor = UIColors.blurBackground,
  })  : isDark = true,
        showText = true,
        super(key: key);

  const LoadingWidget.withoutText({
    Key? key,
    this.backgroundColor = Colors.transparent,
  })  : isDark = false,
        showText = false,
        super(key: key);

  final bool isDark;
  final bool showText;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (kIsWeb)
                  Image.asset(
                    'assets/jsons/loading_animation.gif',
                    width: 56,
                    height: 56,
                    package: EnvConfig.instance.package,
                  ),
                if (showText)
                  const SizedBox(
                    height: 16,
                  ),
                if (showText)
                  Text(
                    'Hệ thống đang xử lý,\nvui lòng không thoát lúc này',
                    textAlign: TextAlign.center,
                    style: UITextStyle.regular.copyWith(
                      fontSize: 16,
                      color: isDark ? UIColors.white : UIColors.defaultText,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
