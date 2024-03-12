import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/widgets/app_layout.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/empty_widget.dart';
import 'package:legend_mfast/common/widgets/loading.dart';
import 'package:legend_mfast/features/legendary/pages/rsm_push/items/rsm_push_log_item.dart';
import 'package:legend_mfast/general_config.dart';

import '../../../../../common/colors.dart';
import '../../../../../common/event_bus/event_bus.dart';
import '../../../../../common/styles.dart';
import '../../../../../common/widgets/date_action_button.dart';
import '../../../cubit/rsm_push_history/rsm_push_history_cubit.dart';

@RoutePage()
class RSMPushHistoryPage extends StatelessWidget {
  const RSMPushHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RSMPushHistoryCubit, RSMPushHistoryState>(
      builder: (context, state) {
        if (state.status.isInitial) {
          context.read<RSMPushHistoryCubit>().getNotificationLogs();
        }
        if (state.status.isInitial || state.status.isLoading) {
          return const LoadingWidget.dark();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DateActionButton.left(
                  onTap: () {
                    context.read<RSMPushHistoryCubit>().setPreviousMonth();
                  },
                  enabled: state.selectedMonth > 1,
                ),
                Container(
                  width: 110,
                  alignment: Alignment.center,
                  child: Text(
                    state.selectedMonth == state.currentMonth
                        ? 'Tháng hiện tại'
                        : ' ${state.selectedMonth}/ ${DateTime.now().year}',
                    style: UITextStyle.medium.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                DateActionButton.right(
                  onTap: () {
                    context.read<RSMPushHistoryCubit>().setNextMonth();
                  },
                  enabled: state.selectedMonth < 12 && state.selectedMonth != state.currentMonth,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Danh sách thông báo đã gửi',
                style: UITextStyle.regular.copyWith(
                  color: UIColors.grayText,
                ),
              ),
            ),
            const SizedBox(height: 8),
            if (state.filterData.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 18, right: 18, bottom: 40),
                  itemBuilder: (context, index) {
                    return RSMPushLogItem(
                      item: state.filterData[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                  itemCount: state.filterData.length,
                ),
              )
            else
              Column(
                children: [
                  const EmptyWidget(
                    icon: 'ic_empty_list',
                    iconWidth: 121,
                    iconHeight: 90,
                    message: 'Hiện tại chưa ghi nhận lượt gửi\nthông báo nào',
                  ),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    height: 40,
                    onPressed: () {
                      eventBus.fire(const ChangeRSMPushTab(0));
                    },
                    title: 'Gửi thông báo ngay',
                  ),
                ],
              )
          ],
        );
      },
    );
  }
}
