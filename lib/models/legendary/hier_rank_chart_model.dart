import 'package:legend_mfast/common/utils/text_util.dart';

/// earning_user : {"title":"Tân Thủ","background":"#f2f2f2","active":"#858598","ratioLine":[8],"amount":[]}
/// VAR_RSA : {"title":"Cao Thủ 1","background":"#fdecd8","active":"#f58b14","level":1,"ratioLine":[8],"amount":[]}
/// KPI_RSA : {"title":"Cao Thủ 2","background":"#fdecd8","active":"#f58b14","level":2,"ratioLine":[5,8],"amount":[]}
/// FIX_RSA : {"title":"Cao Thủ 3","background":"#fdecd8","active":"#f58b14","level":3,"ratioLine":[3,5,8],"amount":[]}
/// VAR_RSM : {"title":"Bá Chủ 1","background":"#eaeef6","active":"#005fff","level":4,"ratioLine":[3,3,5,8],"amount":[]}
/// KPI_RSM : {"title":"Bá Chủ 2","background":"#eaeef6","active":"#005fff","level":5,"ratioLine":[2,3,3,5,8],"amount":[]}
/// FIX_RSM : {"title":"Bá Chủ 3","background":"#eaeef6","active":"#005fff","level":6,"ratioLine":[2,2,3,3,5,8],"amount":[]}
/// head : {"title":"Huyền Thoại","background":"#ece4f1","active":"#6e418b","level":7,"ratioLine":[1,2,2,3,3,5,8],"amount":[0,0,0,343220,1180608,2516480,627968]}

/// title : "Huyền Thoại"
/// background : "#ece4f1"
/// active : "#6e418b"
/// level : 7
/// ratioLine : [1,2,2,3,3,5,8]
/// amount : [0,0,0,343220,1180608,2516480,627968]

class HierRankChartModel {
  HierRankChartModel({
    this.title,
    this.background,
    this.activeColor,
    this.level,
    this.ratioLine,
    this.amount,
  });

  HierRankChartModel.fromJson(dynamic json) {
    title = json['title'];
    background = json['background'];
    activeColor = json['active'];
    level = TextUtils.parseInt(json['level']);
    ratioLine = json['ratioLine'] != null
        ? json['ratioLine'].map((e) => TextUtils.parseDouble(e) ?? 0).toList().cast<double>()
        : [];
    amount =
        json['amount'] != null ? json['amount'].map((e) => TextUtils.parseDouble(e) ?? 0).toList().cast<double>() : [];
  }

  String? title;
  String? background;
  String? activeColor;
  int? level;
  List<double>? ratioLine;
  List<double>? amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['background'] = background;
    map['active'] = activeColor;
    map['level'] = level;
    map['ratioLine'] = ratioLine;
    map['amount'] = amount;
    return map;
  }
}
