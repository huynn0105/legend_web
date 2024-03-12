import 'package:get_it/get_it.dart';
import 'package:legend_mfast/features/user/cubit/user/user_cubit.dart';

import '../features/app_cubit.dart';
import '../features/legendary/cubit/legendary_hier_user_info/legendary_hier_user_info_cubit.dart';
import '../routes/routes.dart';

final getItInstance = GetIt.I;

configureDependencies() {
  getItInstance.registerSingleton<AppRouter>(AppRouter());
  //
  getItInstance.registerSingleton<AppCubit>(AppCubit());
  getItInstance.registerSingleton<UserCubit>(UserCubit());
  getItInstance.registerSingleton<LegendaryHierUserInfoCubit>(LegendaryHierUserInfoCubit(debugLabel: "global"));//TODO update when switch account
}
