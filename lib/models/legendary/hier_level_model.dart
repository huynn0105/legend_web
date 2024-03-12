import 'package:legend_mfast/common/utils/text_util.dart';
import 'hier_rank_format_model.dart';

/// ID : 9
/// level : "head"
/// title : "Huyền Thoại"
/// point : 0
/// commGrade : 0
/// commRate : 1
/// teaser : "Trùm cuối."
/// image : "https://appay-rc.cloudcms.vn/assets/mfast-new_model/images/rank/huyenthoai.png"

class HierLevelModel {
  HierLevelModel({
    this.id,
    this.level,
    this.title,
    this.point,
    this.commGrade,
    this.commRate,
    this.teaser,
    this.image,
  });

  HierLevelModel.fromJson(dynamic json) {
    id = json['ID'];
    level = json['level'];
    title = json['title'];
    point = TextUtils.parseInt(json['point']);
    commGrade = json['commGrade'];
    commRate = json['commRate'];
    teaser = json['teaser'];
    image = json['image'];
  }

  num? id;
  String? level;
  String? title;
  int? point;
  num? commGrade;
  num? commRate;
  String? teaser;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['level'] = level;
    map['title'] = title;
    map['point'] = point;
    map['commGrade'] = commGrade;
    map['commRate'] = commRate;
    map['teaser'] = teaser;
    map['image'] = image;
    return map;
  }

  HierRankFormatModel? getFormatRank() {
    String image = this.image ?? '';
    String star = '';
    String level = '';

    title?.splitMapJoin(
      RegExp('[0-9]'),
      onMatch: (Match match) {
        star = match[0] ?? '';
        return '';
      },
      onNonMatch: (String text) {
        level += text;
        return '';
      },
    );

    return HierRankFormatModel(
      logo: image.trim(),
      level: level.trim(),
      star: star.trim(),
      point: point,
    );
  }
}
