import 'package:legend_mfast/models/base_model.dart';
import 'package:legend_mfast/models/user/user_info_model.dart';
import 'package:legend_mfast/services/api/api_provider.dart';

import '../../../models/user/otp_model.dart';
import '../../../models/user/referral_info_model.dart';
import '../../../models/user/user_meta_data_model.dart';
import '../../../services/api/user/payload/delete_account_payload.dart';
import '../../../services/api/user/payload/request_otp_payload.dart';
import '../../../services/api/user/payload/verify_otp_payload.dart';

class UserRepository {
  Future<BaseModel<UserInfoModel>> getUserInfo() {
    return ApiProvider.instance.user.getUserInfo();
  }

  Future<BaseModel<UserMetaDataModel>> getUserMetaData() {
    return ApiProvider.instance.user.getUserMetaData();
  }

  Future<BaseModel<ReferralInfoModel>> getReferralInfo() {
    return ApiProvider.instance.user.getReferralInfo();
  }

  Future<BaseModel<bool>> deleteAccount(DeleteAccountPayload payload) {
    return ApiProvider.instance.user.deleteAccount(payload);
  }

  Future<BaseModel<bool>> cancelDeleteAccount() {
    return ApiProvider.instance.user.cancelDeleteAccount();
  }

  Future<BaseModel<OtpModel>> requestOTP(RequestOtpPayload payload) {
    return ApiProvider.instance.user.requestOtp(payload);
  }

  Future<BaseModel<UserInfoModel>> verifyOtp(VerifyOtpPayload payload) {
    return ApiProvider.instance.user.verifyOtp(payload);
  }
}
