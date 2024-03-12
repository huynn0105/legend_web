import 'collaborator_review_model.dart';
import 'mentor_rating_model.dart';

class LegendaryReviewResponseModel {
  double? avgRating;
  int? amountRating;
  RatingPercentModel? percent;
  List<LegendaryReviewModel>? list;

  LegendaryReviewResponseModel({this.avgRating, this.amountRating, this.percent, this.list});

  LegendaryReviewResponseModel.fromJson(Map<String, dynamic> json) {
    avgRating = json['avgRating'];
    amountRating = json['amountRating'];
    percent = json['percent'] != null ? RatingPercentModel.fromJson(json['percent']) : null;
    if (json['list'] != null) {
      list = <LegendaryReviewModel>[];
      json['list'].forEach((v) {
        list!.add(LegendaryReviewModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avgRating'] = avgRating;
    data['amountRating'] = amountRating;
    if (percent != null) {
      data['percent'] = percent!.toJson();
    }
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
