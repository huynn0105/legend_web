import 'package:legend_mfast/app_data.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/format_util.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/animated_donut_chart.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/donut_chart_data.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/donut_chart_helper.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/donut_chart_legend.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_activity_chart/legendary_activity_chart_cubit.dart';

import '../../../../../cubit/date_selection/date_selection_cubit.dart';
import '../widgets/legendary_block_widget.dart';
import '../widgets/legendary_tab_filter_widget.dart';

class LegendaryActivityChartComponent extends StatelessWidget {
  const LegendaryActivityChartComponent({
    super.key,
    required this.userID,
    required this.fullName,
  });

  final String? userID;
  final String? fullName;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LegendaryActivityChartCubit, LegendaryActivityChartState>(
          listenWhen: (pre, cur) {
            return pre.status != cur.status;
          },
          listener: (context, state) => _action(context),
        ),
      ],
      child: BlocBuilder<LegendaryActivityChartCubit, LegendaryActivityChartState>(
        builder: (context, state) {
          final cubit = context.read<LegendaryActivityChartCubit>();
          if (state.status.isInitial) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _onInit(context);
            });
          }

          final title = userID == AppData.instance.userID ? 'bạn' : (fullName ?? '').trim();
          final data = state.data;
          final totalValue = !state.status.isSuccess ? 0 : data?.total?.numOfType ?? 0;
          final percentGrowth = data?.total?.percentGrowth;

          ///
          return LegendaryBlockWidget(
            title: 'Hoạt động của $title',
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LegendaryTabFilterWidget(
                  data: state.tabFilters,
                  selectedItem: state.selectedTabFilter,
                  onSelected: cubit.selectTabFilter,
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: UIColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AnimatedDonutChart(
                            controller: cubit.chartController,
                            size: 108,
                            totalValue: totalValue.toDouble(),
                            enableDisplayTitle: state.status.isSuccess,
                            onDisplayTitle: (value) {
                              return value.round().toString();
                            },
                            subtitle: 'hồ sơ',
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tổng hồ sơ khách hàng',
                                  style: UITextStyle.regular.copyWith(
                                    fontSize: 14,
                                    color: UIColors.grayText,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '$totalValue',
                                        style: UITextStyle.semiBold.copyWith(
                                          fontSize: 18,
                                          color: UIColors.darkBlue,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: percentGrowth != null,
                                      child: DonutGrowthWidget(
                                        data: DonutChartLegendSectionData(
                                          growthValue: (percentGrowth ?? 0).abs(),
                                          growthStatus: (percentGrowth ?? 0) > 0
                                              ? DonutLegendGrowthStatus.up.name
                                              : DonutLegendGrowthStatus.down.name,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Phân loại hồ sơ theo nhóm dự án",
                        style: UITextStyle.regular.copyWith(
                          fontSize: 14,
                          color: UIColors.grayText,
                        ),
                      ),
                      DonutChartLegend(
                        controller: cubit.chartController,
                        enableShowLoading: data == null,
                        padding: const EdgeInsets.only(top: 12),
                        onDisplayLabel: (section) {
                          return "${FormatUtil.doubleFormat(section.value)} ${section.unit}";
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onInit(BuildContext context) {
    final cubit = context.read<LegendaryActivityChartCubit>();
    final dateCubit = context.read<DateSelectionCubit>();

    cubit
      ..updatePayloadUserID(userID: userID)
      ..updatePayloadMonth(date: dateCubit.state.date)
      ..fetchData();
  }

  void _action(BuildContext context) async {
    final cubit = context.read<LegendaryActivityChartCubit>();
    final state = cubit.state;
    if (state.status.isLoading) {
      cubit.chartController.load();
      return;
    }
    if (state.status.isSuccess) {
      cubit.chartController.show(data: cubit.getDonutChartData());
      return;
    }
    if (state.status.isFailure) {
      cubit.chartController.empty();
      return;
    }
  }
}
