import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../../app_data.dart';
import '../../common/utils/log_util.dart';
import '../../common/utils/text_util.dart';
import '../../di/get_it.dart';
import '../../env_config.dart';
import '../../features/app_cubit.dart';
import '../base/base_endpoint.dart';
import '../base/base_response.dart';
import '../base/method_request.dart';
import 'interceptor/auth_interceptor.dart';
import 'interceptor/convert_interceptor.dart';

abstract class APIServiceProtocol {
  Future<BaseResponse> requestData(EndpointType endpoint);

  Future<BaseResponse> uploadMultiFile(MultiFileEndpointType endpoint);

  void forceLogin() {
    getItInstance.get<AppCubit>().forceLogin();
  }
}

class APIService extends APIServiceProtocol {
  final _tag = "APIService";

  APIService._();

  static final APIService instance = APIService._();

  Dio? dio;

  Dio init() {
    if (dio == null) {
      dio = Dio();
      // dio!.options.connectTimeout = 25000;
      // dio!.options.receiveTimeout = 25000;
      dio!.options.baseUrl = EnvConfig.instance.baseUrl;
      dio!.interceptors.addAll(
        [
          ConvertInterceptors(),
          AuthInterceptors(
            onUnauthorized: () {
              forceLogin();
            },
          ),
        ],
      );
    }
    return dio!;
  }

