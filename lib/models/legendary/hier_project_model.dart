import 'package:legend_mfast/common/utils/text_util.dart';

/// product_type : "DAA"
/// type_name : "Mở ví điện tử, ngân hàng"
/// background : "#ff499c"
/// num_of_type : "0"
/// previous_month_num_of_type : "0"
/// percentage : null
/// percent_growth : 0

class HierProjectModel {
  HierProjectModel({
    this.productType,
    this.typeName,
    this.background,
    this.numOfType,
    this.previousMonthNumOfType,
    this.percentage,
    this.percentGrowth,
  });

  HierProjectModel.fromJson(dynamic json) {
    productType = json['product_type'];
    typeName = json['type_name'];
    background = json['background'];
    numOfType = TextUtils.parseInt(json['num_of_type']);
    previousMonthNumOfType = TextUtils.parseInt(json['previous_month_num_of_type']);
    percentage = TextUtils.parseDouble(json['percentage']);
    percentGrowth = TextUtils.parseDouble(json['percent_growth']);
  }

  String? productType;
  String? typeName;
  String? background;
  int? numOfType;
  int? previousMonthNumOfType;
  double? percentage;
  double? percentGrowth;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_type'] = productType;
    map['type_name'] = typeName;
    map['background'] = background;
    map['num_of_type'] = numOfType;
    map['previous_month_num_of_type'] = previousMonthNumOfType;
    map['percentage'] = percentage;
    map['percent_growth'] = percentGrowth;
    return map;
  }
}
