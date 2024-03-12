import '../../../../common/constants.dart';

/// userID : "1240469574"
/// directSales : "allSales"
/// month : "2023-09"

class LegendaryIncomeChartPayload {
  LegendaryIncomeChartPayload({
    this.userID,
    this.directSales = AppConstants.defaultDirectSale,
    this.month,
  });

  LegendaryIncomeChartPayload.fromJson(dynamic json) {
    userID = json['userID'];
    directSales = json['directSales'];
    month = json['month'];
  }

  String? userID;
  String? directSales;
  String? month;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userID'] = userID;
    map['directSales'] = directSales;
    map['month'] = month;
    return map;
  }

  LegendaryIncomeChartPayload copyWith({
    String? userID,
    String? directSales,
    String? month,
  }) {
    return LegendaryIncomeChartPayload(
      userID: userID ?? this.userID,
      directSales: directSales ?? this.directSales,
      month: month ?? this.month,
    );
  }
}
