import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:legend_mfast/models/general_object.dart';

class CollaboratorFilterModel {
  CollaboratorFilterModel({
    this.level,
    this.sort,
    this.work,
    this.tabs,
    this.page,
    this.userPending,
  });

  CollaboratorFilterModel.fromJson(dynamic json) {
    final Map<String, dynamic> levelMap = json['level'];
    level = levelMap.entries.map((e) => GeneralObject(code: e.key, name: e.value)).toList();

    final Map<String, dynamic> sortMap = json['sort'];
    sort = sortMap.entries.map((e) => GeneralObject(code: e.key, name: e.value)).toList();

    final Map<String, dynamic> workMap = json['work'];
    work = workMap.entries.map((e) => GeneralObject(code: e.key, name: e.value)).toList();

    final Map<String, dynamic> tabsMap = json['tabs'];
    tabs = tabsMap.entries.map((e) => GeneralObject(code: e.key, name: e.value)).toList();

    page = json['page'];
    userPending = TextUtils.parseInt(json['userPending']);
  }

  List<GeneralObject>? level;
  List<GeneralObject>? sort;
  List<GeneralObject>? work;
  List<GeneralObject>? tabs;
  int? page;
  int? userPending;
}
