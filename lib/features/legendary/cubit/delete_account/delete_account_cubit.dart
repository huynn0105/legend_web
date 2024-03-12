import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/constants.dart';
import 'package:legend_mfast/common/enum/error_code_type.dart';

import '../../../../services/api/user/payload/delete_account_payload.dart';
import '../../../../services/api/user/payload/request_otp_payload.dart';
import '../../../user/repository/user_repository.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(const DeleteAccountState());
  final UserRepository _userRepository = UserRepository();

  final TextEditingController reasonController = TextEditingController();

  requestOTp({
    required String mobilePhone,
    bool? isRetry = false,
    String? type = 'voice',
  }) async {
    emit(state.copyWith(
      otpStatus: BlocStatus.loading,
      isVerifyOTP: true,
    ));

    final result = await _userRepository.requestOTP(RequestOtpPayload(
      mobilePhone: mobilePhone,
      isRetry: isRetry,
      type: type,
    ));
    if (result.status) {
      emit(state.copyWith(
        otpStatus: BlocStatus.success,
      ));
    } else {
      emit(state.copyWith(
        otpStatus: BlocStatus.failure,
      ));
    }
  }

  deleteAccount({required String otp}) async {
    emit(state.copyWith(
      status: BlocStatus.loading,
    ));

    final result = await _userRepository.deleteAccount(DeleteAccountPayload(
      otpCode: otp,
      reason: reasonController.text,
    ));

    if (result.status) {
      emit(state.copyWith(
        status: BlocStatus.success,
        isVerifyOTP: false,
      ));
    } else {
      if (result.errorCode == ErrorCodeType.wrongOtp.value) {
        final Map<String, String> errorFields = {};
        errorFields[AppConstants.otpKey] = result.errorMessage ?? '';
        emit(state.copyWith(
          errorFields: errorFields,
          otpStatus: BlocStatus.failure,
          status: BlocStatus.initial,
        ));
      } else {
        emit(state.copyWith(
          status: BlocStatus.failure,
          isVerifyOTP: false,
        ));
      }
    }
  }

  otpChange(String text) {
    emit(state.copyWith(
      status: BlocStatus.initial,
      errorFields: {},
    ));
  }

  cancelDeleteAccount() async {
    emit(state.copyWith(
      cancelStatus: BlocStatus.loading,
    ));
    final result = await _userRepository.cancelDeleteAccount();
    if (result.status) {
      emit(state.copyWith(
        cancelStatus: BlocStatus.success,
      ));
    } else {
      emit(state.copyWith(
        cancelStatus: BlocStatus.failure,
        errorMessage: result.errorMessage,
      ));
    }
  }
}
