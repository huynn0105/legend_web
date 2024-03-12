import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/widgets/avatar/chat_avatar.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/checkbox.dart';
import 'package:legend_mfast/models/collaborator/collaborator_new_supporter_model.dart';
import 'package:legend_mfast/services/firebase/firebase_database/firebase_database_util.dart';

class SupporterItem extends StatelessWidget {
  const SupporterItem({
    super.key,
    this.onTap,
    this.onSelect,
    this.isSelected = false,
    required this.item,
  });

  final Function()? onTap;
  final Function()? onSelect;
  final bool isSelected;
  final LegendaryNewSupporterModel item;

  @override
  Widget build(BuildContext context) {
    return AppSplashButton(
      onTap: onTap,
      child: Container(
        height: 70,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: UIColors.background,
            ),
          ),
        ),
        child: Row(
          children: [
            ChatAvatar(
              url: FirebaseDatabaseUtil.convertUrlAvatar(item.avatarImage) ?? "",
              size: 40,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        item.fullName ?? "",
                        style: UITextStyle.regular,
                      ),
                      Container(
                        width: 4,
                        height: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: UIColors.darkGray,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item.title ?? "",
                          style: UITextStyle.regular.copyWith(
                            color: UIColors.darkBlue,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    item.district ?? "",
                    style: UITextStyle.regular.copyWith(
                      fontSize: 13,
                      color: UIColors.grayText,
                    ),
                  ),
                ],
              ),
            ),
            SplashButton(
              onTap: onSelect,
              child: AppOutlineCheckbox(
                value: isSelected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
