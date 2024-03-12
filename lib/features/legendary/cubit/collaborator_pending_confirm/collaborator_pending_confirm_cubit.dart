import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/features/legendary/repository/legendary_repository.dart';
import 'package:legend_mfast/models/collaborator/collaborator_pending_detail_model.dart';
import 'package:legend_mfast/services/api/legendary/payload/collaborators_pending_action_payload.dart';

part 'collaborator_pending_confirm_state.dart';

class CollaboratorPendingConfirmCubit extends Cubit<CollaboratorPendingConfirmState> {
  CollaboratorPendingConfirmCubit() : super(const CollaboratorPendingConfirmState());
  final _repository = LegendaryRepository();

  getData(String id) async {
    emit(state.copyWith(
      status: BlocStatus.loading,
    ));

    final result = await _repository.getDetailCollaboratorPending(id);
    if (result.status) {
      if (result.data?.isNotEmpty == true) {
        emit(state.copyWith(
          status: BlocStatus.success,
          collaborator: result.data!.first,
        ));
      } else {
        emit(state.copyWith(
          status: BlocStatus.failure,
          errorMessage: 'Yêu cầu đã được duyệt hoặc đã bị thu hồi',
        ));
      }
    } else {
      emit(state.copyWith(
        status: BlocStatus.failure,
        errorMessage: result.errorMessage,
      ));
    }
  }

  confirmCollaboratorPending(String id, CollaboratorPendingAction action) async {
    emit(state.copyWith(
      confirmStatus: BlocStatus.loading,
    ));
    final payload = CollaboratorsPendingActionPayload(
      id: id,
      action: action.name,
    );
    final result = await _repository.confirmCollaboratorPending(payload);
    if (result.status) {
      emit(state.copyWith(
        confirmStatus: BlocStatus.success,
        action: action,
      ));
    } else {
      emit(state.copyWith(
        confirmStatus: BlocStatus.failure,
      ));
    }
  }
}
