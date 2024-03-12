import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/images.dart';
import 'package:legend_mfast/routes/routes.gr.dart';

import '../../../../../../../common/global_function.dart';

class LegendaryKnowledgeWidget extends StatelessWidget {
  const LegendaryKnowledgeWidget({
    super.key,
    required this.title,
    required this.url,
  });

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return SplashButton(
      isDisabled: url.isEmpty,
      onTap: () {
        GlobalFunction.pushWebView(url: url);
      },
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: UIColors.lightBlue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: UITextStyle.medium.copyWith(
                  fontSize: 14,
                  color: UIColors.primaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (url.isNotEmpty) ...[
              const SizedBox(
                width: 5,
              ),
              const AppImage.asset(
                asset: 'ic_arrow_right',
                width: 24,
                height: 24,
                color: UIColors.primaryColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
