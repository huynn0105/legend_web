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
import 'package:legend_mfast/common/widgets/chart/donut_chart/donut_chart_legend.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/growth_icon_widget.dart';
import 'package:legend_mfast/common/widgets/images.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/widgets/legendary_chart_detail_widget.dart';
import 'package:popover/popover.dart';

import '../../../../../cubit/date_selection/date_selection_cubit.dart';
import '../../../../../cubit/legendary_experience_chart/legendary_experience_chart_cubit.dart';
import '../widgets/legendary_block_widget.dart';
import '../widgets/legendary_tab_filter_widget.dart';
import '../widgets/legendary_knowledge_widget.dart';
import '../widgets/legendary_tooltip_widget.dart';

class LegendaryExperienceChartComponent extends StatelessWidget {
  const LegendaryExperienceChartComponent({
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
        BlocListener<LegendaryExperienceChartCubit, LegendaryExperienceChartState>(
          listenWhen: (pre, cur) {
            return pre.status != cur.status;
          },
          listener: (context, state) => _action(context),
        ),
      ],
      child: BlocBuilder<LegendaryExperienceChartCubit, LegendaryExperienceChartState>(
        builder: (context, state) {
          final cubit = context.read<LegendaryExperienceChartCubit>();
          if (state.status.isInitial) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _onInit(context);
            });
          }

          final title = userID == AppData.instance.userID ? 'bạn' : (fullName ?? '').trim();
          final data = state.data;
          final tooltips = data?.note ?? [];
          final details = data?.detail ?? [];

          final directSalesValue = data?.sales?.directSales ?? 0;
          final indirectSalesValue = data?.sales?.indirectSales ?? 0;

          var totalValue = 0;
          if (state.status.isSuccess) {
            if (state.selectedTabFilter?.id == 'allSales') {
              totalValue = directSalesValue + indirectSalesValue;
            } else if (state.selectedTabFilter?.id == 'directSales') {
              totalValue = directSalesValue;
            } else if (state.selectedTabFilter?.id == 'indirectSales') {
              totalValue = indirectSalesValue;
            }
          }

          final curRank = data?.rank?.level?.getFormatRank();
          final tmpRank = data?.rank?.tmpLevel?.getFormatRank();

          final showRankGrowth = (tmpRank?.point ?? 0) != (curRank?.point ?? 0);
          final isRankGrowthUp = (tmpRank?.point ?? 0) > (curRank?.point ?? 0);
          final rankTitle = tmpRank?.level ?? 'Tân Thủ';
          final rankStar = tmpRank?.star ?? '';

          ///
          return LegendaryBlockWidget(
            title: 'Kinh nghiệm của $title',
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
                      if (details.isNotEmpty) ...[
                        LegendaryChartDetailWidget(
                          data: details,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                      Row(
                        children: [
                          AnimatedDonutChart(
                            controller: cubit.chartController,
                            size: 108,
                            totalValue: totalValue.toDouble(),
                            enableDisplayTitle: state.status.isSuccess,
                            onDisplayTitle: (value) {
                              return FormatUtil.doubleFormat(value.round().toDouble(), decimalDigit: 1);
                            },
                            subtitle: 'điểm',
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
                                  'Danh hiệu dự đoán tháng tới',
                                  style: UITextStyle.regular.copyWith(
                                    fontSize: 14,
                                    color: UIColors.grayText,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Visibility(
                                      visible: showRankGrowth,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: GrowthIcon(isUp: isRankGrowthUp),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        rankTitle,
                                        style: UITextStyle.semiBold.copyWith(
                                          fontSize: 18,
                                          color: UIColors.darkBlue,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: rankStar.isNotEmpty,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 4,
                                            height: 4,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: UIColors.darkBlue,
                                            ),
                                            margin: const EdgeInsets.only(left: 8, right: 8),
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.baseline,
                                            textBaseline: TextBaseline.ideographic,
                                            children: [
                                              Text(
                                                rankStar,
                                                style: UITextStyle.semiBold.copyWith(
                                                  fontSize: 18,
                                                  color: UIColors.darkBlue,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              const AppImage.asset(
                                                asset: "ic_big_star",
                                                height: 24,
                                                width: 24,
                                              ),
                                            ],
                                          ),
                                        ],
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
                        "Phân loại kinh nghiệm theo sản phẩm",
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
    final cubit = context.read<LegendaryExperienceChartCubit>();
    final dateCubit = context.read<DateSelectionCubit>();
    cubit
      ..updatePayloadUserID(userID: userID)
      ..updatePayloadMonth(date: dateCubit.state.date)
      ..fetchData();
  }

  void _action(BuildContext context) async {
    final cubit = context.read<LegendaryExperienceChartCubit>();
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

  void getTempRank() {}

  void getCurrRank() {}
}
