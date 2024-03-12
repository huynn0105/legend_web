// ignore_for_file: prefer_interpolation_to_compose_strings, constant_identifier_names

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../env_config.dart';

class AppLog {
  ///use Log.v. Print all Logs
  static const int _VERBOSE = 2;

  ///use Log.d. Print Debug Logs
  static const int _DEBUG = 3;

  ///use Log.i. Print Info Logs
  static const int _INFO = 4;

  ///use Log.w. Print warning logs
  static const int _WARN = 5;

  ///use Log.e. Print error logs
  static const int _ERROR = 6;

  static _log(int priority, String tag, String message) {
    if (EnvConfig.instance.showLog) {
      if (kIsWeb) {
        debugPrint("${_getPriorityText(priority)}$tag: $message");
      } else {
        log("${_getPriorityText(priority)}$tag: $message");
      }
    }
  }

  static String _getPriorityText(int priority) {
    switch (priority) {
      case _INFO:
        return "INFO  💡 | ";
      case _DEBUG:
        return "DEBUG 🐛 | ";
      case _ERROR:
        return "ERROR ⛔ | ";
      case _WARN:
        return "WARN  ⚠️ | ";
      case _VERBOSE:
      default:
        return "";
    }
  }

  ///Print general logs
  static v(String tag, String message) {
    _log(_VERBOSE, tag, message);
  }

  ///Print info logs
  static i(String tag, String message) {
    _log(_INFO, tag, message);
  }

  ///Print debug logs
  static d(String tag, String message) {
    _log(_DEBUG, tag, message);
  }

  ///Print warning logs
  static w(String tag, String message) {
    _log(_WARN, tag, message);
  }

  ///Print error logs
  static e(String tag, String message) {
    _log(_ERROR, tag, message);
  }
}