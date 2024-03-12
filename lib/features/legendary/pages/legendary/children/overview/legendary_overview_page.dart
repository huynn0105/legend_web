import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/app_data.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_activity_chart/legendary_activity_chart_cubit.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_collaborator_chart/legendary_collaborator_chart_cubit.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_hier_user_info/legendary_hier_user_info_cubit.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_road_chart/legendary_road_chart_cubit.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/components/legendary_activity_chart_component.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/components/legendary_collaborator_chart_component.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/components/legendary_income_chart_component.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/components/legendary_road_chart_component.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_experience_chart/legendary_experience_chart_cubit.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_income_chart/legendary_income_chart_cubit.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/components/legendary_experience_chart_component.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../../../common/widgets/keep_alive_widget.dart';
import '../../../../cubit/date_selection/date_selection_cubit.dart';

@RoutePage()
class LegendaryOverviewPage extends StatelessWidget implements AutoRouteWrapper {
  const LegendaryOverviewPage({
    Key? key,
    this.userID,
    this.autoScrollController,
    this.legendaryExperienceKey,
    this.legendaryIncomeKey,
    this.legendaryCollaboratorKey,
  }) : super(key: key);

  final String? userID;
  final AutoScrollController? autoScrollController;
  final GlobalKey? legendaryExperienceKey;
  final GlobalKey? legendaryIncomeKey;
  final GlobalKey? legendaryCollaboratorKey;

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DateSelectionCubit(),
        ),
        BlocProvider(
          create: (_) => LegendaryRoadChartCubit(),
        ),
        BlocProvider(
          create: (_) => LegendaryExperienceChartCubit(),
        ),
        BlocProvider(
          create: (_) => LegendaryIncomeChartCubit(),
        ),
        BlocProvider(
          create: (_) => LegendaryActivityChartCubit(),
        ),
        BlocProvider(
          create: (_) => LegendaryCollaboratorChartCubit(),
        ),
      ],
      child: _LegendaryOverviewPageImpl(
        userID: userID,
        autoScrollController: autoScrollController,
        legendaryExperienceKey: legendaryExperienceKey,
        legendaryIncomeKey: legendaryIncomeKey,
        legendaryCollaboratorKey: legendaryCollaboratorKey,
      ),
    );
  }
}

class _LegendaryOverviewPageImpl extends StatelessWidget {
  const _LegendaryOverviewPageImpl({
    Key? key,
    this.userID,
    this.autoScrollController,
    this.legendaryExperienceKey,
    this.legendaryIncomeKey,
    this.legendaryCollaboratorKey,
  }) : super(key: key);

  final String? userID;
  final AutoScrollController? autoScrollController;
  final GlobalKey? legendaryExperienceKey;
  final GlobalKey? legendaryIncomeKey;
  final GlobalKey? legendaryCollaboratorKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LegendaryHierUserInfoCubit, LegendaryHierUserInfoState>(
      builder: (context, state) {
        final hierUser = state.data;
        final gender = hierUser?.user?.sex;
        final fullName = hierUser?.user?.fullName;

        final isMyLegendaryHier = userID == AppData.instance.userID;

        ///
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            children: [
              KeepAliveWidget(
                child: LegendaryRoadChartComponent(
                  userID: userID,
                  gender: gender,
                  fullName: fullName,
                  isMyLegendaryHier: isMyLegendaryHier,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              KeepAliveWidget(
                child: LegendaryExperienceChartComponent(
                  key: legendaryExperienceKey,
                  userID: userID,
                  fullName: fullName,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              KeepAliveWidget(
                child: LegendaryIncomeChartComponent(
                  key: legendaryIncomeKey,
                  userID: userID,
                  fullName: fullName,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              KeepAliveWidget(
                child: LegendaryActivityChartComponent(
                  userID: userID,
                  fullName: fullName,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              KeepAliveWidget(
                child: LegendaryCollaboratorChartComponent(
                  key: legendaryCollaboratorKey,
                  userID: userID,
                  fullName: fullName,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
