import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/features/legendary/repository/legendary_repository.dart';
import 'package:legend_mfast/models/base_model.dart';
import 'package:legend_mfast/services/api/legendary/payload/remove_collaborator_payload.dart';

part 'collaborator_remove_state.dart';

class CollaboratorRemoveCubit extends Cubit<CollaboratorRemoveState> {
  CollaboratorRemoveCubit() : super(const CollaboratorRemoveState());

  final _repository = LegendaryRepository();

  checkExistRemoveAction() async {
    if (state.statusCheckRemove.isInitial) {
      emit(state.copyWith(statusCheckRemove: BlocStatus.loading));
      BaseModel<String> result = await _repository.checkExistRemoveAction();
      if (result.status) {
        emit(state.copyWith(statusCheckRemove: BlocStatus.success, msgCheckRemove: result.errorMessage));
      } else {
        emit(state.copyWith(statusCheckRemove: BlocStatus.failure));
      }
    }
  }

  selectUser(String userId) {
    if (state.selectedUserId.contains(userId)) {
      emit(state.copyWith(selectedUserId: List.from(state.selectedUserId)..remove(userId)));
    } else {
      emit(state.copyWith(selectedUserId: List.from(state.selectedUserId)..add(userId)));
    }
  }

  selectAllUser() {
    emit(state.copyWith(selectedAll: !state.selectedAll, selectedUserId: []));
  }

  removeCollaborator() async {
    emit(state.copyWith(statusRemove: BlocStatus.loading));
    BaseModel<String> result = await _repository.removeCollaborator(RemoveCollaboratorPayload(
      all: state.selectedAll,
      collaborators: state.selectedUserId,
    ));
    if (result.status) {
      emit(state.copyWith(
        statusRemove: BlocStatus.success,
        msgRemove: result.errorMessage,
        removeType: result.data,
        selectedAll: false,
        selectedUserId: [],
      ));
    } else {
      emit(state.copyWith(statusRemove: BlocStatus.failure, msgRemove: result.errorMessage));
    }
  }
}
