import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/utils/debounce_util.dart';
import 'package:legend_mfast/features/legendary/repository/legendary_repository.dart';
import 'package:legend_mfast/models/base_model.dart';
import 'package:legend_mfast/services/api/legendary/payload/get_rsm_list_collaborator_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/send_notification_to_collaborator_payload.dart';

import '../../../../common/enum/collaborator/collaborator_rsm_level.dart';
import '../../../../common/enum/collaborator/collaborator_rsm_status.dart';
import '../../../../common/enum/collaborator/collaborator_rsm_top.dart';
import '../../../../common/enum/notification/notification_type.dart';
import '../../../../di/get_it.dart';
import '../../../../models/collaborator/collaborator_list_rsm_push_model.dart';
import '../../../../models/collaborator/collaborator_rsm_push_model.dart';
import '../../../user/cubit/user/user_cubit.dart';

part 'rsm_push_user_state.dart';

class RSMPushUserCubit extends Cubit<RSMPushUserState> {
  RSMPushUserCubit() : super(const RSMPushUserState());

  final _repository = LegendaryRepository();
  RSMPushUserState? backupState;

  GetRsmListCollaboratorPayload _payload = GetRsmListCollaboratorPayload();

  DebounceUtil debounce = DebounceUtil(milliseconds: 300);

  init() {
    emit(state.copyWith(
      listCollaboratorRSMLevel: CollaboratorRSMLevel.values,
      listCollaboratorRSMStatus: CollaboratorRSMStatus.values,
      listCollaboratorRSMTop: CollaboratorRSMTop.values,
      selectedCollaboratorRSMLevel: CollaboratorRSMLevel.level1,
      selectedCollaboratorRSMStatus: CollaboratorRSMStatus.online,
      clearTop: true,
    ));
    _updatePayload(
      depth: state.selectedCollaboratorRSMLevel?.value,
      selectedCollaboratorRSMStatus: state.selectedCollaboratorRSMStatus,
      clearTop: true,
      // page: 1,
    );
  }

  Future<bool> getCollaborators({bool showLoading = true, bool loadMore = false}) async {
    if (showLoading) {
      emit(state.copyWith(status: BlocStatus.loading));
    }
    // _updatePayload(page: loadMore ? _payload.page + 1 : 1);
    BaseModel<CollaboratorListRsmPushModel> result = await _repository.getRSMListCollaborator(_payload);
    if (result.status) {
      final data = loadMore ? [...state.users, ...?result.data?.data] : result.data?.data;
      final total = result.data?.total ?? 0;
      emit(state.copyWith(
        status: BlocStatus.success,
        users: !loadMore && total == 0 ? [] : data,
        total: loadMore ? state.total : total,
      ));
      return state.users.length < total;
    } else if (!loadMore) {
      emit(state.copyWith(
        status: BlocStatus.failure,
        users: [],
        total: 0,
      ));
    }
    return false;
  }

  searchUser(String value) {
    emit(state.copyWith(searchStatus: BlocStatus.loading));
    debounce.run(() async {
      if (value.isEmpty) {
        clearSearch();
        return;
      }
      GetRsmListCollaboratorPayload payload = _payload.copyWithSearch(search: value);
      BaseModel<CollaboratorListRsmPushModel> result = await _repository.getRSMListCollaborator(payload);
      emit(state.copyWith(
        searchStatus: BlocStatus.success,
        searchUsers: result.data?.data,
      ));
    });
  }

  clearSearch() {
    emit(state.copyWith(
      status: BlocStatus.success,
      searchUsers: [],
    ));
  }

  _updatePayload({
    int? depth,
    CollaboratorRSMStatus? selectedCollaboratorRSMStatus,
    int? top,
    bool? clearTop,
    // int? page,
  }) {
    if (selectedCollaboratorRSMStatus == null) {
      _payload = _payload.copyWith(
        depth: depth,
        top: top,
        clearTop: clearTop,
        // page: page,
      );
      return;
    }
    _payload = _payload.copyWith(
      depth: depth,
      ctvType: selectedCollaboratorRSMStatus == CollaboratorRSMStatus.online ? 'active' : '',
      hasComm: selectedCollaboratorRSMStatus == CollaboratorRSMStatus.gvmExist ? 1 : 0,
      isPl: selectedCollaboratorRSMStatus == CollaboratorRSMStatus.plGvmExist ? 1 : 0,
      isIns: selectedCollaboratorRSMStatus == CollaboratorRSMStatus.insGvmExist ? 1 : 0,
      isDaa: selectedCollaboratorRSMStatus == CollaboratorRSMStatus.daaGvmExist ? 1 : 0,
      top: top,
      clearTop: clearTop,
      // page: page,
    );
  }

