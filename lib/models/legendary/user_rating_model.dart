import '../../common/utils/text_util.dart';

class UserRatingModel {
  double? point;
  int? commission;
  int? collaborator;
  UserRating? user;
  Rank? rank;
  int? initLevel;
  bool? requestDelete;
  String? requestDeleteDate;
  String? requestReason;

  UserRatingModel(
      {this.point,
      this.commission,
      this.collaborator,
      this.user,
      this.rank,
      this.initLevel,
      this.requestDelete,
      this.requestDeleteDate,
      this.requestReason});

  UserRatingModel.fromJson(Map<String, dynamic> json) {
    point = TextUtils.parseDouble(json['point']);
    commission = json['commission'];
    collaborator = json['collaborator'];
    user = json['user'] != null ? UserRating.fromJson(json['user']) : null;
    rank = json['rank'] != null ? Rank.fromJson(json['rank']) : null;
    initLevel = json['initLevel'];
    requestDelete = json['requestDelete'];
    requestDeleteDate = json['requestDeleteDate'];
    requestReason = json['requestReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['point'] = point;
    data['commission'] = commission;
    data['collaborator'] = collaborator;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (rank != null) {
      data['rank'] = rank!.toJson();
    }
    data['initLevel'] = initLevel;
    data['requestDelete'] = requestDelete;
    data['requestDeleteDate'] = requestDeleteDate;
    data['requestReason'] = requestReason;
    return data;
  }
}

class UserRating {
  String? fullName;
  String? avatarImage;
  String? sex;
  String? mobilePhone;

  UserRating({this.fullName, this.avatarImage, this.sex, this.mobilePhone});

  UserRating.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    avatarImage = json['avatarImage'];
    sex = json['sex'];
    mobilePhone = json['mobilePhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['avatarImage'] = avatarImage;
    data['sex'] = sex;
    data['mobilePhone'] = mobilePhone;
    return data;
  }
}

class Rank {
  int? iD;
  int? userID;
  double? points;
  UserRatingLevel? level;
  double? tmpPoints;
  UserRatingLevel? tmpLevel;
  String? createdDate;
  int? totalUserPoint;
  double? growPoint;
  int? tmpTotalUserPoint;
  double? tmpGrowPoint;
  int? totalUserEKycPoint;
  int? tmpTotalUserEKycPoint;
  int? bonusUserInsPoint;
  int? bonusUserNonInsPoint;
  double? finAmtPoint;
  int? insAmtPoint;
  int? daaPoint;
  int? mtradePoint;
  int? bonusPoint;
  int? tmpBonusUserInsPoint;
  int? tmpBonusUserNonInsPoint;
  double? tmpFinAmtPoint;
  double? tmpInsAmtPoint;
  int? tmpDaaPoint;
  int? tmpMTradePoint;
  int? tmpBonusPoint;
  String? userCreatedDate;
  double? point;
  double? tmpPoint;
  NextLevel? nextLevel;

  Rank(
      {this.iD,
      this.userID,
      this.points,
      this.level,
      this.tmpPoints,
      this.tmpLevel,
      this.createdDate,
      this.totalUserPoint,
      this.growPoint,
      this.tmpTotalUserPoint,
      this.tmpGrowPoint,
      this.totalUserEKycPoint,
      this.tmpTotalUserEKycPoint,
      this.bonusUserInsPoint,
      this.bonusUserNonInsPoint,
      this.finAmtPoint,
      this.insAmtPoint,
      this.daaPoint,
      this.mtradePoint,
      this.bonusPoint,
      this.tmpBonusUserInsPoint,
      this.tmpBonusUserNonInsPoint,
      this.tmpFinAmtPoint,
      this.tmpInsAmtPoint,
      this.tmpDaaPoint,
      this.tmpMTradePoint,
      this.tmpBonusPoint,
      this.userCreatedDate,
      this.point,
      this.tmpPoint,
      this.nextLevel});

