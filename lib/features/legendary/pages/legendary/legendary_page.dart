// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/app_data.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/enum/legendary/legendary_overview_content.dart';
import 'package:legend_mfast/common/widgets/app_layout.dart';
import 'package:legend_mfast/common/widgets/nested_scrollview.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_collaborator/legendary_collaborator_cubit.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_hier_user_info/legendary_hier_user_info_cubit.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/collaborator/legendary_collaborator_page.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/community/legendary_community_page.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/legendary_overview_page.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/components/utility_bottom_sheet_component.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../common/widgets/tabbar/tabbar.dart';
import '../../../../widgets/no_ekyc_item.dart';
import '../../../user/cubit/user/user_cubit.dart';
import 'components/collaborator_statistics_component.dart';

@RoutePage()
class LegendaryPage extends StatelessWidget {
  const LegendaryPage({
    super.key,
    @QueryParam("userID") this.userID,
  });

  final String? userID;

  @override
  Widget build(BuildContext context) {
    bool isMyLegendaryHier = userID == null || userID == AppData.instance.userID;
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (_) => MentorRatingCubit(),
        // ),
        if (!isMyLegendaryHier)
          BlocProvider(
            create: (_) => LegendaryHierUserInfoCubit()..updatePayloadUserID(userID: userID),
          ),
        BlocProvider(
          create: (_) => LegendaryCollaboratorCubit(),
        ),
      ],
      child: _LegendaryPage(
        userID: userID,
      ),
    );
  }
}

class _LegendaryPage extends StatefulWidget {
  const _LegendaryPage({
    this.userID,
  });

  final String? userID;

  @override
  State<_LegendaryPage> createState() => _LegendaryPageState();
}

class _LegendaryPageState extends State<_LegendaryPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final AutoScrollController _autoScrollController;

  final GlobalKey<ExtendedNestedScrollViewState> _autoScrollKey = GlobalKey<ExtendedNestedScrollViewState>();

  final _chartKeys = {
    LegendaryOverviewContent.experience: GlobalKey(debugLabel: 'experience_key'),
    LegendaryOverviewContent.income: GlobalKey(debugLabel: 'income_key'),
    LegendaryOverviewContent.collaborator: GlobalKey(debugLabel: 'collaborator_key'),
  };

  double TAB_BAR_HEIGHT = 72;
  double GAP_HEIGHT = 16;

  @override
  void initState() {
    super.initState();
    bool isMyLegendaryHier = widget.userID == null || widget.userID == AppData.instance.userID;
    _tabController = TabController(
      vsync: this,
      length: isMyLegendaryHier ? 3 : 2,
    );
    _autoScrollController = AutoScrollController(
      axis: Axis.vertical,
      viewportBoundaryGetter: () => Rect.zero,
    );
  }

  @override
  void dispose() {
    _autoScrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userID = widget.userID ?? AppData.instance.userID;
    final isMyLegendaryHier = userID == AppData.instance.userID;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: AppLayout(
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, userState) {
              final hasVerified = userState.userMetaData?.isCTVConfirmed == true;
              return !hasVerified
                  ? ListView(
                      physics: const PositionRetainedScrollPhysics(),
                      children: [
                        _collaboratorStatisticsComponent(
                          userID,
                          isMyLegendaryHier,
                          context,
                          hasVerified,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16, right: 16, top: 32),
                          child: NoEkycItem(),
                        ),
                      ],
                    )
                  : ExtendedNestedScrollView(
                      key: _autoScrollKey,
                      onlyOneScrollInBody: true,
                      physics: const PositionRetainedScrollPhysics(),
                      headerSliverBuilder: (_, __) {
                        return [
                          SliverToBoxAdapter(
                            child: _collaboratorStatisticsComponent(
                              userID,
                              isMyLegendaryHier,
                              context,
                              hasVerified,
                            ),
                          ),
                        ];
                      },
                      body: Column(
                        children: [
                          Container(
                            height: 72,
                            width: isMyLegendaryHier ? null : 300,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: const BoxDecoration(
                              color: UIColors.background,
                            ),
                            child: RoundedIndicatorTabbar(
                              controller: _tabController,
                              height: 40,
                              width: 105,
                              titles: [
                                "Tổng quan",
                                if (isMyLegendaryHier) "Cộng tác viên",
                                "Cộng đồng",
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: TabBarView(
                                physics: const NeverScrollableScrollPhysics (),
                                controller: _tabController,
                                children: [
                                  LegendaryOverviewPage(
                                    userID: userID,
                                    autoScrollController: _autoScrollController,
                                    legendaryExperienceKey: _chartKeys[LegendaryOverviewContent.experience],
                                    legendaryIncomeKey: _chartKeys[LegendaryOverviewContent.income],
                                    legendaryCollaboratorKey: _chartKeys[LegendaryOverviewContent.collaborator],
                                  ),
                                  if (isMyLegendaryHier) ...[
                                    const LegendaryCollaboratorPage(),
                                  ],
                                  LegendaryCommunityPage(
                                    userID: userID,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget _collaboratorStatisticsComponent(
    String userID,
    bool isMyLegendaryHier,
    BuildContext context,
    bool hasVerified,
  ) {
    return CollaboratorStatisticsComponent(
      userID: userID,
      isMyLegendaryHier: isMyLegendaryHier,
      onBack: () {
        context.popRoute();
      },
      isMoreEnable: hasVerified,
      onMore: () {
        _showUtilityOptions(context);
      },
      onChartAutoScroll: _onScrollToChart,
    );
  }

  _showUtilityOptions(BuildContext context) {
    final referralCode = context.read<UserCubit>().state.userInfo?.referralCode;
    final useRsmPush = context.read<UserCubit>().state.userInfo?.useRsmPush;
    final referral = context.read<UserCubit>().state.referral;
    final collaboratorStatus = context.read<LegendaryCollaboratorCubit>().state.collaboratorStatus;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      barrierColor: UIColors.blurBackground,
      builder: (_) {
        return UtilityBottomSheetComponent(
          referralCode: referralCode ?? '',
          referral: referral,
          collaboratorStatus: collaboratorStatus,
          useRsmPush: useRsmPush,
        );
      },
    );
  }

  _onScrollToChart(LegendaryOverviewContent chart) async {
    const duration = Duration(milliseconds: 500);

    if (_tabController.index != 0) {
      _tabController.animateTo(0, duration: duration, curve: Curves.fastOutSlowIn);
      await Future.delayed(duration);
    }

    final key = _chartKeys[chart]!;
    final box = key.currentContext?.findRenderObject() as RenderBox?;
    final outerCurOffset = _autoScrollKey.currentState?.outerController.position.pixels ?? 0;
    final outerMaxOffset = _autoScrollKey.currentState?.outerController.position.maxScrollExtent ?? 0;

    if (box != null) {
      final position = box.localToGlobal(Offset.zero);
      final tabBarHeight = TAB_BAR_HEIGHT * 2;
      final gapHeight = GAP_HEIGHT * 2;
      final offset = position.dy - tabBarHeight + gapHeight - outerMaxOffset + outerCurOffset;
      _autoScrollKey.currentState?.innerController.animateTo(offset, duration: duration, curve: Curves.fastOutSlowIn);
    }
  }
}
