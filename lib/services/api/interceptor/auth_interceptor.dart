import 'package:dio/dio.dart';

import '../../../common/utils/text_util.dart';

class AuthInterceptors extends Interceptor {
  AuthInterceptors({required this.onUnauthorized});

  final Function() onUnauthorized;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final json = (response.data is Map<String, dynamic>) ? response.data : TextUtils.decode(response.data.toString());
    final message = (json["message"]?.toString() ?? "").toLowerCase();
    final code = (json["errorCode"]?.toString() ?? json["error_code"]?.toString() ?? "").toString().toLowerCase();
    final unauthorized = [
      "đăng nhập",
      "invalid token",
    ];
    final errorCodes = [
      "login",
    ];
    if (errorCodes.any((e) => code.contains(e)) || unauthorized.any((e) => message.contains(e))) {
      onUnauthorized();
    }
    super.onResponse(response, handler);
  }
}
