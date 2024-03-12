import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:legend_mfast/common/bloc_status.dart';

import '../../../../models/user/referral_info_model.dart';
import '../../../../models/user/user_info_model.dart';
import '../../../../models/user/user_meta_data_model.dart';
import '../../repository/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());

  final _repository = UserRepository();

  Future fetchData() async {
    await Future.wait([
      getUserInfo(),
      getUserMetaData(),
      getRefLink(),
    ]);
  }

  Future getUserInfo() async {
    emit(state.copyWith(
      status: BlocStatus.loading,
    ));

    final result = await _repository.getUserInfo();

    if (result.status) {
      emit(state.copyWith(
        status: BlocStatus.success,
        userInfo: result.data,
      ));
    } else {
      emit(state.copyWith(
        status: BlocStatus.failure,
      ));
    }
  }

  Future getUserMetaData() async {
    emit(state.copyWith(
      status: BlocStatus.loading,
    ));

    final result = await _repository.getUserMetaData();

    if (result.status) {
      emit(state.copyWith(
        status: BlocStatus.success,
        userMetaData: result.data,
      ));
    } else {
      emit(state.copyWith(
        status: BlocStatus.failure,
      ));
    }
  }

  Future getRefLink() async {
    final result = await _repository.getReferralInfo();
    emit(state.copyWith(
      referral: result.data,
    ));
  }

  clearData() {
    emit(const UserState());
  }
}
