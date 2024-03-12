import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jwt_decode/jwt_decode.dart';

import 'package:legend_mfast/app_data.dart';
import 'package:legend_mfast/common/utils/log_util.dart';
import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:legend_mfast/env_config.dart';
import 'package:legend_mfast/services/api/interceptor/auth_interceptor.dart';
import 'package:legend_mfast/services/api/interceptor/convert_interceptor.dart';
import 'package:legend_mfast/services/base/base_endpoint.dart';
import 'package:legend_mfast/services/base/base_response.dart';
import 'package:legend_mfast/services/base/method_request.dart';

abstract class FirebaseFunctionAPIServiceProtocol {
  Future<BaseResponse> requestData(EndpointType endpoint);
}

class FirebaseFunctionAPIService extends FirebaseFunctionAPIServiceProtocol {
  final _tag = "FirebaseFunctionAPIService";

  FirebaseFunctionAPIService._();

  static final FirebaseFunctionAPIService instance = FirebaseFunctionAPIService._();

  Dio? dio;

  Dio init() {
    if (dio == null) {
      dio = Dio();
      // dio!.options.connectTimeout = 25000;
      // dio!.options.receiveTimeout = 25000;
      dio!.options.baseUrl = EnvConfig.instance.firebaseFunctionUrl;
      dio!.interceptors.addAll([
        ConvertInterceptors(),
        AuthInterceptors(
          onUnauthorized: () {},
        ),
      ]);
    }
    return dio!;
  }

  @override
  Future<BaseResponse> requestData(EndpointType endpoint) async {
    Dio dio = init();

    final header = <String, dynamic>{};

    header['Authorization'] =
    'Basic ${base64Encode(utf8.encode('${EnvConfig.instance.apiUserName}:${EnvConfig.instance.apiPassword}'))}';

    // if (AppData.instance.accessToken.isNotEmpty) {
    //   endpoint.parameters?['accessToken'] = AppData.instance.accessToken;
    // }

    if (TextUtils.isEmpty(AppData .instance.firebaseAuthToken) || checkExpiredToken(AppData.instance.firebaseAuthToken)) {
      AppData.instance.firebaseAuthToken = await FirebaseAuth.instance.currentUser?.getIdToken(true) ?? '';
    }
    endpoint.parameters?['fbToken'] = AppData.instance.firebaseAuthToken;

    endpoint.parameters = {
      ...?endpoint.parameters,
      // ...AppData.instance.defaultParam.toJsonWithoutToken(),
    };

    Response response;
    if (endpoint.httpMethod == HttpMethod.get) {
      try {
        response = await dio.request(
          endpoint.path!,
          queryParameters: endpoint.parameters,
          options: Options(
            headers: header,
            contentType: Headers.jsonContentType,
            method: endpoint.httpMethod!.getValue(),
            listFormat: endpoint.listFormat,
            validateStatus: (status) {
              if (status == null) {
                return false;
              }
              return status < 500;
            },
          ),
        );
      } catch (error) {
        AppLog.d(_tag, "----------------------start-error-response-------------------");
        AppLog.d(_tag, 'method: ${endpoint.httpMethod?.getValue()}');
        AppLog.d(_tag, 'path: ${endpoint.path}');
        AppLog.d(_tag, 'param: ${jsonEncode(endpoint.parameters)}');
        AppLog.d(_tag, 'response: $error');
        AppLog.d(_tag, "----------------------end-error-response-------------------");
        return BaseResponse(
          status: false,
        );
      }
    } else {
      try {
        response = await dio.request(
          endpoint.path!,
          data: endpoint.parameters,
          options: Options(
            headers: header,
            contentType: Headers.jsonContentType,
            method: endpoint.httpMethod!.getValue(),
            listFormat: endpoint.listFormat,
            sendTimeout: const Duration(milliseconds: 60000),
            validateStatus: (status) {
              if (status == null) {
                return false;
              }
              return status < 500;
            },
          ),
        );
      } catch (error) {
        AppLog.d(_tag, "----------------------start-error-response-------------------");
        AppLog.d(_tag, 'method: ${endpoint.httpMethod?.getValue()}');
        AppLog.d(_tag, 'path: ${endpoint.path}');
        AppLog.d(_tag, 'param: ${jsonEncode(endpoint.parameters)}');
        AppLog.d(_tag, 'response: $error');
        AppLog.d(_tag, "----------------------end-error-response-------------------");
        return BaseResponse(
          status: false,
        );
      }
    }

    final json = (response.data is Map<String, dynamic>) ? response.data : TextUtils.decode((response.data ?? "").toString());

    AppLog.d(_tag, "----------------------start-response-------------------");
    if (endpoint.httpMethod == HttpMethod.get) {
      AppLog.d(_tag, 'uri: ${response.realUri}');
    }
    AppLog.d(_tag, 'method: ${endpoint.httpMethod?.getValue()}');
    AppLog.d(_tag, 'path: ${endpoint.path}');
    AppLog.d(_tag, 'param: ${jsonEncode(endpoint.parameters)}');
    AppLog.d(_tag, 'response: ${jsonEncode(json)}');
    AppLog.d(_tag, "----------------------end-response-------------------");
    if (json != null && json is Map<String, dynamic>) {
      if (json['status'] == true || json['message'] == 'success' || json['data'] != null) {
        return BaseResponse.fromJsonSuccess(json);
      } else {
        return BaseResponse.fromJsonFail(json);
      }
    }
    return BaseResponse(
      status: false,
    );
  }

  checkExpiredToken(String? token) {
    if (token != null) {
      var tokenDecoded = Jwt.parseJwt(token);
      int exp = tokenDecoded['exp'];
      if (DateTime.now().millisecondsSinceEpoch > exp * 1000) {
        return true;
      }
      return false;
    }
  }
}
