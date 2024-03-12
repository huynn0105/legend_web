import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/enum/collaborator/collaborator_status.dart';
import 'package:legend_mfast/common/global_function.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/count_down_util.dart';
import 'package:legend_mfast/common/utils/datetime_util.dart';
import 'package:legend_mfast/common/widgets/avatar/chat_avatar.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/images.dart';
import 'package:legend_mfast/features/legendary/pages/collaborator_need_to_care/components/collaborator_info_popup.dart';
import 'package:legend_mfast/models/collaborator/collaborator_care_list_model.dart';

import '../../../../../common/widgets/checkbox.dart';

class CollaboratorWorkingItem extends StatelessWidget {
  const CollaboratorWorkingItem({
    super.key,
    this.item,
    this.showRemoveCheckBox = false,
    this.checked = false,
    this.selectedAll = false,
    this.onTapCheck,
    this.onTap,
    this.type,
  });

  final CollaboratorCareModel? item;
  final bool showRemoveCheckBox;
  final bool checked;
  final bool selectedAll;
  final Function(bool)? onTapCheck;
  final Function()? onTap;
  final String? type;

  @override
  Widget build(BuildContext context) {
    final isRequestDelete = item?.requestDelete == true;
    final notWork = '${item?.info?.notWork ?? 0}';
    final notIncome = '${item?.info?.notIncome ?? 0}';
    final notLogin = '${item?.info?.notOpenApp ?? 0}';
    final countApp = '${item?.info?.countApp ?? 0}';
    return AppSplashButton(
      onTap: onTap,
      child: SizedBox(
        height: isRequestDelete ? 72 : 48,
        child: Row(
          children: [
            if (showRemoveCheckBox)
              AppCheckbox.rectangle(
                value: checked || selectedAll,
                customBackgroundColor: selectedAll ? UIColors.lightGray : null,
                onChanged: onTapCheck,
              ),
            const SizedBox(width: 12),
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
                            const SizedBox(
                              width: 4,
                            ),
                            const AppImage.asset(
                              asset: "ic_arrow_right",
                              width: 16,
                              height: 16,
                            )
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
                  const SizedBox(height: 4),
                  type == CollaboratorStatus.working.name
                      ? _InfoWorkingItem(countApp: countApp)
                      : _InfoItem(
                          notIncome: notIncome,
                          notLogin: notLogin,
                          notWork: notWork,
                        ),
                  if (isRequestDelete) ...[
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        const AppImage.asset(
                          asset: "ic_trash_outline",
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            "Hủy tài khoản sau ${CountDownUtil.formatDay(DateTimeUtil.getRemainSeconds(
                              item?.requestDeleteDate,
                              format: DateTimeFormat.yyyy_MM_dd_HH_mm_ss,
                              isFromUtc: false,
                            ))}",
                            style: UITextStyle.semiBold.copyWith(
                              fontSize: 13,
                              color: UIColors.red,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoWorkingItem extends StatelessWidget {
  const _InfoWorkingItem({
    super.key,
    required this.countApp,
  });

  final String countApp;

  @override
  Widget build(BuildContext context) {
    List<InfoPopupContent> listInfoPopup = [
      InfoPopupContent(
        icon: 'ic_activity',
        value: countApp,
        description: 'hồ sơ khách hàng được CTV này khởi tạo trên MFast',
      ),
    ];
    return CollaboratorInfoPopup(
      infoPopupContents: listInfoPopup,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppImage.asset(
            asset: "ic_activity",
            width: 20,
            height: 20,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            countApp,
            style: UITextStyle.semiBold.copyWith(
              fontSize: 13,
              color: UIColors.violet,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    super.key,
    required this.notIncome,
    required this.notLogin,
    required this.notWork,
  });
  final String notWork;
  final String notIncome;
  final String notLogin;

  @override
  Widget build(BuildContext context) {
    List<InfoPopupContent> listInfoPopup = [
      InfoPopupContent(
        icon: 'ic_no_working',
        value: notWork,
        description: 'ngày không làm việc',
      ),
      InfoPopupContent(
        icon: 'ic_no_income',
        value: notIncome,
        description: 'ngày không phát sinh thu nhập',
      ),
      InfoPopupContent(
        icon: 'ic_no_login',
        value: notLogin,
        description: 'ngày không mở ứng dụng MFast',
      ),
    ];

    return CollaboratorInfoPopup(
      infoPopupContents: listInfoPopup,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppImage.asset(
            asset: "ic_no_working",
            width: 20,
            height: 20,
          ),
          const SizedBox(
            width: 4,
          ),
          Flexible(
            child: Text(
              notWork,
              style: UITextStyle.semiBold.copyWith(
                fontSize: 13,
                color: UIColors.orange,
              ),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          const AppImage.asset(
            asset: "ic_no_income",
            width: 20,
            height: 20,
          ),
          const SizedBox(
            width: 4,
          ),
          Flexible(
            child: Text(
              notIncome,
              style: UITextStyle.semiBold.copyWith(
                fontSize: 13,
                color: UIColors.green,
              ),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          const AppImage.asset(
            asset: "ic_no_login",
            width: 20,
            height: 20,
          ),
          const SizedBox(
            width: 4,
          ),
          Flexible(
            child: Text(
              notLogin,
              style: UITextStyle.semiBold.copyWith(
                fontSize: 13,
                color: UIColors.deepBlue,
              ),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
        ],
      ),
    );
  }
}

