import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:legend_mfast/app_data.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/features/legendary/repository/legendary_repository.dart';
import 'package:legend_mfast/models/collaborator/collaborator_my_supporter_waiting_model.dart';
import 'package:legend_mfast/models/collaborator/collaborator_review_filter_response_model.dart';

part 'legendary_supporter_state.dart';

class LegendarySupporterCubit extends Cubit<LegendarySupporterState> {
  LegendarySupporterCubit() : super(const LegendarySupporterState());

  final _repository = LegendaryRepository();

  Future getReviewFilter() async {
    emit(state.copyWith(
      status: BlocStatus.loading,
    ));
    final result = await Future.wait([
      _repository.getReviewFilter(userID: AppData.instance.userID),
      _repository.getMySupporterWaiting(),
    ]);

    if (result.first.status) {
      emit(state.copyWith(
        status: BlocStatus.success,
        filters: result.first.data as LegendaryReviewFilterResponseModel?,
        mySupporterWaiting: result.last.data as MySupporterWaitingModel? ?? MySupporterWaitingModel(),
      ));
    } else {
      emit(state.copyWith(
        status: BlocStatus.failure,
      ));
    }
  }

  void changeSupporterWaiting(MySupporterWaitingModel supporter) {
    emit(state.copyWith(
      mySupporterWaiting: supporter,
    ));
  }
}
