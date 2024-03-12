import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/bottom_sheet/wrapper/data_wrapper.dart';
import 'package:legend_mfast/common/constants.dart';
import 'package:legend_mfast/features/legendary/repository/legendary_repository.dart';
import 'package:legend_mfast/models/collaborator/collaborator_new_supporter_model.dart';

import '../../../../models/collaborator/collaborator_my_supporter_waiting_model.dart';

part 'new_supporter_state.dart';

class NewSupporterCubit extends Cubit<NewSupporterState> {
  NewSupporterCubit() : super(const NewSupporterState());

  final _repository = LegendaryRepository();

  initCubit(MySupporterWaitingModel? data) {
    emit(state.copyWith(
      group: (AppConstants.defaultSkillFilters.toList()..shuffle()).first, // Default random option
      supporterWaiting: data,
    ));
  }

  Future<void> getSupporterWaiting() async {
    final result = await _repository.getMySupporterWaiting();
    if (result.status) {
      emit(state.copyWith(
        supporterWaiting: result.data!,
      ));
    }
  }

  getProvinces() async {
    final result = await _repository.getProvinces();
    if (result.status) {
      emit(state.copyWith(
        provinces: result.data,
      ));
    }
  }

  getDistricts({required String provinceID}) async {
    final result = await _repository.getDistricts(provinceID: provinceID);
    if (result.status) {
      emit(state.copyWith(
        districts: result.data,
      ));
    }
  }

  changeText({required String data}) async {
    emit(state.copyWith(
      text: data,
      supporterSelect: LegendaryNewSupporterModel(),
    ));
  }

  selectGroup({required DataWrapper data}) async {
    emit(state.copyWith(
      group: data,
      supporterSelect: LegendaryNewSupporterModel(),
    ));
  }

  selectProvince({required DataWrapper data}) async {
    getDistricts(provinceID: data.id ?? "");
    emit(state.copyWith(
      province: data,
      district: DataWrapper(),
      supporterSelect: LegendaryNewSupporterModel(),
    ));
  }

  selectDistrict({required DataWrapper data}) async {
    emit(state.copyWith(
      district: data,
      supporterSelect: LegendaryNewSupporterModel(),
    ));
  }

  selectSupporter({required LegendaryNewSupporterModel data}) {
    if (data == state.supporterSelect) {
      emit(state.copyWith(
        supporterSelect: LegendaryNewSupporterModel(),
      ));
    } else {
      emit(state.copyWith(
        supporterSelect: data,
      ));
    }
  }

  changeSupporter({
    required String toUserID,
    String? note,
  }) async {
    emit(state.copyWith(
      changeStatus: BlocStatus.loading,
    ));

    final result = await _repository.changeSupporter(toUserID: toUserID, note: note);

    if (result.status) {
      emit(state.copyWith(
        changeStatus: BlocStatus.success,
      ));
    } else {
      emit(state.copyWith(
        changeStatus: BlocStatus.failure,
        changeErrorMessage: result.errorMessage,
      ));
    }
  }

  selectSupporterWaiting({required MySupporterWaitingModel? data}) {
    emit(state.copyWith(
      supporterWaiting: data,
    ));
  }
}