  Rank.fromJson(Map<String, dynamic> json) {
    // iD = json['ID'];
    // userID = json['userID'];
    // points = TextUtils.parseDouble(json['points']);
    level = json['level'] != null ? UserRatingLevel.fromJson(json['level']) : null;
    // tmpPoints = TextUtils.parseDouble(json['tmpPoints']);
    // tmpLevel = json['tmpLevel'] != null ? UserRatingLevel.fromJson(json['tmpLevel']) : null;
    // createdDate = json['createdDate'];
    // totalUserPoint = json['totalUserPoint'];
    // growPoint = TextUtils.parseDouble(json['growPoint']);
    // tmpTotalUserPoint = json['tmpTotalUserPoint'];
    // tmpGrowPoint = json['tmpGrowPoint'];
    // totalUserEKycPoint = json['totalUserEKycPoint'];
    // tmpTotalUserEKycPoint = json['tmpTotalUserEKycPoint'];
    // bonusUserInsPoint = json['bonusUserInsPoint'];
    // bonusUserNonInsPoint = json['bonusUserNonInsPoint'];
    // finAmtPoint = json['finAmtPoint'];
    // insAmtPoint = json['insAmtPoint'];
    // daaPoint = json['daaPoint'];
    // mtradePoint = json['mtradePoint'];
    // bonusPoint = json['bonusPoint'];
    // tmpBonusUserInsPoint = json['tmpBonusUserInsPoint'];
    // tmpBonusUserNonInsPoint = json['tmpBonusUserNonInsPoint'];
    // tmpFinAmtPoint = json['tmpFinAmtPoint'];
    // tmpInsAmtPoint = json['tmpInsAmtPoint'];
    // tmpDaaPoint = json['tmpDaaPoint'];
    // tmpMTradePoint = json['tmpMTradePoint'];
    // tmpBonusPoint = json['tmpBonusPoint'];
    // userCreatedDate = json['userCreatedDate'];
    // point = json['point'];
    // tmpPoint = json['tmpPoint'];
    // nextLevel = json['nextLevel'] != null ? NextLevel.fromJson(json['nextLevel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['userID'] = userID;
    data['points'] = points;
    if (level != null) {
      data['level'] = level!.toJson();
    }
    data['tmpPoints'] = tmpPoints;
    if (tmpLevel != null) {
      data['tmpLevel'] = tmpLevel!.toJson();
    }
    data['createdDate'] = createdDate;
    data['totalUserPoint'] = totalUserPoint;
    data['growPoint'] = growPoint;
    data['tmpTotalUserPoint'] = tmpTotalUserPoint;
    data['tmpGrowPoint'] = tmpGrowPoint;
    data['totalUserEKycPoint'] = totalUserEKycPoint;
    data['tmpTotalUserEKycPoint'] = tmpTotalUserEKycPoint;
    data['bonusUserInsPoint'] = bonusUserInsPoint;
    data['bonusUserNonInsPoint'] = bonusUserNonInsPoint;
    data['finAmtPoint'] = finAmtPoint;
    data['insAmtPoint'] = insAmtPoint;
    data['daaPoint'] = daaPoint;
    data['mtradePoint'] = mtradePoint;
    data['bonusPoint'] = bonusPoint;
    data['tmpBonusUserInsPoint'] = tmpBonusUserInsPoint;
    data['tmpBonusUserNonInsPoint'] = tmpBonusUserNonInsPoint;
    data['tmpFinAmtPoint'] = tmpFinAmtPoint;
    data['tmpInsAmtPoint'] = tmpInsAmtPoint;
    data['tmpDaaPoint'] = tmpDaaPoint;
    data['tmpMTradePoint'] = tmpMTradePoint;
    data['tmpBonusPoint'] = tmpBonusPoint;
    data['userCreatedDate'] = userCreatedDate;
    data['point'] = point;
    data['tmpPoint'] = tmpPoint;
    if (nextLevel != null) {
      data['nextLevel'] = nextLevel!.toJson();
    }
    return data;
  }
}

class UserRatingLevel {
  int? iD;
  String? level;
  String? title;
  int? point;
  int? commGrade;
  int? commRate;
  String? teaser;
  String? image;

  UserRatingLevel(
      {this.iD, this.level, this.title, this.point, this.commGrade, this.commRate, this.teaser, this.image});

  UserRatingLevel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    level = json['level'];
    title = json['title'];
    point = json['point'];
    commGrade = json['commGrade'];
    commRate = json['commRate'];
    teaser = json['teaser'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['level'] = level;
    data['title'] = title;
    data['point'] = point;
    data['commGrade'] = commGrade;
    data['commRate'] = commRate;
    data['teaser'] = teaser;
    data['image'] = image;
    return data;
  }
}

class NextLevel {
  int? iD;
  String? level;
  String? title;
  int? point;
  int? commGrade;
  int? commRate;
  String? teaser;
  String? image;

  NextLevel({this.iD, this.level, this.title, this.point, this.commGrade, this.commRate, this.teaser, this.image});

  NextLevel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    level = json['level'];
    title = json['title'];
    point = json['point'];
    commGrade = json['commGrade'];
    commRate = json['commRate'];
    teaser = json['teaser'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['level'] = level;
    data['title'] = title;
    data['point'] = point;
    data['commGrade'] = commGrade;
    data['commRate'] = commRate;
    data['teaser'] = teaser;
    data['image'] = image;
    return data;
  }
}
