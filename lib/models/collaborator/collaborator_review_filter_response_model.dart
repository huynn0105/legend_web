import '../../common/bottom_sheet/wrapper/data_wrapper.dart';
import '../../common/utils/text_util.dart';
import 'collaborator_supporter_model.dart';

class LegendaryReviewFilterResponseModel {
  List<DataWrapper>? skill;
  List<DataWrapper>? tab;
  List<DataWrapper>? titleRating;
  CollaboratorSupporterModel? supporter;
  double? avgRating;
  bool? hideSupporter;
  String? noteRatingUserHtml;

  LegendaryReviewFilterResponseModel({
    this.skill,
    this.tab,
    this.titleRating,
    this.supporter,
    this.avgRating,
    this.hideSupporter,
    this.noteRatingUserHtml,
  });

  LegendaryReviewFilterResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['skill'] is Map) {
      skill = (json['skill'] as Map).entries.map((e) => DataWrapper(id: e.key, value: e.value)).toList();
    }
    if (json['tab'] is Map) {
      tab = (json['tab'] as Map).entries.map((e) => DataWrapper(id: e.key, value: e.value)).toList();
    }
    if (json['titleRating'] is Map) {
      titleRating = (json['titleRating'] as Map).entries.map((e) => DataWrapper(id: e.key, value: e.value)).toList();
    }
    if (json['infoUserSp']['detail'] != null) {
      supporter = CollaboratorSupporterModel.fromJson(json['infoUserSp']['detail']);
    }
    avgRating = TextUtils.parseDouble(json['infoUserSp']['avgRating']);
    hideSupporter = json['infoUserSp']['hideFindUserSP'];
    noteRatingUserHtml = json['infoUserSp']['noteRatingUserHtml'];
  }
}
