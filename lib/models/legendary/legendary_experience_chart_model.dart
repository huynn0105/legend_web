import 'hier_rank_model.dart';
import 'hier_sale_model.dart';

/// sales : {"allSales":{"salesList":[{"prevSalesPoint":5116,"name":"Tài chính","salesPoint":968,"currentGrowth":4.9,"salesGrowth":81.1,"statusGrowth":"down","background":"#005fff","url":""},{"prevSalesPoint":28099,"name":"Bảo hiểm","salesPoint":18466,"currentGrowth":93.6,"salesGrowth":34.3,"statusGrowth":"down","background":"#dc41d7","url":""},{"prevSalesPoint":110,"name":"Mở ví/ngân hàng","salesPoint":212,"currentGrowth":1.1,"salesGrowth":92.7,"statusGrowth":"up","background":"#ff499c","url":""},{"name":"Cộng tác viên","salesPoint":10,"prevSalesPoint":10,"currentGrowth":0.1,"salesGrowth":0,"statusGrowth":"","background":"#ff8469","url":""},{"name":"Định danh","salesPoint":5,"prevSalesPoint":5,"currentGrowth":0,"salesGrowth":0,"statusGrowth":"","background":"#ffc252","url":""},{"prevSalesPoint":20,"name":"CTV phát sinh tài chính","salesPoint":10,"currentGrowth":0.1,"salesGrowth":50,"statusGrowth":"down","background":"#ffc277","url":""},{"prevSalesPoint":25,"name":"CTV phát sinh bảo hiểm","salesPoint":25,"currentGrowth":0.1,"salesGrowth":0,"statusGrowth":"","background":"#ffb552","url":""},{"prevSalesPoint":88,"name":"Bán hàng trả chậm","salesPoint":29,"currentGrowth":0.1,"salesGrowth":67,"statusGrowth":"down","background":"#221DB0","url":""},{"name":"Vinh danh","salesPoint":0,"prevSalesPoint":0,"currentGrowth":0,"salesGrowth":0,"statusGrowth":"","background":"#6e418b","url":""}],"directSales":164,"indirectSales":19561}}
/// title : "Kinh nghiệm của bạn"
/// rank : {"ID":14,"userID":1240469574,"points":880.7,"level":{"ID":9,"level":"head","title":"Huyền Thoại","point":0,"commGrade":0,"commRate":1,"teaser":"Trùm cuối.","image":"https://appay-rc.cloudcms.vn/assets/mfast-new_model/images/rank/huyenthoai.png"},"tmpPoints":2532,"tmpLevel":{"ID":6,"level":"head","title":"Huyền Thoại","point":0,"commGrade":4,"commRate":3,"teaser":"Thành công là một hành trình, chứ không phải là một điểm đến.","image":"https://appay-rc.cloudcms.vn/assets/mfast-new_model/images/rank/huyenthoai.png"},"createdDate":"2022-09-29 10:25:26","totalUserPoint":10,"growPoint":865.7,"tmpTotalUserPoint":10,"tmpGrowPoint":2517,"totalUserEKycPoint":5,"tmpTotalUserEKycPoint":5,"bonusUserInsPoint":0,"bonusUserNonInsPoint":14,"finAmtPoint":811.7,"insAmtPoint":0,"daaPoint":40,"mtradePoint":0,"bonusPoint":0,"tmpBonusUserInsPoint":0,"tmpBonusUserNonInsPoint":4,"tmpFinAmtPoint":180,"tmpInsAmtPoint":0,"tmpDaaPoint":44,"tmpMTradePoint":2289,"tmpBonusPoint":0,"userCreatedDate":"2020-03-18 15:58:50","point":880.7,"tmpPoint":2532,"nextLevel":{"ID":7,"level":"KPI_RSM","title":"Bá chủ 2","point":4800,"commGrade":5,"commRate":2,"teaser":"Thành công là một hành trình, chứ không phải là một điểm đến.","image":null}}
/// url_post : [{"url":"https://drive.google.com/file/d/1JGP0O9H_MkiRALxpC752ak5WCU0GKKSO/view?usp=sharing","title":"Làm sao để là Huyền Thoại bền vững"}]
/// note : [[{"text":"Kinh nghiệm bán hàng","color":"#00cc94","bold":true},{"text":": là điểm kinh nghiệm bạn tích luỹ được khi trực tiếp bán hàng.","color":"#6b6b81"}],[{"text":"Kinh nghiệm dẫn dắt","color":"#f58b14","bold":true},{"text":": là điểm kinh nghiệm bạn tích luỹ được từ nhánh cộng đồng bên dưới của bạn.","color":"#6b6b81"}]]
/// filter : [{"id":"allSales","title":"Tất cả"},{"id":"directSales","title":"Bán hàng"},{"id":"indirectSales","title":"Dẫn dắt"}]
/// allRank : {"user":1,"earning_user":2,"VAR_RSA":3,"KPI_RSA":4,"FIX_RSA":5,"VAR_RSM":6,"KPI_RSM":7,"FIX_RSM":8,"head":9}

class LegendaryExperienceChartModel {
  LegendaryExperienceChartModel({
    this.sales,
    this.title,
    this.rank,
    this.urlPost,
    this.note,
    this.filter,
    this.allRank,
    this.detail,
  });

