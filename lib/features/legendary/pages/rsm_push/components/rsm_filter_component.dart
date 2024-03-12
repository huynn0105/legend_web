import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/features/legendary/cubit/rsm_push/rsm_push_user_cubit.dart';

import '../../../../../common/colors.dart';
import '../../../../../common/styles.dart';
import '../items/rsm_filter_item.dart';

class RSMFilterComponent extends StatelessWidget {
  const RSMFilterComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<RSMPushUserCubit, RSMPushUserState>(
        builder: (context, state) {
          return Container(
            color: UIColors.white,
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Theo loại cộng tác viên',
                  style: UITextStyle.bold,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  runSpacing: 16,
                  children: List.generate(
                    state.listCollaboratorRSMLevel.length,
                    (index) {
                      final item = state.listCollaboratorRSMLevel[index];
                      return RSMFilterItem(
                        selected: item.value == state.selectedCollaboratorRSMLevel?.value,
                        label: item.value == state.selectedCollaboratorRSMLevel?.value
                            ? item.focusTitle
                            : item.unFocusTitle,
                        onTap: () {
                          context.read<RSMPushUserCubit>().selectCollaboratorRSMLevel(item);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Theo trạng thái',
                  style: UITextStyle.bold,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  runSpacing: 16,
                  children: List.generate(
                    state.listCollaboratorRSMStatus.length,
                    (index) {
                      final item = state.listCollaboratorRSMStatus[index];
                      return RSMFilterItem(
                        selected: item.value == state.selectedCollaboratorRSMStatus?.value,
                        label: item.label,
                        onTap: () {
                          context.read<RSMPushUserCubit>().selectCollaboratorRSMStatus(item);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Theo TOP doanh số',
                  style: UITextStyle.bold,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  runSpacing: 16,
                  children: List.generate(
                    state.listCollaboratorRSMTop.length,
                    (index) {
                      final item = state.listCollaboratorRSMTop[index];
                      return RSMFilterItem(
                        selected: item.value == state.selectedCollaboratorRSMTop?.value,
                        label: item.title,
                        onTap: () {
                          context.read<RSMPushUserCubit>().selectCollaboratorRSMTop(item);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  width: double.infinity,
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  title: 'Chọn đối tượng',
                  height: 48,
                ),
                const SizedBox(height: 20),
                SplashButton(
                  onTap: () {
                    context.read<RSMPushUserCubit>().resetFilter();
                  },
                  child: Center(
                    child: Text(
                      'Đặt lại bộ lọc',
                      style: UITextStyle.medium.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
