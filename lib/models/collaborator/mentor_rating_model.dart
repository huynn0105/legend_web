import '../../common/utils/text_util.dart';

/// avgRating : 5
/// amountRating : 2
/// percent : {"star_1":0,"star_2":0,"star_3":0,"star_4":0,"star_5":100}
/// list : [{"ID":47,"userID":2049610346,"comment":"Very good!","rating":5,"toUserID":1240469574,"skill":"lead","createdDate":"2022-12-06 15:26:55","fullName":"HaiBA2","title":"Rất hài lòng, chủ động hỗ trợ"},{"ID":45,"userID":2049603346,"comment":"Quá tuyệt. Quản lý có tâm","rating":5,"toUserID":1240469574,"skill":"lead","createdDate":"2022-10-11 15:57:57","fullName":"BiiVo","title":"Rất hài lòng, chủ động hỗ trợ"}]

class MentorRatingModel {
  MentorRatingModel({
    this.avgRating,
    this.amountRating,
    this.percent,
    this.ratingUser,
  });

  MentorRatingModel.fromJson(dynamic json) {
    avgRating = double.tryParse(json["avgRating"].toString());
    amountRating = json["amountRating"];
    percent = json['percent'] != null ? RatingPercentModel.fromJson(json['percent']) : null;
    if (json['list'] != null) {
      ratingUser = [];
      json['list'].forEach((v) {
        ratingUser?.add(MentorRatingUserModel.fromJson(v));
      });
    }
  }

  double? avgRating;
  int? amountRating;
  RatingPercentModel? percent;
  List<MentorRatingUserModel>? ratingUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['avgRating'] = avgRating;
    map['amountRating'] = amountRating;
    if (percent != null) {
      map['percent'] = percent?.toJson();
    }
    if (ratingUser != null) {
      map['list'] = ratingUser?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// ID : 47
/// userID : 2049610346
/// comment : "Very good!"
/// rating : 5
/// toUserID : 1240469574
/// skill : "lead"
/// createdDate : "2022-12-06 15:26:55"
/// fullName : "HaiBA2"
/// title : "Rất hài lòng, chủ động hỗ trợ"

class MentorRatingUserModel {
  MentorRatingUserModel({
    this.id,
    this.userID,
    this.comment,
    this.rating,
    this.toUserID,
    this.skill,
    this.createdDate,
    this.fullName,
    this.title,
  });

  MentorRatingUserModel.fromJson(dynamic json) {
    id = TextUtils.parseInt(json['ID']);
    userID = TextUtils.parseInt(json['userID']);
    comment = json['comment'];
    rating = TextUtils.parseInt(json['rating']);
    toUserID = TextUtils.parseInt(json['toUserID']);
    skill = json['skill'];
    createdDate = json['createdDate'];
    fullName = json['fullName'];
    title = json['title'];
  }

  int? id;
  int? userID;
  String? comment;
  int? rating;
  int? toUserID;
  String? skill;
  String? createdDate;
  String? fullName;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['userID'] = userID;
    map['comment'] = comment;
    map['rating'] = rating;
    map['toUserID'] = toUserID;
    map['skill'] = skill;
    map['createdDate'] = createdDate;
    map['fullName'] = fullName;
    map['title'] = title;
    return map;
  }
}

/// 1 : 0
/// 2 : 0
/// 3 : 0
/// 4 : 0
/// 5 : 100

class RatingPercentModel {
  RatingPercentModel({
    this.star1,
    this.star2,
    this.star3,
    this.star4,
    this.star5,
  });

  RatingPercentModel.fromJson(dynamic json) {
    if (json is Map) {
      star1 = double.tryParse(json["1"].toString());
      star2 = double.tryParse(json["2"].toString());
      star3 = double.tryParse(json["3"].toString());
      star4 = double.tryParse(json["4"].toString());
      star5 = double.tryParse(json["5"].toString());
    }
  }

  double? star1;
  double? star2;
  double? star3;
  double? star4;
  double? star5;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['1'] = star1;
    map['2'] = star2;
    map['3'] = star3;
    map['4'] = star4;
    map['5'] = star5;
    return map;
  }
}
