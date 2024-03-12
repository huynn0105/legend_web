import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/global_function.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/count_down_util.dart';
import 'package:legend_mfast/common/utils/datetime_util.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/images.dart';
import 'package:legend_mfast/models/collaborator/collaborator_care_list_model.dart';

import '../../../../../common/widgets/avatar/chat_avatar.dart';

class CollaboratorDepartItem extends StatelessWidget {
  const CollaboratorDepartItem({
    super.key,
    this.item,
    this.onTap,
  });

  final CollaboratorCareModel? item;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AppSplashButton(
      onTap: onTap,
      child: Row(
        children: [
          ChatAvatar(
            url: item?.avatar ?? '',
            name: item?.fullName ?? '',
            size: 48,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              item?.fullName ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: UITextStyle.regular,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: item?.requestDelete == true ? 'Đã hủy tài khoản ' : 'Đã rời đi ',
                      style: UITextStyle.regular.copyWith(
                        fontSize: 13,
                        color: UIColors.red,
                      ),
                    ),
                    TextSpan(
                      text: ' - ${CountDownUtil.formatDateAgo(DateTimeUtil.getRemainSeconds(
                        item?.requestDeleteDate,
                        format: DateTimeFormat.yyyy_MM_dd_HH_mm_ss,
                        isFromUtc: false,
                      ))} trước',
                      style: UITextStyle.regular.copyWith(
                        fontSize: 13,
                        color: UIColors.grayText,
                      ),
                    ),
                  ]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Row(
          //   children: [
          //     SplashButton(
          //       onTap: () {
          //         GlobalFunction.moveToChatPage(chatUserID: item?.userID);
          //       },
          //       child: const AppImage.asset(
          //         asset: 'ic_chat_outline',
          //         width: 20,
          //         height: 20,
          //         color: UIColors.primaryColor,
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 20,
          //     ),
          //     SplashButton(
          //       onTap: () {
          //         GlobalFunction.launchPhone(item?.phone ?? '');
          //       },
          //       child: const AppImage.asset(
          //         asset: 'ic_call_outline',
          //         width: 20,
          //         height: 20,
          //         color: UIColors.primaryColor,
          //       ),
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}
