class BaseResponse {
  final bool? status;
  final String? socketEventType;
  final String? initByStep;
  final int? socketChunkLength;
  final int? socketChunkIndex;
  final String? errorTitle;
  final String? errorMessage;
  final String? errorCode;
  final String? uuid;
  final dynamic data;
  final dynamic raw;

  BaseResponse({
    this.status,
    this.errorTitle,
    this.errorMessage,
    this.socketEventType,
    this.initByStep,
    this.socketChunkLength,
    this.socketChunkIndex,
    this.errorCode,
    this.uuid,
    this.data,
    this.raw,
  });

  factory BaseResponse.fromJsonSuccess(Map<String, dynamic> json) {
    return BaseResponse(
      status: true,
      data: json["data"] ?? json,
      raw: json,
      errorCode: json["errorCode"] ?? json["error_code"],
      errorTitle: json["title"],
      errorMessage: json["message"] ?? json["error"],
    );
  }

  factory BaseResponse.fromJsonSocket(json) {
    return BaseResponse(
      status: json["status"],
      socketEventType: json["socketEventType"],
      initByStep: json["initByStep"],
      socketChunkLength: json["chunkLength"],
      socketChunkIndex: json["chunkIndex"],
      errorCode: json["errorCode"],
      errorTitle: json["title"],
      errorMessage: json["message"] ?? json["errorMsg"] ?? json["error"],
      data: json["data"] ?? json,
      uuid: json["uuid"],
    );
  }

  factory BaseResponse.fromJsonFail(Map<String, dynamic> json) {
    String? errorMessage;
    if (json["message"] is List) {
      errorMessage = (json["message"] as List).join('\n\n');
    } else {
      errorMessage = json["message"] ?? json["error"] ?? json["data"]?["err_msg"] as String?;
    }

    String? errorCode;
    try {
      errorCode = json["errorCode"] ?? json["error_code"] ?? json["data"]?["err_code"] as String?;
    } catch (error) {}

    return BaseResponse(
      status: false,
      errorTitle: json["title"] as String?,
      errorMessage: errorMessage,
      errorCode: errorCode,
      data: json["data"] ?? json,
    );
  }
}
