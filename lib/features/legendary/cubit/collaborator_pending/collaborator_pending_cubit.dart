import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:legend_mfast/app_data.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/features/legendary/repository/legendary_repository.dart';
import 'package:legend_mfast/models/collaborator/collaborator_pending_model.dart';
import 'package:legend_mfast/services/api/legendary/payload/collaborators_pending_action_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/collaborators_pending_payload.dart';

part 'collaborator_pending_state.dart';

class CollaboratorPendingCubit extends Cubit<CollaboratorPendingState> {
  CollaboratorPendingCubit() : super(const CollaboratorPendingState());
  final _repository = LegendaryRepository();

  int _page = 1;

  getData({bool showLoading = true, bool loadmore = false}) async {
    if (showLoading) {
      emit(state.copyWith(
        status: BlocStatus.loading,
      ));
    }
    _updatePage(page: loadmore ? _page + 1 : 1);
    final payload = CollaboratorsPendingPayload(userID: AppData.instance.userID, page: _page);

    final result = await _repository.getCollaboratorPending(payload);
    if (result.status) {
      var data = result.data ?? [];
      if (loadmore) {
        data = [...state.data, ...data];
      }

      emit(state.copyWith(
        data: data,
        status: BlocStatus.success,
      ));
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
      final newData = List<CollaboratorPendingModel>.from(state.data);
      newData.removeWhere((x) => x.id == id);
      emit(state.copyWith(
        confirmStatus: BlocStatus.success,
        userPending: state.userPending - 1,
        data: newData,
        action: action,
      ));
    } else {
      emit(state.copyWith(
        confirmStatus: BlocStatus.failure,
      ));
    }
  }

  onRemoveItem(String? id){
    if(id == null) return;
    final index = state.data.indexWhere((x) => x.id == id);
    final data = List<CollaboratorPendingModel>.from(state.data);
    int userPending = state.userPending;
    if(index != - 1){
      data.removeAt(index);
      userPending--;
    }
    emit(state.copyWith(
      data: data,
      userPending: userPending,
    ));
  }

  updateUserPending(int userPending) {
    emit(state.copyWith(userPending: userPending));
  }

  refreshData() async {
    await getData(showLoading: false);
  }

  loadmoreData() async {
    final length = state.data.length;
    await getData(showLoading: false, loadmore: true);
    return length != state.data.length;
  }

  _updatePage({
    required int page,
  }) {
    _page = page;
  }
}
