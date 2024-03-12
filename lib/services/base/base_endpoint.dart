import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../base/method_request.dart';

class EndpointType {
  EndpointType({
    this.path,
    this.socketEvent = '',
    this.httpMethod,
    this.parameters,
    this.header = const {},
    this.ignoredDefaultParams = false,
    this.listFormat,
  });

  String? path;
  String socketEvent;
  HttpMethod? httpMethod;
  Map<String, dynamic>? parameters;
  Map<String, String> header;
  bool ignoredDefaultParams;
  ListFormat? listFormat;
}

class MultiFileEndpointType extends EndpointType {
  MultiFileEndpointType({
    required super.path,
    required this.files,
    super.parameters,
    super.httpMethod,
    super.socketEvent = '',
    super.header = const {},
  });

  List<XFile> files;
}

class FileEndpointType {
  FileEndpointType({
    required this.file,
    this.path,
  });

  String? path;
  XFile file;
  Map<String, dynamic>? parameters;
}

class DefaultHeader {
  DefaultHeader._();

  static final DefaultHeader instance = DefaultHeader._();

  Map<String, String> addDefaultHeader() {
    Map<String, String> header = <String, String>{};
    header["Content-Type"] = "application/json";
    header["mobile-app"] = "mfast";
    return header;
  }
}
