import 'package:legend_mfast/app_data.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/extension/list_extension.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/format_util.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/animated_donut_chart.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/donut_chart_data.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/donut_chart_legend.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_collaborator_chart/legendary_collaborator_chart_cubit.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_hier_user_info/legendary_hier_user_info_cubit.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/widgets/legendary_info_block_widget.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/widgets/legendary_sheet_filter_widget.dart';
import '../../../../../cubit/date_selection/date_selection_cubit.dart';
import '../widgets/legendary_block_widget.dart';
import '../widgets/legendary_tab_filter_widget.dart';
import '../widgets/legendary_knowledge_widget.dart';

class LegendaryCollaboratorChartComponent extends StatelessWidget {
  const LegendaryCollaboratorChartComponent({
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
        BlocListener<LegendaryCollaboratorChartCubit, LegendaryCollaboratorChartState>(
          listenWhen: (pre, cur) {
            return pre.status != cur.status;
          },
          listener: (context, state) => _action(context),
        ),
      ],
      child: BlocBuilder<LegendaryHierUserInfoCubit, LegendaryHierUserInfoState>(
        builder: (context, state) {
          if (state.data == null) {
            return const SizedBox();
          }

          ///
          return BlocBuilder<LegendaryCollaboratorChartCubit, LegendaryCollaboratorChartState>(
            builder: (context, state) {
              final cubit = context.read<LegendaryCollaboratorChartCubit>();
              if (state.status.isInitial) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _onInit(context);
                });
              }

              final title = userID == AppData.instance.userID ? 'bạn' : (fullName ?? '').trim();
              final data = state.data;
              final name = data?.collaborators?.data?.name ?? '';
              final totalValue = !state.status.isSuccess ? 0 : (data?.collaborators?.data?.wallet ?? 0);
              final collaboratorsRatio = data?.collaborators?.data?.ratio ?? 0;
              final salesGrowth = data?.collaborators?.data?.salesGrowth;
              final statusGrowth = data?.collaborators?.data?.statusGrowth;

              ///
              return LegendaryBlockWidget(
                title: 'Cộng tác viên (CTV) của $title',
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: LegendarySheetFilterWidget(
                            data: state.levelFilters,
                            selectedItem: state.selectedLevelFilter,
                            onSelected: cubit.selectLevelFilter,
                            sheetTitle: 'Tầng cộng tác viên',
                            onDateWrapperUpdated: (wrapper) {
                              if (data!.isNotHead != null) {
                                return wrapper..removeLast();
                              }
                              return wrapper;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: LegendarySheetFilterWidget(
                            data: state.typeFilters,
                            selectedItem: state.selectedTypeFilter,
                            onSelected: cubit.selectTypeFilter,
                            sheetTitle: 'Tình trạng cộng tác viên',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
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
                          AnimatedSize(
                            duration: const Duration(milliseconds: 500),
                            alignment: Alignment.topCenter,
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: LegendaryInfoBlockWidget(
                                      title: 'Tổng số CTV',
                                      subtitle: '${data?.collaborator ?? 0} người',
                                      subtitleColor: UIColors.defaultText,
                                      backgroundColor: UIColors.extraLightPurple,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: LegendaryInfoBlockWidget(
                                      title: '% $name',
                                      subtitle: '${FormatUtil.doubleFormat(data?.ratio ?? 0)}%',
                                      subtitleColor: UIColors.secondaryColor,
                                      backgroundColor: UIColors.lightSecondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          LegendaryTabFilterWidget(
                            data: state.tabFilters,
                            selectedItem: state.selectedTabFilter,
                            onSelected: cubit.selectTabFilter,
                            itemBackgroundColor: UIColors.extraLightGray,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
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
                                subtitle: 'người',
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
                                      name,
                                      style: UITextStyle.regular.copyWith(
                                        fontSize: 14,
                                        color: UIColors.grayText,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${totalValue.round()} người',
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
                                    Text(
                                      '${collaboratorsRatio == 0 ? '0' : '~ ${FormatUtil.doubleFormat(collaboratorsRatio)}'}% / tổng CTV',
                                      style: UITextStyle.regular.copyWith(
                                        fontSize: 14,
                                        color: UIColors.grayText,
                                      ),
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
                            "Tỉ trọng CTV có doanh số theo tầng",
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
          );
        },
      ),
    );
  }

  void _onInit(BuildContext context) {
    final cubit = context.read<LegendaryCollaboratorChartCubit>();
    final dateCubit = context.read<DateSelectionCubit>();
    final hierUserInfoCubit = context.read<LegendaryHierUserInfoCubit>();

    ///
    cubit
      ..updatePayloadUserID(userID: userID)
      ..updatePayloadMonth(date: dateCubit.state.date)
      ..updatePayloadRank(rank: hierUserInfoCubit.state.data?.rank?.level?.level)
      ..fetchData();
  }

  void _action(BuildContext context) async {
    final cubit = context.read<LegendaryCollaboratorChartCubit>();
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
