import 'dart:convert';

import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/common/enum/collaborator/collaborator_rsm_status.dart';
import 'package:legend_mfast/common/utils/datetime_util.dart';

import '../../../../../common/enum/collaborator/collaborator_rsm_level.dart';
import '../../../../../common/enum/collaborator/collaborator_rsm_top.dart';
import '../../../../../models/collaborator/collaborator_rsm_push_log_model.dart';

class RSMPushLogItem extends StatelessWidget {
  const RSMPushLogItem({super.key, this.item});

  final CollaboratorRsmPushLogModel? item;

  @override
  Widget build(BuildContext context) {
    List<String> objects = getObject();
    List<dynamic> users = jsonDecode(item?.usersArr ?? '');
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: UIColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Đối tượng gửi',
                style: UITextStyle.regular.copyWith(
                  color: UIColors.grayText,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              Text(
                'ID: ${item?.notifyId} - Đã gửi ${users.length} CTV',
                style: UITextStyle.semiBold.copyWith(
                  color: UIColors.grayText,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 20,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Text(
                  objects[index],
                  style: UITextStyle.semiBold.copyWith(
                    fontSize: 13,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 19,
                  height: 19,
                  child: Center(
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: UIColors.grayText,
                      ),
                    ),
                  ),
                );
              },
              itemCount: objects.length,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Nôi dung gửi',
            style: UITextStyle.regular.copyWith(
              color: UIColors.grayText,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item?.content ?? '',
            style: UITextStyle.regular.copyWith(
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          const Divider(
            thickness: 1,
            height: 17,
            color: UIColors.lightGray,
          ),
          Row(
            children: [
              Text(
                'Trạng thái',
                style: UITextStyle.regular.copyWith(
                  color: UIColors.grayText,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                item?.isFinished() == true ? 'Hoàn tất' : 'Đang gửi',
                style: UITextStyle.semiBold.copyWith(
                  color: item?.isFinished() == true ? UIColors.green : UIColors.orange,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              Text(
                'Lúc ${DateTimeUtil.convertDate(
                  item?.processStarted,
                  fromFormat: DateTimeFormat.yyyy_MM_dd_HH_mm_ss,
                  toFormat: DateTimeFormat.HH_mm_dd_MM_yyyy,
                  isFromUtc: false,
                ).replaceAll(' - ', ' ')}',
                style: UITextStyle.regular.copyWith(
                  color: UIColors.grayText,
                  fontSize: 13,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  List<String> getObject() {
    List<String> data = [];
    if (item?.typeRSM != null) {
      data.add(getLevel(item?.typeRSM).unFocusTitle);
    }
    if (item?.statusRSM != null) {
      data.add(getStatus(item?.statusRSM)?.label ?? '');
    }
    if (getTop(item?.topRSM) != null) {
      data.add(getTop(item?.topRSM)?.title ?? '');
    }
    return data;
  }

  CollaboratorRSMLevel getLevel(String? value) {
    switch (value) {
      case "1":
        return CollaboratorRSMLevel.level1;
      case "2":
        return CollaboratorRSMLevel.level2;
      case "3":
        return CollaboratorRSMLevel.level3;
      case "4":
        return CollaboratorRSMLevel.level4;
      case "5":
        return CollaboratorRSMLevel.level5;
      case "6":
        return CollaboratorRSMLevel.level6;
      default:
        return CollaboratorRSMLevel.level7;
    }
  }

  CollaboratorRSMStatus? getStatus(String? value) {
    switch (value) {
      case "ONLINE":
        return CollaboratorRSMStatus.online;
      case "GVM_EXIST":
        return CollaboratorRSMStatus.gvmExist;
      case "PL_GVM_EXIST":
        return CollaboratorRSMStatus.plGvmExist;
      case "INS_GVM_EXIST":
        return CollaboratorRSMStatus.insGvmExist;
      case "DAA_GVM_EXIST":
        return CollaboratorRSMStatus.daaGvmExist;
      default:
        return null;
    }
  }

  CollaboratorRSMTop? getTop(String? value) {
    switch (value) {
      case "10":
        return CollaboratorRSMTop.top10;
      case "20":
        return CollaboratorRSMTop.top20;
      case "50":
        return CollaboratorRSMTop.top50;
      case "100":
        return CollaboratorRSMTop.top100;
      default:
        return null;
    }
  }
}