  selectCollaboratorRSMLevel(CollaboratorRSMLevel value) {
    if (value != state.selectedCollaboratorRSMLevel) {
      _updatePayload(depth: value.value);
      emit(state.copyWith(
        selectedCollaboratorRSMLevel: value,
      ));
    }
  }

  selectCollaboratorRSMStatus(CollaboratorRSMStatus value) {
    if (value != state.selectedCollaboratorRSMStatus) {
      _updatePayload(selectedCollaboratorRSMStatus: value);
      emit(state.copyWith(
        selectedCollaboratorRSMStatus: value,
      ));
    }
  }

  selectCollaboratorRSMTop(CollaboratorRSMTop value) {
    if (value != state.selectedCollaboratorRSMTop) {
      _updatePayload(top: value.value);
      emit(state.copyWith(
        selectedCollaboratorRSMTop: value,
      ));
    } else {
      _updatePayload(clearTop: true);
      emit(state.copyWith(clearTop: true));
    }
  }

  saveBackupState() {
    backupState = state.copyWith();
  }

  cancelFilter() {
    if (backupState != null) {
      emit(backupState!);
    }
  }

  resetFilter() {
    init();
  }

  applyFilter() {
    getCollaborators();
  }

  refreshData() async {
    await getCollaborators(showLoading: false);
  }

  loadMoreData() async {
    return await getCollaborators(showLoading: false, loadMore: true);
  }

  removeUser(CollaboratorRsmPushModel? user) {
    List<CollaboratorRsmPushModel> addedUsers = List.from(state.addedUsers);
    List<CollaboratorRsmPushModel> removedUsers = List.from(state.removedUsers);
    addedUsers.removeWhere((element) => element.id == user?.id);
    if (!removedUsers.map((element) => element.id).contains(user?.id)) {
      removedUsers.add(user!);
    }
    emit(state.copyWith(addedUsers: addedUsers, removedUsers: removedUsers));
  }

  addUser(CollaboratorRsmPushModel? user) {
    List<CollaboratorRsmPushModel> addedUsers = List.from(state.addedUsers);
    List<CollaboratorRsmPushModel> removedUsers = List.from(state.removedUsers);
    removedUsers.removeWhere((element) => element.id == user?.id);
    if (!addedUsers.map((element) => element.id).contains(user?.id)) {
      addedUsers.add(user!);
    }
    emit(state.copyWith(addedUsers: addedUsers, removedUsers: removedUsers));
  }

  sendRsmNotification(String msg) async {
    emit(state.copyWith(sendPushStatus: BlocStatus.loading));
    final List<CollaboratorRsmPushModel> displayUser = List.from(state.users);
    displayUser.addAll(state.addedUsers);
    displayUser.removeWhere((element) => state.removedUsers.map((e) => e.id).contains(element.id));
    final user = getItInstance.get<UserCubit>().state.userInfo;
    BaseModel<bool> result = await _repository.sendNotificationToCollaborator(SendNotificationToCollaboratorPayload(
      userIDs: displayUser.map((e) => e.id ?? '').toList(),
      data: NotificationData(
        notification: NotificationMetaData(
          title: 'Thông báo từ RSM ${user?.fullName ?? ''}',
          body: msg,
          sound: 'default',
        ),
        data: ParamData(
          type: NotificationType.chatMessage.name,
          category: 'admin',
          filterCondition: FilterCondition(
            typeRSM: state.selectedCollaboratorRSMLevel?.value.toString(),
            statusRSM: state.selectedCollaboratorRSMStatus?.value,
            topRSM: state.selectedCollaboratorRSMTop?.name.toString() ?? '0',
          ),
          extraData: ExtraData(
            title: 'Thông báo từ RSM ${user?.fullName ?? ''}',
            body: msg,
            screenTitle: '',
            url: '',
            imgUrl: '',
            tags: '',
            user: user,
          ),
        ),
      )
    ));
    if (result.status) {
      emit(state.copyWith(sendPushStatus: BlocStatus.success));
    } else {
      emit(state.copyWith(sendPushStatus: BlocStatus.failure, errMsg: state.errMsg));
    }
  }

  @override
  Future<void> close() {
    debounce.cancel();
    return super.close();
  }
}
