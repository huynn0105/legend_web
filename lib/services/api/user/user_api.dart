import 'package:legend_mfast/common/extension/list_extension.dart';
import 'package:legend_mfast/models/base_model.dart';
import 'package:legend_mfast/services/api/user/user_endpoint.dart';
import 'package:legend_mfast/services/base/base_response.dart';

import '../../../models/user/firebase_user_model.dart';
import '../../../models/user/otp_model.dart';
import '../../../models/user/referral_info_model.dart';
import '../../../models/user/user_info_model.dart';
import '../../../models/user/user_meta_data_model.dart';
import '../api_service.dart';
import '../firebase_function_api_service.dart';
import 'payload/delete_account_payload.dart';
import 'payload/request_otp_payload.dart';
import 'payload/verify_otp_payload.dart';

abstract class UserApi {
  Future<BaseModel<UserInfoModel>> getUserInfo();

  Future<BaseModel<FirebaseUserModel>> getFirebaseUser({
    required String? accessToken,
  });

  Future<BaseModel<UserMetaDataModel>> getUserMetaData();

  Future<BaseModel<ReferralInfoModel>> getReferralInfo();

  Future<BaseModel<bool>> deleteAccount(DeleteAccountPayload payload);

  Future<BaseModel<bool>> cancelDeleteAccount();

  Future<BaseModel<OtpModel>> requestOtp(RequestOtpPayload payload);

  Future<BaseModel<UserInfoModel>> verifyOtp(VerifyOtpPayload payload);
}

class UserApiImpl implements UserApi {
  @override
  Future<BaseModel<UserInfoModel>> getUserInfo() async {
    BaseResponse apiResponse = await FirebaseFunctionAPIService.instance.requestData(
      UserEndpoint().getUser(),
    );

    if (apiResponse.status == true) {
      return BaseModel<UserInfoModel>(
        status: true,
        data: UserInfoModel.fromJson(apiResponse.data, raw: apiResponse.raw),
      );
    } else {
      return BaseModel<UserInfoModel>(
        status: false,
        errorCode: apiResponse.errorCode,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<FirebaseUserModel>> getFirebaseUser({
    required String? accessToken,
  }) async {
    BaseResponse apiResponse = await FirebaseFunctionAPIService.instance.requestData(
      UserEndpoint().getFirebaseUser(accessToken: accessToken),
    );
    if (apiResponse.status == true) {
      return BaseModel<FirebaseUserModel>(
        status: true,
        data: FirebaseUserModel.fromJson(apiResponse.data, apiResponse.raw),
      );
    } else {
      return BaseModel<FirebaseUserModel>(
        status: false,
        errorCode: apiResponse.errorCode,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<UserMetaDataModel>> getUserMetaData() async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      UserEndpoint().getUserMetaData(),
    );

    if (apiResponse.status == true) {
      return BaseModel<UserMetaDataModel>(
        status: true,
        data: UserMetaDataModel.fromJson(apiResponse.data),
      );
    } else {
      return BaseModel<UserMetaDataModel>(
        status: false,
        errorCode: apiResponse.errorCode,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<ReferralInfoModel>> getReferralInfo() async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      UserEndpoint().getReferralInfo(),
    );

    if (apiResponse.status == true) {
      return BaseModel<ReferralInfoModel>(
        status: true,
        data: ReferralInfoModel.fromJson(apiResponse.data),
      );
    } else {
      return BaseModel<ReferralInfoModel>(
        status: false,
        errorCode: apiResponse.errorCode,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<bool>> deleteAccount(DeleteAccountPayload payload) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      UserEndpoint().deleteAccount(payload),
    );
    if (apiResponse.status == true) {
      return BaseModel<bool>(
        status: true,
      );
    } else {
      return BaseModel<bool>(
        status: false,
        errorCode: apiResponse.errorCode,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<bool>> cancelDeleteAccount() async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      UserEndpoint().cancelDeleteAccount(),
    );
    if (apiResponse.status == true) {
      return BaseModel<bool>(
        status: true,
      );
    } else {
      return BaseModel<bool>(
        status: false,
        errorCode: apiResponse.errorCode,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<OtpModel>> requestOtp(RequestOtpPayload payload) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      UserEndpoint().requestOtp(payload),
    );
    if (apiResponse.status == true) {
      return BaseModel<OtpModel>(
        status: true,
        data: OtpModel.fromJson(apiResponse.data),
      );
    } else {
      return BaseModel<OtpModel>(
        status: false,
        errorCode: apiResponse.errorCode,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<UserInfoModel>> verifyOtp(VerifyOtpPayload payload) async {
    BaseResponse apiResponse = await FirebaseFunctionAPIService.instance.requestData(
      UserEndpoint().verifyOtp(payload),
    );
    if (apiResponse.status == true) {
      final data = apiResponse.data as List?;
      return BaseModel<UserInfoModel>(status: true, data: UserInfoModel.fromJson(data?.getFirst()));
    } else {
      return BaseModel<UserInfoModel>(
        status: false,
        errorCode: apiResponse.errorCode,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }
}
