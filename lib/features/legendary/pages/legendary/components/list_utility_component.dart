import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/app_data.dart';
import 'package:legend_mfast/common/constants.dart';
import 'package:legend_mfast/common/global_function.dart';
import 'package:legend_mfast/common/widgets/images.dart';

import '../../../../../common/colors.dart';
import '../../../../../common/enum/collaborator/collaborator_status.dart';
import '../../../../../common/styles.dart';
import '../../../../../common/widgets/buttons.dart';
import '../../../../../models/collaborator/collaborator_status_model.dart';
import '../../../../../models/general_object.dart';
import '../../../../../routes/routes.gr.dart';
import '../../../../../widgets/data_widget.dart';

class ListUtilityComponent extends StatelessWidget {
  const ListUtilityComponent({
    Key? key,
    required this.referralCode,
    required this.collaboratorStatus,
    this.useRsmPush,
    this.onGoReferralComponent,
  }) : super(key: key);

  final String? referralCode;
  final CollaboratorStatusModel? collaboratorStatus;
  final bool? useRsmPush;
  final Function()? onGoReferralComponent;

  @override
  Widget build(BuildContext context) {
    List<GeneralObject> list = _sort(collaboratorStatus?.data ?? []);
    List<List<GeneralObject>> data = list.slices(3).toList();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SplashButton(
          onTap: () {
            Navigator.pop(context);
            GlobalFunction.pushWebView(url: AppData.instance.appInfo.urlInfoNewModel);
          },
          child: Container(
            padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12, right: 12),
            decoration: const BoxDecoration(
              color: UIColors.darkBlue,
            ),
            child: Row(
              children: [
                const AppImage.asset(asset: 'ic_energy', width: 32, height: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Tìm hiểu về con đường Huyền Thoại',
                    style: UITextStyle.medium.copyWith(
                      fontSize: 16,
                      color: UIColors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const AppImage.asset(
                  asset: 'ic_arrow_right',
                  width: 20,
                  height: 20,
                  color: UIColors.white,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        SplashButton(
          onTap: () {
            Navigator.pop(context);
            context.router.push(CollaboratorNeedToCareRoute(collaboratorStatus: CollaboratorStatus.working));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    const AppImage.asset(asset: 'ic_take_care_user', width: 40, height: 40),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Cộng tác viên cần chăm sóc',
                        style: UITextStyle.medium.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const AppImage.asset(asset: 'ic_arrow_right', width: 20, height: 20),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: UIColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 12);
                    },
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: DataWidget(
                              title: _getItemTitle(data[index][0].code ?? ''),
                              value: '${data[index][0].value ?? 0}',
                              textColor: _getItemValueColor(data[index][0].code ?? ''),
                            ),
                          ),
                          Expanded(
                            child: data[index].length > 1
                                ? DataWidget(
                                    title: _getItemTitle(data[index][1].code ?? ''),
                                    value: '${data[index][1].value ?? 0}',
                                    textColor: _getItemValueColor(data[index][1].code ?? ''),
                                  )
                                : const SizedBox(),
                          ),
                          Expanded(
                            child: data[index].length > 2
                                ? DataWidget(
                                    title: _getItemTitle(data[index][2].code ?? ''),
                                    value: '${data[index][2].value ?? 0}',
                                    textColor: _getItemValueColor(data[index][2].code ?? ''),
                                  )
                                : const SizedBox(),
                          ),
                        ],
                      );
                    },
                    itemCount: data.length,
                  ),
                )
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(height: 33, thickness: 1, color: UIColors.lightGray),
        ),
        SplashButton(
          onTap: onGoReferralComponent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const AppImage.asset(asset: 'ic_invite_user', width: 40, height: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Mời người khác tham gia cộng đồng',
                    style: UITextStyle.medium.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const AppImage.asset(asset: 'ic_arrow_right', width: 20, height: 20),
              ],
            ),
          ),
        ),
        if (useRsmPush == true) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 33, thickness: 1, color: UIColors.lightGray),
          ),
          SplashButton(
            onTap: () {
              Navigator.pop(context);
              context.router.push(const RSMPushRoute());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const AppImage.asset(asset: 'ic_push_message', width: 40, height: 40),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Tương tác hàng loạt với cộng đồng',
                      style: UITextStyle.medium.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const AppImage.asset(asset: 'ic_arrow_right', width: 20, height: 20),
                ],
              ),
            ),
          ),
        ],
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(height: 33, thickness: 1, color: UIColors.lightGray),
        ),
        SplashButton(
          onTap: () {
            Navigator.pop(context);
            GlobalFunction.pushWebView(url: AppData.instance.appInfo.urlRuleCobllabNewModel);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const AppImage.asset(asset: 'ic_academy_note', width: 40, height: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Quy định về duy trì cộng đồng',
                    style: UITextStyle.medium.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const AppImage.asset(asset: 'ic_arrow_right', width: 20, height: 20),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  _sort(List<GeneralObject> rootData) {
    List<GeneralObject> data = [
      GeneralObject(code: CollaboratorStatus.working.name),
      GeneralObject(code: CollaboratorStatus.follow.name),
      GeneralObject(code: CollaboratorStatus.can_leave.name),
      GeneralObject(code: CollaboratorStatus.can_remove.name),
      GeneralObject(code: CollaboratorStatus.departed.name),
    ];
    for (var element in data) {
      GeneralObject? temp = rootData.firstWhereOrNull((e) => e.code == element.code);
      element.value = temp?.value;
    }
    return data
        .where((e) => AppConstants.visibleCollaboratorCanRemove || e.code != CollaboratorStatus.can_remove.name)
        .toList();
  }

  String _getItemTitle(String? code) {
    if (code == CollaboratorStatus.working.name) {
      return 'Có hoạt động';
    }
    if (code == CollaboratorStatus.follow.name) {
      return 'Cần theo dõi';
    }
    if (code == CollaboratorStatus.can_leave.name) {
      return 'Có thể rời đi';
    }
    if (code == CollaboratorStatus.can_remove.name) {
      return 'Có thể xóa';
    }
    if (code == CollaboratorStatus.departed.name) {
      return 'Vừa rời đi';
    }
    return '';
  }

  Color _getItemValueColor(String? code) {
    if (code == CollaboratorStatus.working.name) {
      return UIColors.purple;
    }
    if (code == CollaboratorStatus.follow.name) {
      return UIColors.red;
    }
    if (code == CollaboratorStatus.can_leave.name) {
      return UIColors.orange;
    }
    if (code == CollaboratorStatus.can_remove.name) {
      return UIColors.bluePurple;
    }
    if (code == CollaboratorStatus.departed.name) {
      return UIColors.defaultText;
    }
    return UIColors.defaultText;
  }
}
