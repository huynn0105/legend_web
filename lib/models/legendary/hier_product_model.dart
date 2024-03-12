import 'package:legend_mfast/common/utils/text_util.dart';
import 'hier_chart_info_model.dart';

/// name : "Tổng thu nhập"
/// salesGrowth : 54
/// wallet : 2484136
/// statusGrowth : "down"
/// productsList : [{"name":"Tài chính","salesGrowth":58,"currentGrowth":46,"wallet":1154784,"statusGrowth":"down","background":"#005fff"},{"name":"Bảo hiểm","salesGrowth":100,"currentGrowth":0,"wallet":0,"statusGrowth":"down","background":"#dc41d7"},{"name":"Mở ví/ngân hàng","salesGrowth":84,"currentGrowth":7,"wallet":182800,"statusGrowth":"down","background":"#ff499c"},{"name":"Bán hàng trả chậm","salesGrowth":7066,"currentGrowth":46,"wallet":1146552,"statusGrowth":"up","background":"#221DB0"}]

class HierProductModel {
  HierProductModel({
    this.name,
    this.salesGrowth,
    this.wallet,
    this.statusGrowth,
    this.productsList,
  });

  HierProductModel.fromJson(dynamic json) {
    name = json['name'];
    salesGrowth = TextUtils.parseDouble(json['salesGrowth']);
    wallet = TextUtils.parseDouble(json['wallet']);
    statusGrowth = json['statusGrowth'];
    if (json['productsList'] != null) {
      productsList = [];
      json['productsList'].forEach((v) {
        productsList?.add(HierChartInfoModel.fromJson(v));
      });
    }
  }

  String? name;
  double? salesGrowth;
  double? wallet;
  String? statusGrowth;
  List<HierChartInfoModel>? productsList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['salesGrowth'] = salesGrowth;
    map['wallet'] = wallet;
    map['statusGrowth'] = statusGrowth;
    if (productsList != null) {
      map['productsList'] = productsList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
