import 'package:flutter/material.dart';
import 'package:legend_mfast/common/size.dart';
import 'package:info_popup/info_popup.dart';

import '../../../../../common/colors.dart';
import '../../../../../common/styles.dart';
import '../../../../../common/widgets/images.dart';


class CollaboratorInfoPopup extends StatelessWidget {
  const CollaboratorInfoPopup({
    super.key,
    required this.infoPopupContents,
    required this.child,
  });
  final Widget child;
  final List<InfoPopupContent> infoPopupContents;

  @override
  Widget build(BuildContext context) {
    return InfoPopupWidget(
      enableHighlight: true,
      dismissTriggerBehavior: PopupDismissTriggerBehavior.anyWhere,
      contentMaxWidth: AppSize.instance.width - 32,
      arrowTheme: const InfoPopupArrowTheme(
        color: Colors.white,
        arrowDirection: ArrowDirection.down,
      ),
      highLightTheme: HighLightTheme(
        backgroundColor: UIColors.blurBackground,
        padding: const EdgeInsets.all(2),
        radius: BorderRadius.circular(4),
      ),
      indicatorOffset: const Offset(0, 0),
      contentOffset: const Offset(16, 0),
      customContent: () => Container(
        decoration: BoxDecoration(
          color: UIColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _ItemInfoPopup(
              icon: infoPopupContents[index].icon,
              value: infoPopupContents[index].value,
              description: infoPopupContents[index].description,
            );
          },
          separatorBuilder: (context, index) => const Divider(
            height: 24,
            thickness: 1,
            color: UIColors.lightGray,
          ),
          itemCount: infoPopupContents.length,
        ),
      ),
      child: child,
    );
  }
}

class _ItemInfoPopup extends StatelessWidget {
  const _ItemInfoPopup({
    super.key,
    required this.value,
    required this.description,
    required this.icon,
  });

  final String value;
  final String description;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppImage.asset(
          asset: icon,
          width: 28,
          height: 28,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: UITextStyle.bold.copyWith(
                    fontSize: 16,
                    color: UIColors.orange,
                  ),
                ),
                TextSpan(
                  text: ' $description',
                  style: UITextStyle.medium.copyWith(
                    fontSize: 16,
                    color: UIColors.grayText,
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

class InfoPopupContent {
  final String icon;
  final String description;
  final String value;

  InfoPopupContent({
    required this.icon,
    required this.description,
    required this.value,
  });
}

