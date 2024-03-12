import 'package:legend_mfast/app_data.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/extension/list_extension.dart';
import 'package:legend_mfast/common/size.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/format_util.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/animated_donut_chart.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/donut_chart_data.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/donut_chart_legend.dart';
import 'package:popover/popover.dart';

import '../../../../../cubit/date_selection/date_selection_cubit.dart';
import '../../../../../cubit/legendary_income_chart/legendary_income_chart_cubit.dart';
import '../widgets/legendary_block_widget.dart';
import '../widgets/legendary_tab_filter_widget.dart';
import '../widgets/legendary_knowledge_widget.dart';
import '../widgets/legendary_tooltip_widget.dart';

class LegendaryIncomeChartComponent extends StatelessWidget {
  const LegendaryIncomeChartComponent({
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
        BlocListener<LegendaryIncomeChartCubit, LegendaryIncomeChartState>(
          listenWhen: (pre, cur) {
            return pre.status != cur.status;
          },
          listener: (context, state) => _action(context),
        ),
      ],
      child: BlocBuilder<LegendaryIncomeChartCubit, LegendaryIncomeChartState>(
        builder: (context, state) {
          final cubit = context.read<LegendaryIncomeChartCubit>();
          if (state.status.isInitial) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _onInit(context);
            });
          }

          final title = userID == AppData.instance.userID ? 'bạn' : (fullName ?? '').trim();
          final data = state.data;
          final tooltips = data?.note ?? [];
          final totalValue = (!state.status.isSuccess ? 0 : data?.products?.wallet ?? 0).toDouble();
          final salesGrowth = data?.products?.salesGrowth;
          final statusGrowth = data?.products?.statusGrowth;

          final displayTotalValue = FormatUtil.numberFormat(totalValue, showUnit: false);
          final displayTotalUnit = FormatUtil.formatNumberByThousandSeparator(totalValue).replaceAll(RegExp('[0-9.,]'), '');

          ///
          return LegendaryBlockWidget(
            title: 'Thu nhập của $title',
            onShowToolTip: (context) {
              showPopover(
                context: context,
                width: AppSize.instance.width * 0.75,
                arrowWidth: 10,
                arrowHeight: 10,
                bodyBuilder: (context) {
                  return LegendaryTooltipWidget(
                    data: tooltips,
                  );
                },
              );
            },
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
                            totalValue: totalValue,
                            enableDisplayTitle: state.status.isSuccess,
                            onDisplayTitle: (value) {
                              return displayTotalValue;
                            },
                            subtitle: displayTotalUnit,
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
                                  'Tổng thu nhập',
                                  style: UITextStyle.regular.copyWith(
                                    fontSize: 14,
                                    color: UIColors.grayText,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        FormatUtil.currencyDoubleFormat(totalValue.toDouble()),
                                        style: UITextStyle.semiBold.copyWith(
                                          fontSize: 18,
                                          color: UIColors.darkBlue,
                                        ),
                                      ),
                                    ),
                                    DonutGrowthWidget(
                                      data: DonutChartLegendSectionData(
                                        growthValue: salesGrowth ?? 0,
                                        growthStatus: statusGrowth ?? '',
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
                        "Phân loại thu nhập theo sản phẩm",
                        style: UITextStyle.regular.copyWith(
                          fontSize: 14,
                          color: UIColors.grayText,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      DonutChartLegend(
                        controller: cubit.chartController,
                        enableShowLoading: data == null,
                        onDisplayLabel: (section) {
                          return "${FormatUtil.doubleFormat(section.value)}${section.unit}";
                        },
                      ),
                      if (data?.urlPost?.getFirst() != null) ...[
                        const SizedBox(
                          height: 12,
                        ),
                        LegendaryKnowledgeWidget(
                          title: data?.urlPost?.getFirst()?.title ?? '',
                          url: data?.urlPost?.getFirst()?.url ?? '',
                        ),
                      ],
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
    final cubit = context.read<LegendaryIncomeChartCubit>();
    final dateCubit = context.read<DateSelectionCubit>();
    cubit
      ..updatePayloadUserID(userID: userID)
      ..updatePayloadMonth(date: dateCubit.state.date)
      ..fetchData();
  }

  void _action(BuildContext context) async {
    final cubit = context.read<LegendaryIncomeChartCubit>();
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
