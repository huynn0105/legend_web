
import 'collaborator_rsm_push_model.dart';

class CollaboratorListRsmPushModel {
  CollaboratorListRsmPushModel({
    this.total,
    this.data,
  });

  CollaboratorListRsmPushModel.fromJson(dynamic json) {
    total = json['total'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CollaboratorRsmPushModel.fromJson(v));
      });
    }
  }

  int? total;
  List<CollaboratorRsmPushModel>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}