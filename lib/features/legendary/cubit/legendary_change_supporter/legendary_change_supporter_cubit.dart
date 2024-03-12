import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/features/legendary/repository/legendary_repository.dart';

import '../../../../models/legendary/check_change_supporter_model.dart';

part 'legendary_change_supporter_state.dart';

class LegendaryChangeSupporterCubit extends Cubit<LegendaryChangeSupporterState> {
  LegendaryChangeSupporterCubit() : super(const LegendaryChangeSupporterState());
  final _repository = LegendaryRepository();

  checkChangeSupporter() async {
    emit(state.copyWith(
      checkStatus: BlocStatus.loading,
    ));

    final result = await _repository.checkChangeSupporter();

    if (result.status) {
      emit(state.copyWith(
        checkStatus: BlocStatus.success,
      ));
    } else {
      emit(state.copyWith(
        checkStatus: BlocStatus.failure,
        checkData: result.data,
      ));
    }
  }

  leaveSupporter() async {
    emit(state.copyWith(
      leaveStatus: BlocStatus.loading,
    ));

    final result = await _repository.leaveSupporter();

    if (result.status) {
      emit(state.copyWith(
        leaveStatus: BlocStatus.success,
        leaveMessage: result.errorMessage ?? "Bạn đã trở thành cộng tác viên tự do",
      ));
    } else {
      emit(state.copyWith(
        leaveStatus: BlocStatus.failure,
        leaveMessage: result.errorMessage,
      ));
    }
  }
}
