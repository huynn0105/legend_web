import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/custom_rounded_rectangle_border.dart';
import 'package:legend_mfast/common/widgets/images.dart';
import '../../../../../models/legendary/hier_user_model.dart';
import 'package:legend_mfast/services/firebase/firebase_database/firebase_database_util.dart';

import '../../../../../routes/routes.gr.dart';

class CollaboratorHierReferalComponent extends StatelessWidget {
  const CollaboratorHierReferalComponent({
    super.key,
    required this.data,
    required this.userID,
    required this.collaboratorID,
  });

  final List<HierUserModel> data;
  final String? userID;
  final String? collaboratorID;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          data.length,
          (index) {
            final item = data[index];
            final isFirst = index == 0;
            final isLast = index == data.length - 1;
            final isMe = item.userID == userID;
            final isCurrentCollaborator = item.userID == collaboratorID;
            final isHighlight = isMe || isCurrentCollaborator;

            ///
            return Container(
              height: 52,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                left: 15 * (index + 1),
                top: isFirst ? 0 : 20,
              ),
              decoration: BoxDecoration(
                color: isHighlight ? UIColors.lightBlue : UIColors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(26),
                  bottomLeft: Radius.circular(26),
                ),
              ),
              child: SplashButton(
                isDisabled: isHighlight,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(26),
                  bottomLeft: Radius.circular(26),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  context.pushRoute(LegendaryHierCollaboratorRoute(userID: item.userID));
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    if (!isLast)
                      Positioned(
                        top: 25,
                        child: Container(
                          width: 22,
                          height: 72,
                          decoration: const ShapeDecoration(
                            shape: CustomRoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                              leftSide: BorderSide(
                                width: 1.5,
                                color: UIColors.darkBlue,
                              ),
                              bottomLeftCornerSide: BorderSide(
                                width: 1.5,
                                color: UIColors.darkBlue,
                              ),
                              bottomSide: BorderSide(
                                width: 1.5,
                                color: UIColors.darkBlue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      top: 0,
                      left: -1.5,
                      right: 0,
                      bottom: 0,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(3.5, 2, 2, 2),
                            child: AppImage.network(
                              url: FirebaseDatabaseUtil.convertUrlAvatar(item.avatarImage),
                              width: 50,
                              height: 50,
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.fullName ?? '',
                                  style: UITextStyle.medium.copyWith(
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: item.title ?? '',
                                        style: UITextStyle.semiBold.copyWith(
                                          fontSize: 13,
                                          color: UIColors.darkBlue,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' • ',
                                        style: UITextStyle.semiBold.copyWith(
                                          fontSize: 13,
                                          color: UIColors.darkBlue,
                                        ),
                                      ),
                                      TextSpan(
                                        text: isMe ? 'Bạn' : 'Tầng ${item.refLevel ?? 0}',
                                        style: UITextStyle.regular.copyWith(
                                          fontSize: 13,
                                          color: UIColors.grayText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          if (!isHighlight) ...[
                            const AppImage.asset(
                              asset: 'ic_arrow_right',
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
