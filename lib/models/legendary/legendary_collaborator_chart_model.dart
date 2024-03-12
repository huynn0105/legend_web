import '../../common/utils/text_util.dart';
import 'hier_collaborator_model.dart';
import 'legendary_experience_chart_model.dart';

/// title : "Cộng tác viên (CTV) của bạn"
/// url_post : []
/// collaborator : 64
/// raito : 7.8
/// collaborators : {"data":{"name":"CTV có doanh số","ratio":7.8,"wallet":5,"salesGrowth":100,"statusGrowth":"up","collaboratorList":[{"name":"Tầng 1","salesGrowth":100,"currentGrowth":40,"wallet":2,"statusGrowth":"up","background":"#005fff"},{"name":"Tầng 2","salesGrowth":100,"currentGrowth":20,"wallet":1,"statusGrowth":"up","background":"#dc41d7"},{"name":"Tầng 3","salesGrowth":100,"currentGrowth":40,"wallet":2,"statusGrowth":"up","background":"#ff499c"},{"name":"Tầng 4","salesGrowth":0,"currentGrowth":0,"wallet":0,"statusGrowth":"","background":"#ff8469"},{"name":"Tầng 5","salesGrowth":0,"currentGrowth":0,"wallet":0,"statusGrowth":"","background":"#ffc252"},{"name":"Tầng 6","salesGrowth":0,"currentGrowth":0,"wallet":0,"statusGrowth":"","background":"#f9f871"}]}}
/// filter : [{"id":"all","title":"Tất cả"},{"id":"Financial","title":"Tài chính"},{"id":"Insurance","title":"Bảo hiểm"},{"id":"BANK","title":"Mở ví/ngân hàng"},{"id":"MTrade","title":"Bán hàng trả chậm"}]
/// filter_level : [{"id":"6","title":"6 tầng"},{"id":"all","title":"Tất cả tầng"}]
/// filter_type : [{"id":"sales","title":"Có doanh số"},{"id":"working","title":"Có hoạt động"}]

class LegendaryCollaboratorChartModel {
  LegendaryCollaboratorChartModel({
    this.title,
    this.urlPost,
    this.collaborator,
    this.ratio,
    this.collaborators,
    this.filter,
    this.filterLevel,
    this.filterType,
    this.isNotHead,
    this.imgHead,
  });

  LegendaryCollaboratorChartModel.fromJson(dynamic json) {
    title = json['title'];
    if (json['url_post'] != null) {
      urlPost = [];
      json['url_post'].forEach((v) {
        urlPost?.add(HierUrlPostModel.fromJson(v));
      });
    }
    collaborator = TextUtils.parseInt(json['collaborator']);
    ratio = TextUtils.parseDouble(json['raito']);
    collaborators = json['collaborators'] != null ? HierCollaboratorModel.fromJson(json['collaborators']) : null;
    if (json['filter'] != null) {
      filter = [];
      json['filter'].forEach((v) {
        filter?.add(HierFilterModel.fromJson(v));
      });
    }
    if (json['filter_level'] != null) {
      filterLevel = [];
      json['filter_level'].forEach((v) {
        filterLevel?.add(HierFilterModel.fromJson(v));
      });
    }
    if (json['filter_type'] != null) {
      filterType = [];
      json['filter_type'].forEach((v) {
        filterType?.add(HierFilterModel.fromJson(v));
      });
    }
    isNotHead = json['is_not_head'];
    imgHead = json['img_head'];

    ///
    // isNotHead = "Rất tiếc, chỉ danh hiệu Huyền Thoại mới được xem thống kê của tất cả các tầng Cộng tác viên bên dưới.";
    // imgHead = "https://appay-rc.cloudcms.vn/assets/mfast-new_model/images/rank/huyenthoai.png";
  }

  String? title;
  List<HierUrlPostModel>? urlPost;
  int? collaborator;
  double? ratio;
  HierCollaboratorModel? collaborators;
  List<HierFilterModel>? filter;
  List<HierFilterModel>? filterLevel;
  List<HierFilterModel>? filterType;
  String? isNotHead;
  String? imgHead;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    if (urlPost != null) {
      map['url_post'] = urlPost?.map((v) => v.toJson()).toList();
    }
    map['collaborator'] = collaborator;
    map['raito'] = ratio;
    if (collaborators != null) {
      map['collaborators'] = collaborators?.toJson();
    }
    if (filter != null) {
      map['filter'] = filter?.map((v) => v.toJson()).toList();
    }
    if (filterLevel != null) {
      map['filter_level'] = filterLevel?.map((v) => v.toJson()).toList();
    }
    if (filterType != null) {
      map['filter_type'] = filterType?.map((v) => v.toJson()).toList();
    }
    map['is_not_head'] = isNotHead;
    map['img_head'] = imgHead;
    return map;
  }
}
