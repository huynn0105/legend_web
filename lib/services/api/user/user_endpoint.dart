import 'package:legend_mfast/services/api/user/payload/request_otp_payload.dart';
import 'package:legend_mfast/services/api/user/payload/verify_otp_payload.dart';

import '../../../app_data.dart';
import '../../base/base_endpoint.dart';
import '../../base/method_request.dart';
import 'payload/delete_account_payload.dart';

abstract class UserEndpointProtocol {
  EndpointType getUser();

  EndpointType getFirebaseUser({
    required String? accessToken,
  });

  EndpointType getUserMetaData();

  EndpointType getReferralInfo();

  EndpointType deleteAccount(DeleteAccountPayload payload);

  EndpointType cancelDeleteAccount();

  EndpointType requestOtp(
    RequestOtpPayload payload,
  );

  EndpointType verifyOtp(
    VerifyOtpPayload payload,
  );
}

class UserEndpoint implements UserEndpointProtocol {
  @override
  EndpointType getUser() {
    final endpoint = EndpointType(
      path: '/loginToken',
      httpMethod: HttpMethod.get,
      parameters: {
        'accessToken': AppData.instance.accessToken,
      },
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getFirebaseUser({required String? accessToken}) {
    final endpoint = EndpointType(
      path: "/loginToken",
      httpMethod: HttpMethod.get,
      parameters: {
        "accessToken": accessToken,
      },
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getUserMetaData() {
    final endpoint = EndpointType(
      path: '/mfast_api_v1/Personal/meta_data',
      httpMethod: HttpMethod.get,
      parameters: {},
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getReferralInfo() {
    final endpoint = EndpointType(
      path: '/app_api_v1/mfast/invite_ctv',
      httpMethod: HttpMethod.get,
      parameters: {},
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType deleteAccount(DeleteAccountPayload payload) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/Personal/account_delete_request",
      httpMethod: HttpMethod.post,
      parameters: payload.toJson(),
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType cancelDeleteAccount() {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/Personal/account_delete_cancel_request",
      httpMethod: HttpMethod.post,
      parameters: {},
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType requestOtp(RequestOtpPayload payload) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/authorization/otp",
      httpMethod: HttpMethod.get,
      parameters: payload.toJson(),
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType verifyOtp(VerifyOtpPayload payload) {
    final endpoint = EndpointType(
      path: "/loginExternal",
      httpMethod: HttpMethod.get,
      parameters: payload.toJson(),
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }
}
