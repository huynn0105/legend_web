import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/features/legendary/repository/legendary_repository.dart';
import 'package:legend_mfast/models/collaborator/collaborator_new_supporter_model.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_supporter_by_filter_payload.dart';

part 'new_supporter_list_state.dart';

class NewSupporterListCubit extends Cubit<NewSupporterListState> {
  NewSupporterListCubit() : super(const NewSupporterListState());

  final _repository = LegendaryRepository();

  LegendarySupporterByFilterPayload payload = LegendarySupporterByFilterPayload();

  getSupporterByFilter() async {
    emit(state.copyWith(
      status: BlocStatus.loading,
    ));
    final result = await _repository.getSupporters(payload: payload);
    if (result.status) {
      emit(state.copyWith(
        status: BlocStatus.success,
        supporters: result.data,
      ));
    } else {
      emit(state.copyWith(
        status: BlocStatus.failure,
      ));
    }
  }
}
