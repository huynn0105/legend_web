import 'dart:convert';

import '../../utils/text_util.dart';

class DataWrapper {
  DataWrapper({
    this.id,
    this.value,
    this.index,
    this.parent,
  });

  String? id;
  String? value;
  int? index;
  DataWrapper? parent;

  DataWrapper.fromJson(dynamic json) {
    id = json["id"];
    value = json["value"];
    index = TextUtils.parseInt(json["index"]);
    parent = json["parent"] == null ? null : DataWrapper.fromJson(json["parent"]);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["value"] = value;
    if (index != null) {
      map["index"] = index;
    }
    if (parent != null) {
      map["parent"] = parent;
    }
    return map;
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

class GroupDataWrapper {
  GroupDataWrapper({
    this.group,
    this.children,
  });

  DataWrapper? group;
  List<DataWrapper>? children;
}