  @override
  Future<BaseResponse> requestData(EndpointType endpoint) async {
    Dio dio = init();

    final header = <String, dynamic>{};

    // TODO: Temp ignored
    // header['Authorization'] = EnvConfig.instance.mplToken;

    if (TextUtils.isNotEmpty(AppData.instance.accessToken)) {
      endpoint.parameters?['accessToken'] = AppData.instance.accessToken;
    }
    endpoint.parameters = {
      ...?endpoint.parameters,
      ...EnvConfig.instance.defaultParam.toJsonWithoutToken(),
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
          queryParameters: EnvConfig.instance.defaultParam.toJson(),
          options: Options(
            headers: header,
            contentType: Headers.jsonContentType,
            method: endpoint.httpMethod!.getValue(),
            sendTimeout: const Duration(seconds: 60),
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
        AppLog.d(_tag, 'response: ${error is DioException ? error.response?.statusMessage : error.toString()}');
        AppLog.d(_tag, "----------------------end-error-response-------------------");
        return BaseResponse(
          status: false,
        );
      }
    }
    final json = (response.data is Map<String, dynamic>) ? response.data : TextUtils.decode(response.data.toString());
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
      if (json['status'] == true) {
        return BaseResponse.fromJsonSuccess(json);
      } else {
        return BaseResponse.fromJsonFail(json);
      }
    }
    return BaseResponse(
      status: false,
    );
  }

  @override
  Future<BaseResponse> uploadMultiFile(
    MultiFileEndpointType endpoint, {
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) async {
    Dio dio = init();

    if (TextUtils.isNotEmpty(AppData.instance.accessToken)) {
      endpoint.parameters?['accessToken'] = AppData.instance.accessToken;
    }
    endpoint.parameters = {
      ...?endpoint.parameters,
      ...EnvConfig.instance.defaultParam.toJsonWithoutToken(),
    };

    final files = await Future.wait(endpoint.files.map(
      (e) async {
        final now = DateTime.now().microsecondsSinceEpoch; // millisecondsSinceEpoch: duplicated
        final mimeType = e.mimeType;
        final byte = await e.readAsBytes();
        return MultipartFile.fromBytes(
          byte,
          filename: "file_$now.${_getFileExtension(e.name)}",
          contentType: TextUtils.isEmpty(mimeType) ? null : MediaType.parse(mimeType!),
        );

        // return MultipartFile.fromFile(
        //   e.path,
        //   filename: "file_$now.${_getFileExtension(e.path)}",
        //   contentType: mimeType.isEmpty ? null : MediaType.parse(mimeType),
        // );
      },
    ));
    FormData formData = FormData.fromMap({
      'files[]': files,
      ...?endpoint.parameters,
    });

    // FormData formData = FormData();
    // for (File e in endpoint.files) {
    //   final now = DateTime.now().microsecondsSinceEpoch;
    //   formData.files.add(
    //     MapEntry(
    //       "files[]",
    //       await MultipartFile.fromFile(
    //         e.path,
    //         filename: "file_$now.${_getFileExtension(e.path)}",
    //       ),
    //     ),
    //   );
    // }
    // for (var e in (endpoint.parameters?.entries.toList() ?? [])) {
    //   formData.fields.add(MapEntry(e.key, e.value));
    // }

    final header = <String, dynamic>{};

    try {
      Response response = await dio.post(
        endpoint.path!,
        options: Options(headers: header),
        data: formData,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      );

      final json = (response.data is Map<String, dynamic>) ? response.data : TextUtils.decode(response.data.toString());

      AppLog.d(_tag, "----------------------start-response-------------------");
      AppLog.d(_tag, 'method: ${endpoint.httpMethod?.getValue()}');
      AppLog.d(_tag, 'path: ${endpoint.path}');
      AppLog.d(_tag, 'param: ${jsonEncode(endpoint.parameters)}');
      AppLog.d(_tag, 'response: ${jsonEncode(json)}');
      AppLog.d(_tag, "----------------------end-response-------------------");

      if (json != null && json is Map<String, dynamic>) {
        if (json['status'] == true) {
          return BaseResponse.fromJsonSuccess(json);
        } else {
          return BaseResponse.fromJsonFail(json);
        }
      }
      return BaseResponse(
        status: false,
        errorMessage: "Không thể kết nối tới hệ thống!",
      );
    } catch (e) {
      AppLog.d(_tag, "----------------------start-error-response-------------------");
      AppLog.d(_tag, 'method: ${endpoint.httpMethod?.getValue()}');
      AppLog.d(_tag, 'path: ${endpoint.path}');
      AppLog.d(_tag, 'param: ${jsonEncode(endpoint.parameters)}');
      AppLog.d(_tag, 'response: ${e is DioException ? e.message : e.toString()}');
      AppLog.d(_tag, "----------------------end-error-response-------------------");
      return BaseResponse(
        status: false,
        errorMessage: "Không thể kết nối tới hệ thống!",
      );
    }
  }

  String _getFileExtension(String fileName) {
    try {
      return fileName.split('.').last.toLowerCase();
    } catch (e) {
      return '';
    }
  }

  @override
  Future<BaseResponse> requestOldData(EndpointType endpoint) async {
    Dio dio = init();
    final header = <String, dynamic>{};

    header['Authorization'] =
    'Basic ${base64Encode(utf8.encode('${EnvConfig.instance.apiUserName}:${EnvConfig.instance.apiPassword}'))}';

    // String accessToken = LocalDataHelper.instance.getUser()?.accessToken ?? '';
    // if (accessToken.isNotEmpty) {
    //   endpoint.parameters?['accessToken'] = accessToken;
    // }
    if (TextUtils.isNotEmpty(AppData.instance.accessToken)) {
      endpoint.parameters?['accessToken'] = AppData.instance.accessToken;
    }
    endpoint.parameters = {
      ...?endpoint.parameters,
      if (!endpoint.ignoredDefaultParams) ...EnvConfig.instance.defaultParam.toJsonWithoutToken(),
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
          queryParameters: EnvConfig.instance.defaultParam.toJson(),
          options: Options(
            headers: header,
            contentType: Headers.jsonContentType,
            method: endpoint.httpMethod!.getValue(),
            sendTimeout: const Duration(seconds: 60),
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
        AppLog.d(_tag, 'response: ${error is DioException ? error.response?.statusMessage : error.toString()}');
        AppLog.d(_tag, "----------------------end-error-response-------------------");
        return BaseResponse(
          status: false,
        );
      }
    }
    final json = response.data;
    AppLog.d(_tag, "----------------------start-response-------------------");
    if (endpoint.httpMethod == HttpMethod.get) {
      AppLog.d(_tag, 'uri: ${response.realUri}');
    }
    AppLog.d(_tag, 'method: ${endpoint.httpMethod?.getValue()}');
    AppLog.d(_tag, 'path: ${endpoint.path}');
    AppLog.d(_tag, 'param: ${jsonEncode(endpoint.parameters)}');
    AppLog.d(_tag, 'response: ${jsonEncode(json)}');
    AppLog.d(_tag, "----------------------end-response-------------------");
    if (json != null && response.statusCode == 200) {
      return BaseResponse(
        status: true,
        data: json,
      );
    }
    return BaseResponse(
      status: false,
      errorMessage: response.statusMessage,
    );
  }
}
