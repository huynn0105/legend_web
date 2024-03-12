import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/models/general_object.dart';

import '../../../../../../../common/colors.dart';
import '../../../../../../../common/constants.dart';
import '../../../../../../../common/enum/collaborator/collaborator_status.dart';
import '../../../../../../../common/styles.dart';
import '../../../../../../../routes/routes.gr.dart';
import '../../../../../../../widgets/data_widget.dart';
import '../../../../../cubit/legendary_collaborator/legendary_collaborator_cubit.dart';

class CollaboratorNeedToCareComponent extends StatelessWidget {
  const CollaboratorNeedToCareComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LegendaryCollaboratorCubit, LegendaryCollaboratorState>(
      builder: (context, state) {
        final List<GeneralObject> data = _sort(state.collaboratorStatus?.data ?? []);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cộng tác viên cần chú ý",
              style: UITextStyle.semiBold.copyWith(
                fontSize: 18,
                color: UIColors.lightBlack,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            SizedBox(
              height: 62,
              child: ListView.separated(
                physics: AppConstants.physics,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return DataWidget(
                    title: _getItemTitle(data[index].code ?? ''),
                    value: '${data[index].value ?? 0}',
                    textColor: _getItemValueColor(data[index].code ?? ''),
                    onTap: () {
                      _onGoToPage(context, data[index].code ?? '');
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 8,
                  );
                },
                itemCount: data.length,
              ),
            ),
          ],
        );
      },
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

  CollaboratorStatus _getCollaboratorStatus(String? code) {
    if (code == CollaboratorStatus.working.name) {
      return CollaboratorStatus.working;
    }
    if (code == CollaboratorStatus.follow.name) {
      return CollaboratorStatus.follow;
    }
    if (code == CollaboratorStatus.can_leave.name) {
      return CollaboratorStatus.can_leave;
    }
    if (code == CollaboratorStatus.can_remove.name) {
      return CollaboratorStatus.can_remove;
    }
    if (code == CollaboratorStatus.departed.name) {
      return CollaboratorStatus.departed;
    }
    return CollaboratorStatus.working;
  }

  _onGoToPage(BuildContext context, String initialTabCode) {
    context.pushRoute(CollaboratorNeedToCareRoute(collaboratorStatus: _getCollaboratorStatus(initialTabCode)));
  }
}
