import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/format_util.dart';
import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:legend_mfast/common/widgets/avatar/chat_avatar.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';

import '../../../../../common/widgets/avatar_widget.dart';
import '../../../../../common/widgets/images.dart';
import '../../../../../models/collaborator/collaborator_model.dart';
import '../../../../../routes/routes.gr.dart';

class CollaboratorItem extends StatelessWidget {
  const CollaboratorItem({
    Key? key,
    this.collaborator,
  }) : super(key: key);

  final CollaboratorModel? collaborator;

  @override
  Widget build(BuildContext context) {
    return AppSplashButton(
      onTap: () {
        context.pushRoute(LegendaryHierCollaboratorRoute(userID: collaborator?.userID ?? ''));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 8, top: 10, bottom: 12),
        decoration: BoxDecoration(
          color: UIColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Column(
              children: [
                AvatarWidget(
                  url: collaborator?.rankImage ?? '',
                  size: 36,
                ),
                Row(
                  children: List.generate(
                      _getStar(), (index) => const AppImage.asset(asset: 'ic_star', width: 12, height: 12)),
                )
              ],
            ),
            const SizedBox(
              width: 8,
            ),
            ChatAvatar(
              url: collaborator?.avatarImage ?? '',
              name: collaborator?.fullName ?? '',
              size: 48,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          collaborator?.fullName ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: UITextStyle.regular.copyWith(
                            color: UIColors.lightBlack,
                          ),
                        ),
                      ),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: UIColors.darkGray,
                        ),
                        margin: const EdgeInsets.only(left: 6, right: 6, top: 2),
                      ),
                      Text(
                        'Tầng ${collaborator?.refLevel}',
                        style: UITextStyle.regular.copyWith(
                          color: UIColors.grayText,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    collaborator?.isPoint == true
                        ? FormatUtil.pointFormat(collaborator?.totalAmount)
                        : FormatUtil.currencyFormat(collaborator?.totalAmount?.toInt()),
                    style: UITextStyle.semiBold.copyWith(
                      color: UIColors.extraGreen,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            // AppSplashButton(
            //   onTap: () {
            //     GlobalFunction.moveToChatPage(chatUserID: collaborator?.userID);
            //   },
            //   child: const AppImage.asset(
            //     asset: "ic_message",
            //     width: 24,
            //     height: 24,
            //     color: UIColors.grayText,
            //   ),
            // ),
            // const SizedBox(
            //   width: 12,
            // ),
            // const AppImage.asset(
            //   asset: "ic_call_outline",
            //   width: 24,
            //   height: 24,
            //   color: UIColors.grayText,
            // ),
          ],
        ),
      ),
    );
  }

  int _getStar() {
    if (collaborator?.level != null) {
      final titleSplit = collaborator!.level!.split(' ');
      if (titleSplit.isEmpty) return 0;

      final maxIndex = titleSplit.length - 1;
      final star = titleSplit[maxIndex];
      return TextUtils.parseInt(star) ?? 0;
    }
    return 0;
  }
}
