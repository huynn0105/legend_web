import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/constants.dart';
import 'package:legend_mfast/common/event_bus/event_bus.dart';
import 'package:legend_mfast/common/widgets/app_layout.dart';
import 'package:legend_mfast/common/widgets/appbar.dart';
import 'package:legend_mfast/features/legendary/cubit/rsm_push/rsm_push_user_cubit.dart';
import 'package:legend_mfast/features/legendary/cubit/rsm_push_history/rsm_push_history_cubit.dart';
import 'package:legend_mfast/routes/routes.gr.dart';

import '../../../../common/widgets/loading.dart';
import '../../../../common/widgets/tabbar/tabbar.dart';
import '../../../../general_config.dart';

@RoutePage()
class RSMPushPage extends StatefulWidget implements AutoRouteWrapper {
  const RSMPushPage({super.key});

  @override
  State<RSMPushPage> createState() => _RSMPushPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RSMPushUserCubit()
            ..init()
            ..getCollaborators(),
        ),
        BlocProvider(
          create: (context) => RSMPushHistoryCubit(),
        ),
      ],
      child: this,
    );
  }
}

class _RSMPushPageState extends State<RSMPushPage> {
  TabController? tabController;
  late final StreamSubscription rsmPushSub;

  @override
  void initState() {
    super.initState();
    rsmPushSub = eventBus.on<ChangeRSMPushTab>().listen((event) {
      if (tabController != null) {
        tabController!.animateTo(event.index);
      }
    });
  }

  @override
  void dispose() {
    tabController = null;
    rsmPushSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppLayout(
            child: Column(
              children: [
                MFastSimpleAppBar(
                  title: "Gửi thông báo hàng loạt",
                  context: context,
                ),
                Expanded(
                  child: AutoTabsRouter.tabBar(
                    physics: AppConstants.physics,
                    routes: const [
                      RSMPushUserRoute(),
                      RSMPushHistoryRoute(),
                    ],
                    builder: (context, child, tabController) {
                      this.tabController = tabController;
                      return Column(
                        children: [
                          UnderlineIndicatorTabbar(
                            controller: tabController,
                            backgroundColor: UIColors.background,
                            titles: const [
                              "Gửi thông báo",
                              "Lịch sử gửi",
                            ],
                          ),
                          Expanded(
                            child: child,
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
