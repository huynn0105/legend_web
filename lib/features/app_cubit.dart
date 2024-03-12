import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:legend_mfast/di/get_it.dart';
import 'package:legend_mfast/features/user/cubit/user/user_cubit.dart';

import '../../../../common/bloc_status.dart';
import '../app_data.dart';
import '../common/utils/text_util.dart';
import '../services/api/api_provider.dart';
import '../services/firebase/firebase_auth/firebase_auth_service.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'legendary/cubit/legendary_hier_user_info/legendary_hier_user_info_cubit.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  init() async {
    emit(state.copyWith(status: BlocStatus.loading));
    await initializeDateFormatting('vi');
    await Future.wait([
      getFirebaseUser(),
      getConfigs(),
      getUserInfo(),
    ]);
    await getLegendHierUserInfo();
    emit(state.copyWith(status: BlocStatus.success));
  }

  forceLogin() {
    emit(state.copyWith(forceLogin: true));
  }

  Future getUserInfo() async {
    await getItInstance.get<UserCubit>().fetchData();
  }

  Future getLegendHierUserInfo() async {
    getItInstance.get<LegendaryHierUserInfoCubit>().updatePayloadUserID(userID: AppData.instance.userID);
    await getItInstance.get<LegendaryHierUserInfoCubit>().fetchData();
  }

  Future getFirebaseUser() async {
    String? accessToken = AppData.instance.accessToken;
    if (accessToken == null) return;
    final result = await ApiProvider.instance.user.getFirebaseUser(accessToken: accessToken);
    if (result.status) {
      String? firebaseToken = result.data?.firebaseToken;
      AppData.instance.setUserInfo(
        firebaseAuthToken: firebaseToken,
        userID: result.data?.id,
      );
      if (TextUtils.isNotEmpty(firebaseToken)) {
        await FirebaseAuthService.instance.signInWithCustomToken(firebaseToken!);
      }
    }
  }

  Future getConfigs() async {
    final result = await ApiProvider.instance.config.getConfigs();
    if (result.status) {
      AppData.instance.setAppConfig(result.data);
    }
  }
}
