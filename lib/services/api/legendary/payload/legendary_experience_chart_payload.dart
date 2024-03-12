import '../../../../common/constants.dart';

/// userID : "1240469574"
/// directSales : "allSales"
/// month : "2023-09"
/// productName : "all"
/// showAll : true

class LegendaryExperienceChartPayload {
  LegendaryExperienceChartPayload({
    this.userID,
    this.directSales = AppConstants.defaultDirectSale,
    this.month,
    this.productName = 'all',
    this.showAll = true,
  });

  String? userID;
  String? directSales;
  String? month;
  String? productName;
  bool? showAll;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userID'] = userID;
    map['directSales'] = directSales;
    map['month'] = month;
    map['productName'] = productName;
    map['showAll'] = showAll;
    return map;
  }

  LegendaryExperienceChartPayload copyWith({
    String? userID,
    String? directSales,
    String? month,
    String? productName,
    bool? showAll,
  }) {
    return LegendaryExperienceChartPayload(
      userID: userID ?? this.userID,
      directSales: directSales ?? this.directSales,
      month: month ?? this.month,
      productName: productName ?? this.productName,
      showAll: showAll ?? this.showAll,
    );
  }
}
