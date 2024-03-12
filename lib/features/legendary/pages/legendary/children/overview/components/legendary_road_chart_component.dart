import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:legend_mfast/common/widgets/images.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_road_chart/legendary_road_chart_cubit.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/components/legendary_fullscreen_road_chart.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/widgets/legendary_knowledge_widget.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/widgets/legendary_road/legendary_road_chart.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../../../../common/widgets/buttons.dart';
import '../../../../../cubit/date_selection/date_selection_cubit.dart';
import '../widgets/legendary_block_widget.dart';

class LegendaryRoadChartComponent extends StatelessWidget {
  const LegendaryRoadChartComponent({
    super.key,
    this.gender,
    this.userID,
    this.fullName,
    required this.isMyLegendaryHier,
  });

  final String? gender;
  final String? userID;
  final String? fullName;
  final bool isMyLegendaryHier;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LegendaryRoadChartCubit, LegendaryRoadChartState>(
      builder: (context, state) {
        if (state.status.isInitial) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _onInit(context);
          });
        }

        ///
        final date = context.select((DateSelectionCubit cubit) => cubit.state.date);
        final data = state.data;
        final name = isMyLegendaryHier ? 'Bạn' : (fullName ?? 'CTV');

        ///
        return LegendaryBlockWidget(
          title: '$name đang ở đâu?',
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: UIColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Con đường Huyền Thoại'.toUpperCase(),
                        style: UITextStyle.semiBold.copyWith(
                          fontSize: 16,
                          color: UIColors.darkBlue,
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    // SplashButton(
                    //   onTap: () => _onFullScreen(context, isMyLegendaryHier),
                    //   child: const AppImage.asset(
                    //     asset: 'ic_mfast_fullscreen',
                    //     width: 24,
                    //     height: 24,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Visibility(
                  visible: !state.status.showLoading,
                  child: LegendaryRoadChart(
                    data: data,
                    month: date.month,
                    gender: gender,
                    isMyLegendaryHier: isMyLegendaryHier,
                  ),
                ),
                if (TextUtils.isNotEmpty(data?.title)) ...[
                  LegendaryKnowledgeWidget(
                    title: data?.title ?? '',
                    url: data?.urlPost ?? '',
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  void _onInit(BuildContext context) {
    final cubit = context.read<LegendaryRoadChartCubit>();
    final dateCubit = context.read<DateSelectionCubit>();
    cubit
      ..updatePayloadUserID(userID: userID)
      ..updatePayloadMonth(date: dateCubit.state.date)
      ..fetchData();
  }

  void _onFullScreen(BuildContext context, bool isMyLegendaryHier) {
    final date = context.read<DateSelectionCubit>().state.date;
    final data = context.read<LegendaryRoadChartCubit>().state.data;
    if (data == null || gender == null) {
      return;
    }
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.bottomToTop,
        duration: const Duration(milliseconds: 300),
        child: LegendaryFullScreenRoadChart(
          data: data,
          date: date,
          gender: gender!,
          isMyLegendaryHier: isMyLegendaryHier,
        ),
      ),
    );
  }
}
