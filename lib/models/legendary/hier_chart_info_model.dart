import 'package:legend_mfast/common/utils/text_util.dart';

/// prevSalesPoint : 5116
/// name : "Tài chính"
/// salesPoint : 968
/// currentGrowth : 4.9
/// salesGrowth : 81.1
/// statusGrowth : "down"
/// background : "#005fff"
/// url : ""

class HierChartInfoModel {
  HierChartInfoModel({
    this.prevSalesPoint,
    this.name,
    this.salesPoint,
    this.currentGrowth,
    this.salesGrowth,
    this.statusGrowth,
    this.background,
    this.url,
    this.wallet,
  });

  HierChartInfoModel.fromJson(dynamic json) {
    prevSalesPoint = json['prevSalesPoint'];
    name = json['name'];
    salesPoint = json['salesPoint'];
    currentGrowth = TextUtils.parseDouble(json['currentGrowth']);
    salesGrowth = TextUtils.parseDouble(json['salesGrowth']);
    statusGrowth = json['statusGrowth'];
    background = json['background'];
    url = json['url'];
    wallet = TextUtils.parseDouble(json['wallet']);
  }

  int? prevSalesPoint;
  String? name;
  int? salesPoint;
  double? currentGrowth;
  double? salesGrowth;
  String? statusGrowth;
  String? background;
  String? url;
  double? wallet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['prevSalesPoint'] = prevSalesPoint;
    map['name'] = name;
    map['salesPoint'] = salesPoint;
    map['currentGrowth'] = currentGrowth;
    map['salesGrowth'] = salesGrowth;
    map['statusGrowth'] = statusGrowth;
    map['background'] = background;
    map['url'] = url;
    map['wallet'] = wallet;
    return map;
  }
}
