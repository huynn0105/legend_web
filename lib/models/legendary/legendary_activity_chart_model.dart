import 'hier_project_model.dart';
import 'legendary_experience_chart_model.dart';

/// total : {"product_type":"total","type_name":"Tổng hồ sơ khách hàng","num_of_type":"0","previous_month_num_of_type":"0","percentage":null,"percent_growth":0}
/// list : [{"product_type":"DAA","type_name":"Mở ví điện tử, ngân hàng","background":"#ff499c","num_of_type":"0","previous_month_num_of_type":"0","percentage":null,"percent_growth":0},{"product_type":"ins","type_name":"Bảo hiểm","background":"#dc41d7","num_of_type":"0","previous_month_num_of_type":"0","percentage":null,"percent_growth":0},{"product_type":"MTrade","type_name":"Mua hàng trả chậm","background":"#ffc252","num_of_type":"0","previous_month_num_of_type":"0","percentage":null,"percent_growth":0},{"product_type":"other","type_name":"Dự án khác","background":"#ff8469","num_of_type":"0","previous_month_num_of_type":"0","percentage":null,"percent_growth":0},{"product_type":"pl","type_name":"Tài chính","background":"#005fff","num_of_type":"0","previous_month_num_of_type":"0","percentage":null,"percent_growth":0}]
/// title : "Hoạt động của bạn"
/// filter : [{"id":"all","title":"Tất cả"},{"id":"pl","title":"Tài chính"},{"id":"ins","title":"Bảo hiểm"},{"id":"DAA","title":"Mở ví/ngân hàng"},{"id":"mtrade","title":"Bán hàng trả chậm"},{"id":"other","title":"Dự án khác"}]

class LegendaryActivityChartModel {
  LegendaryActivityChartModel({
    this.total,
    this.list,
    this.title,
    this.filter,
  });

  LegendaryActivityChartModel.fromJson(dynamic json) {
    total = json['total'] != null ? HierProjectModel.fromJson(json['total']) : null;
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(HierProjectModel.fromJson(v));
      });
    }
    title = json['title'];
    if (json['filter'] != null) {
      filter = [];
      json['filter'].forEach((v) {
        filter?.add(HierFilterModel.fromJson(v));
      });
    }
  }

  HierProjectModel? total;
  List<HierProjectModel>? list;
  String? title;
  List<HierFilterModel>? filter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (total != null) {
      map['total'] = total?.toJson();
    }
    if (list != null) {
      map['list'] = list?.map((v) => v.toJson()).toList();
    }
    map['title'] = title;
    if (filter != null) {
      map['filter'] = filter?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
