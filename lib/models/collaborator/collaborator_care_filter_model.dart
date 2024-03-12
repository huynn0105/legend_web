import 'package:legend_mfast/models/general_object.dart';

class CollaboratorCareFilterModel {
  CollaboratorCareFilterModel({
    this.grade,
    this.level,
  });

  CollaboratorCareFilterModel.fromJson(dynamic json) {
    if (json['grade'] != null) {
      grade = [];
      json['grade'].forEach((v) {
        grade?.add(GeneralObject(
          code: v['level'].toString(),
          name: v['title'],
        ));
      });
    }
    if (json['level'] != null) {
      level = [];
      json['level'].forEach((v) {
        level?.add(GeneralObject(
          code: v['level'],
          name: v['title'],
        ));
      });
    }
  }

  List<GeneralObject>? grade;
  List<GeneralObject>? level;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (grade != null) {
      map['grade'] = grade?.map((v) => v.toJson()).toList();
    }
    if (level != null) {
      map['level'] = level?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
