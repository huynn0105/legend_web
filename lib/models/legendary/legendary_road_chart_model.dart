import 'package:legend_mfast/common/utils/text_util.dart';
import 'hier_rank_chart_model.dart';
import 'hier_rank_model.dart';

/// commission : 5401767
/// commissionInit : 733491
/// rank : {"ID":14,"userID":1240469574,"points":880.7,"level":{"ID":9,"level":"head","title":"Huyền Thoại","point":9999999999,"commGrade":7,"commRate":1,"teaser":"Trùm cuối.","image":"https://appay-rc.cloudcms.vn/assets/mfast-new_model/images/rank/huyenthoai.png"},"tmpPoints":2810.4,"tmpLevel":{"ID":6,"level":"VAR_RSM","title":"Bá chủ 1","point":2400,"commGrade":4,"commRate":3,"teaser":"Thành công là một hành trình, chứ không phải là một điểm đến.","image":"https://appay-rc.cloudcms.vn/assets/mfast-new_model/images/rank/bachu.png"},"createdDate":"2022-09-29 10:25:26","totalUserPoint":10,"growPoint":865.7,"tmpTotalUserPoint":16,"tmpGrowPoint":2786.4,"totalUserEKycPoint":5,"tmpTotalUserEKycPoint":8,"bonusUserInsPoint":0,"bonusUserNonInsPoint":14,"finAmtPoint":811.7,"insAmtPoint":0,"daaPoint":40,"mtradePoint":0,"bonusPoint":0,"tmpBonusUserInsPoint":0,"tmpBonusUserNonInsPoint":6,"tmpFinAmtPoint":415.4,"tmpInsAmtPoint":0,"tmpDaaPoint":76,"tmpMTradePoint":2289,"tmpBonusPoint":0,"userCreatedDate":"2020-03-18 15:58:50","point":880.7,"tmpPoint":2810.4,"nextLevel":{"ID":7,"level":"KPI_RSM","title":"Bá chủ 2","point":4800,"commGrade":5,"commRate":2,"teaser":"Thành công là một hành trình, chứ không phải là một điểm đến.","image":null}}
/// detail : {"earning_user":{"title":"Tân Thủ","background":"#f2f2f2","active":"#858598","ratioLine":[8],"amount":[]},"VAR_RSA":{"title":"Cao Thủ 1","background":"#fdecd8","active":"#f58b14","level":1,"ratioLine":[8],"amount":[]},"KPI_RSA":{"title":"Cao Thủ 2","background":"#fdecd8","active":"#f58b14","level":2,"ratioLine":[5,8],"amount":[]},"FIX_RSA":{"title":"Cao Thủ 3","background":"#fdecd8","active":"#f58b14","level":3,"ratioLine":[3,5,8],"amount":[]},"VAR_RSM":{"title":"Bá Chủ 1","background":"#eaeef6","active":"#005fff","level":4,"ratioLine":[3,3,5,8],"amount":[]},"KPI_RSM":{"title":"Bá Chủ 2","background":"#eaeef6","active":"#005fff","level":5,"ratioLine":[2,3,3,5,8],"amount":[]},"FIX_RSM":{"title":"Bá Chủ 3","background":"#eaeef6","active":"#005fff","level":6,"ratioLine":[2,2,3,3,5,8],"amount":[]},"head":{"title":"Huyền Thoại","background":"#ece4f1","active":"#6e418b","level":7,"ratioLine":[1,2,2,3,3,5,8],"amount":[0,0,0,343220,1180608,2516480,627968]}}
/// amountCollaborator : [6,4,43,4,2,0,0]
/// commtCollaborator : {"head":[627968,2516480,1180608,343220,0,0,0]}
/// url_post : "https://drive.google.com/file/d/18_y08vb4rsS_zg4k-VMdhntSjWci-jVD/view"
/// title : "Tìm hiểu về con đường huyền thoại"

class LegendaryRoadChartModel {
  LegendaryRoadChartModel({
    this.commission,
    this.commissionInit,
    this.rank,
    this.detail,
    this.amountCollaborator,
    this.commtCollaborator,
    this.urlPost,
    this.title,
  });

  LegendaryRoadChartModel.fromJson(dynamic json) {
    commission = TextUtils.parseDouble(json['commission']);
    commissionInit = TextUtils.parseDouble(json['commissionInit']);
    rank = json['rank'] != null ? HierRankModel.fromJson(json['rank']) : null;
    amountCollaborator = json['amountCollaborator'] != null ? json['amountCollaborator'].cast<int>() : [];
    urlPost = json['url_post'];
    title = json['title'];
    if (json['detail'] != null) {
      detail = {};
      json['detail'].forEach((key, value) {
        detail!.addAll({key: HierRankChartModel.fromJson(value)});
      });
    }
    if (json['commtCollaborator'] != null) {
      commtCollaborator = {};
      json['commtCollaborator'].forEach((key, value) {
        commtCollaborator!.addAll({key: value.cast<double>()});
      });
    }
  }

  double? commission;
  double? commissionInit;
  HierRankModel? rank;
  List<int>? amountCollaborator;
  String? urlPost;
  String? title;
  Map<String, HierRankChartModel>? detail;
  Map<String, List<double>>? commtCollaborator;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['commission'] = commission;
    map['commissionInit'] = commissionInit;
    if (rank != null) {
      map['rank'] = rank?.toJson();
    }
    if (detail != null) {
      map['detail'] = detail?.map((key, value) => MapEntry(key, value.toJson()));
    }
    map['amountCollaborator'] = amountCollaborator;
    if (commtCollaborator != null) {
      map['commtCollaborator'] = commtCollaborator;
    }
    map['url_post'] = urlPost;
    map['title'] = title;
    return map;
  }
}
