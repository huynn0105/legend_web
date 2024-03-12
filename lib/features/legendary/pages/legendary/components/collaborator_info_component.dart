import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/app_data.dart';
import 'package:legend_mfast/common/bottom_sheet/bottom_sheet_provider.dart';
import 'package:legend_mfast/common/global_function.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/components/collaborator_hier_referal_component.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/items/collaborator_info_item.dart';

import '../../../../../models/legendary/hier_user_model.dart';

class CollaboratorInfoComponent extends StatelessWidget {
  const CollaboratorInfoComponent({
    super.key,
    required this.collaboratorID,
    required this.collaboratorPhone,
    required this.level,
    required this.referalUsers,
  });

  final String collaboratorID;
  final String collaboratorPhone;
  final int level;
  final List<HierUserModel> referalUsers;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CollaboratorInfoItem(
          title: 'Tầng $level',
          asset: 'ic_legendary_hier_tree',
          onTap: () {
            BottomSheetProvider.instance.show(
              context,
              title: 'Chi tiết tầng CTV',
              child: CollaboratorHierReferalComponent(
                userID: AppData.instance.userID,
                collaboratorID: collaboratorID,
                data: referalUsers,
              ),
            );
          },
        ),
        // const SizedBox(
        //   width: 24,
        // ),
        // CollaboratorInfoItem(
        //   title: 'Chat',
        //   asset: 'ic_chat_outline',
        //   onTap: () {
        //     GlobalFunction.moveToChatPage(chatUserID: collaboratorID);
        //   },
        // ),
        // const SizedBox(
        //   width: 24,
        // ),
        // CollaboratorInfoItem(
        //   title: 'Gọi',
        //   asset: 'ic_call_outline',
        //   onTap: () {
        //     GlobalFunction.launchPhone(collaboratorPhone);
        //   },
        // ),
      ],
    );
  }
}
