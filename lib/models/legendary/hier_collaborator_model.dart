import 'package:legend_mfast/common/utils/text_util.dart';
import 'hier_chart_info_model.dart';

/// data : {"name":"CTV có doanh số","ratio":7.8,"wallet":5,"salesGrowth":100,"statusGrowth":"up","collaboratorList":[{"name":"Tầng 1","salesGrowth":100,"currentGrowth":40,"wallet":2,"statusGrowth":"up","background":"#005fff"},{"name":"Tầng 2","salesGrowth":100,"currentGrowth":20,"wallet":1,"statusGrowth":"up","background":"#dc41d7"},{"name":"Tầng 3","salesGrowth":100,"currentGrowth":40,"wallet":2,"statusGrowth":"up","background":"#ff499c"},{"name":"Tầng 4","salesGrowth":0,"currentGrowth":0,"wallet":0,"statusGrowth":"","background":"#ff8469"},{"name":"Tầng 5","salesGrowth":0,"currentGrowth":0,"wallet":0,"statusGrowth":"","background":"#ffc252"},{"name":"Tầng 6","salesGrowth":0,"currentGrowth":0,"wallet":0,"statusGrowth":"","background":"#f9f871"}]}

class HierCollaboratorModel {
  HierCollaboratorModel({
    this.data,
  });

  HierCollaboratorModel.fromJson(dynamic json) {
    data = json['data'] != null ? HierCollaboratorDataModel.fromJson(json['data']) : null;
  }

  HierCollaboratorDataModel? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// name : "CTV có doanh số"
/// ratio : 7.8
/// wallet : 5
/// salesGrowth : 100
/// statusGrowth : "up"
/// collaboratorList : [{"name":"Tầng 1","salesGrowth":100,"currentGrowth":40,"wallet":2,"statusGrowth":"up","background":"#005fff"},{"name":"Tầng 2","salesGrowth":100,"currentGrowth":20,"wallet":1,"statusGrowth":"up","background":"#dc41d7"},{"name":"Tầng 3","salesGrowth":100,"currentGrowth":40,"wallet":2,"statusGrowth":"up","background":"#ff499c"},{"name":"Tầng 4","salesGrowth":0,"currentGrowth":0,"wallet":0,"statusGrowth":"","background":"#ff8469"},{"name":"Tầng 5","salesGrowth":0,"currentGrowth":0,"wallet":0,"statusGrowth":"","background":"#ffc252"},{"name":"Tầng 6","salesGrowth":0,"currentGrowth":0,"wallet":0,"statusGrowth":"","background":"#f9f871"}]

class HierCollaboratorDataModel {
  HierCollaboratorDataModel({
    this.name,
    this.ratio,
    this.wallet,
    this.salesGrowth,
    this.statusGrowth,
    this.collaboratorList,
  });

  HierCollaboratorDataModel.fromJson(dynamic json) {
    name = json['name'];
    ratio = TextUtils.parseDouble(json['ratio']);
    wallet = TextUtils.parseDouble(json['wallet']);
    salesGrowth = TextUtils.parseDouble(json['salesGrowth']);
    statusGrowth = json['statusGrowth'];
    if (json['collaboratorList'] != null) {
      collaboratorList = [];
      json['collaboratorList'].forEach((v) {
        collaboratorList?.add(HierChartInfoModel.fromJson(v));
      });
    }
  }

  String? name;
  double? ratio;
  double? wallet;
  double? salesGrowth;
  String? statusGrowth;
  List<HierChartInfoModel>? collaboratorList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['ratio'] = ratio;
    map['wallet'] = wallet;
    map['salesGrowth'] = salesGrowth;
    map['statusGrowth'] = statusGrowth;
    if (collaboratorList != null) {
      map['collaboratorList'] = collaboratorList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