  LegendaryExperienceChartModel.fromChartJson(dynamic json, {String? keyword}) {
    sales = json['sales'] != null ? HierSaleModel.fromJson(json['sales']?[keyword]) : null;

    ///
    title = json['title'];
    rank = json['rank'] != null ? HierRankModel.fromJson(json['rank']) : null;
    if (json['url_post'] != null) {
      urlPost = [];
      json['url_post'].forEach((v) {
        urlPost?.add(HierUrlPostModel.fromJson(v));
      });
    }
    if (json['note'] != null) {
      note = [];
      json['note'].forEach((v) {
        var insideList = <HierNoteModel>[];
        if (v is List) {
          for (var v in v) {
            insideList.add(HierNoteModel.fromJson(v));
          }
          note?.add(insideList);
        }
      });
    }
    if (json['filter'] != null) {
      filter = [];
      json['filter'].forEach((v) {
        filter?.add(HierFilterModel.fromJson(v));
      });
    }
    allRank = json['allRank'] != null ? HierAllRankModel.fromJson(json['allRank']) : null;
    if (json['detail'] != null) {
      detail = [];
      json['detail'].forEach((v) {
        var insideList = <HierNoteModel>[];
        if (v is List) {
          for (var v in v) {
            insideList.add(HierNoteModel.fromJson(v));
          }
          detail?.add(insideList);
        }
      });
    }
  }

  HierSaleModel? sales;
  String? title;
  HierRankModel? rank;
  List<HierUrlPostModel>? urlPost;
  List<List<HierNoteModel>>? note;
  List<HierFilterModel>? filter;
  HierAllRankModel? allRank;
  List<List<HierNoteModel>>? detail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (sales != null) {
      map['sales'] = sales?.toJson();
    }
    map['title'] = title;
    if (rank != null) {
      map['rank'] = rank?.toJson();
    }
    if (urlPost != null) {
      map['url_post'] = urlPost?.map((v) => v.toJson()).toList();
    }
    if (note != null) {
      map['note'] = note?.map((v) => v.map((e) => e.toJson()).toList()).toList();
    }
    if (filter != null) {
      map['filter'] = filter?.map((v) => v.toJson()).toList();
    }
    if (allRank != null) {
      map['allRank'] = allRank?.toJson();
    }
    if (detail != null) {
      map['detail'] = detail?.map((v) => v.map((e) => e.toJson()).toList()).toList();
    }
    return map;
  }

  void mapFromJson(dynamic json) {}
}

/// user : 1
/// earning_user : 2
/// VAR_RSA : 3
/// KPI_RSA : 4
/// FIX_RSA : 5
/// VAR_RSM : 6
/// KPI_RSM : 7
/// FIX_RSM : 8
/// head : 9

class HierAllRankModel {
  HierAllRankModel({
    this.user,
    this.earningUser,
    this.varrsa,
    this.kpirsa,
    this.fixrsa,
    this.varrsm,
    this.kpirsm,
    this.fixrsm,
    this.head,
  });

  HierAllRankModel.fromJson(dynamic json) {
    user = json['user'];
    earningUser = json['earning_user'];
    varrsa = json['VAR_RSA'];
    kpirsa = json['KPI_RSA'];
    fixrsa = json['FIX_RSA'];
    varrsm = json['VAR_RSM'];
    kpirsm = json['KPI_RSM'];
    fixrsm = json['FIX_RSM'];
    head = json['head'];
  }

  int? user;
  int? earningUser;
  int? varrsa;
  int? kpirsa;
  int? fixrsa;
  int? varrsm;
  int? kpirsm;
  int? fixrsm;
  int? head;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = user;
    map['earning_user'] = earningUser;
    map['VAR_RSA'] = varrsa;
    map['KPI_RSA'] = kpirsa;
    map['FIX_RSA'] = fixrsa;
    map['VAR_RSM'] = varrsm;
    map['KPI_RSM'] = kpirsm;
    map['FIX_RSM'] = fixrsm;
    map['head'] = head;
    return map;
  }
}

/// id : "allSales"
/// title : "Tất cả"

class HierFilterModel {
  HierFilterModel({
    this.id,
    this.title,
  });

  HierFilterModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
  }

  String? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }
}

/// text : "Kinh nghiệm bán hàng"
/// color : "#00cc94"
/// bold : true

class HierNoteModel {
  HierNoteModel({
    this.text,
    this.color,
    this.bold,
    this.url,
  });

  HierNoteModel.fromJson(dynamic json) {
    text = json['text']?.toString();
    color = json['color'];
    bold = json['bold'];
    url = json['url'];
  }

  String? text;
  String? color;
  bool? bold;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['color'] = color;
    map['bold'] = bold;
    map['url'] = url;
    return map;
  }
}

/// url : "https://drive.google.com/file/d/1JGP0O9H_MkiRALxpC752ak5WCU0GKKSO/view?usp=sharing"
/// title : "Làm sao để là Huyền Thoại bền vững"

class HierUrlPostModel {
  HierUrlPostModel({
    this.url,
    this.title,
  });

  HierUrlPostModel.fromJson(dynamic json) {
    url = json['url'];
    title = json['title'];
  }

  String? url;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['title'] = title;
    return map;
  }
}
