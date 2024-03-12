import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:legend_mfast/app_data.dart';
import 'package:legend_mfast/features/legendary/repository/legendary_repository.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_hier_info_user_payload.dart';

import '../../../../common/bloc_status.dart';
import '../../../../common/utils/log_util.dart';
import '../../../../models/legendary/legendary_hier_user_info_model.dart';

part 'legendary_hier_user_info_state.dart';

class LegendaryHierUserInfoCubit extends Cubit<LegendaryHierUserInfoState> {
  LegendaryHierUserInfoCubit({
    this.debugLabel,
  }) : super(const LegendaryHierUserInfoState());

  final String? debugLabel;

  final _repository = LegendaryRepository();

  LegendaryHierUserInfoPayload _payload = LegendaryHierUserInfoPayload();

  Future fetchData({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(
        status: BlocStatus.loading,
      ));
    }

    final result = await _repository.getLegendaryHierUserInfo(
      payload: _payload,
    );

    if (result.status) {
      emit(state.copyWith(
        status: BlocStatus.success,
        data: result.data,
      ));
    } else {
      AppLog.d('asdasd', '${result.data?.rank?.level?.title}');
      emit(state.copyWith(
        status: BlocStatus.failure,
      ));
    }
  }

  _updatePayload({
    String? userID,
    bool? isUserCollab,
    String? parentUserID,
  }) {
    _payload = _payload.copyWith(
      userID: userID,
      isUserCollab: isUserCollab,
      parentUserID: parentUserID,
    );
  }

  updatePayloadUserID({String? userID}) {
    final currentUserID = userID ?? AppData.instance.userID;
    final parentUserID = AppData.instance.userID;
    final isUserCollab = currentUserID != parentUserID;
    _updatePayload(
      userID: currentUserID,
      isUserCollab: isUserCollab,
      parentUserID: parentUserID,
    );
  }

  clearData() {
    emit(const LegendaryHierUserInfoState());
  }
}
