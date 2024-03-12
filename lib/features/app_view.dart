import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../di/get_it.dart';
import '../../routes/routes_observer.dart';
import '../common/bloc_status.dart';
import '../common/colors.dart';
import '../common/size.dart';
import '../common/widgets/scroll_configuration.dart';
import '../env_config.dart';
import '../routes/routes.dart';
import 'app_cubit.dart';
import 'legendary/cubit/legendary_hier_user_info/legendary_hier_user_info_cubit.dart';
import 'user/cubit/user/user_cubit.dart';

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppViewState();
  }
}

class _AppViewState extends State<AppView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _preCacheImages();
    });
    super.initState();
  }

  _preCacheImages() {
    String package = EnvConfig.instance.package != null ? '${EnvConfig.instance.package}/' : '';
    precacheImage(AssetImage('${package}assets/images/ic_marker.png'), context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getItInstance.get<AppCubit>()),
        BlocProvider.value(value: getItInstance.get<UserCubit>()),
        BlocProvider.value(value: getItInstance.get<LegendaryHierUserInfoCubit>()),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Portal(
            child: RefreshConfiguration(
              footerTriggerDistance: _getHeightWithoutContext() * 2 / 3,
              hideFooterWhenNotFull: true,
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routeInformationParser: getItInstance.get<AppRouter>().defaultRouteParser(),
                routerDelegate: getItInstance.get<AppRouter>().delegate(
                      // initialRoutes: [
                      //   ChatRoute(accessToken: AppData.i)
                      // if (AppData.instance.initialPath == RoutePath.mtrade)
                      //   MTradeRoute()
                      // else if (AppData.instance.initialPath == RoutePath.shipper)
                      //   const ShipperRoute()
                      // else if (AppData.instance.initialPath == RoutePath.academy)
                      //     const AcademyRoute()
                      //   else if (AppData.instance.initialPath == RoutePath.mfast)
                      //       const MFastRoute()
                      //     else if (AppData.instance.initialPath == RoutePath.chat)
                      //         const ChatRoute()
                      // ],
                      navigatorObservers: () => [
                        AppRoutesObserver(),
                      ],
                    ),
                theme: Theme.of(context).copyWith(
                  scaffoldBackgroundColor: UIColors.background,
                ),
                builder: (context, child) {
                  AppSize.instance.init(context);
                  if (!state.status.isSuccess && kIsWeb) {
                    return const Scaffold(
                      body: LinearProgressIndicator(
                        color: UIColors.primaryColor,
                        backgroundColor: UIColors.lightBlue,
                      ),
                    );
                  }
                  return ScrollConfiguration(
                    behavior: RemoveGlowScrollBehavior(),
                    child: Stack(
                      children: [
                        child!,
                        // const Visibility(
                        //   child: Material(
                        //     type: MaterialType.transparency,
                        //     child: LoadingWidget.dark(),
                        //   ),
                        // ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _dismissKeyboardOnLostFocus(BuildContext ctx) {
    final FocusScopeNode currentFocus = FocusScope.of(ctx);
    if (!currentFocus.hasPrimaryFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  _getHeightWithoutContext() {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    return view.physicalSize.height / view.devicePixelRatio;
  }
}

clickedBackBtn() {
  return true;
}
