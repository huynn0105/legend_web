import '../../../../models/user/user_info_model.dart';

class SendNotificationToCollaboratorPayload {
  SendNotificationToCollaboratorPayload({
    this.userIDs,
    this.data,
  });

  List<String>? userIDs;
  NotificationData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userIDs'] = userIDs;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class NotificationData {
  NotificationData({
    this.notification,
    this.data,
  });

  NotificationMetaData? notification;
  ParamData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (notification != null) {
      map['notification'] = notification?.toJson();
    }
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class NotificationMetaData {
  NotificationMetaData({
    this.title,
    this.body,
    this.sound,
  });

  NotificationMetaData.fromJson(dynamic json) {
    title = json['title'];
    body = json['body'];
    sound = json['sound'];
  }

  String? title;
  String? body;
  String? sound;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['body'] = body;
    map['sound'] = sound;
    return map;
  }
}

class ParamData {
  ParamData({
    this.type,
    this.category,
    this.filterCondition,
    this.extraData,
  });

  String? type;
  String? category;
  FilterCondition? filterCondition;
  ExtraData? extraData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['category'] = category;
    if (filterCondition != null) {
      map['filterCondition'] = filterCondition?.toJson();
    }
    if (extraData != null) {
      map['extra_data'] = extraData?.toJson();
    }
    return map;
  }
}

class ExtraData {
  ExtraData({
    this.title,
    this.body,
    this.screenTitle,
    this.url,
    this.imgUrl,
    this.tags,
    this.user,
  });

  ExtraData.fromJson(dynamic json) {
    title = json['title'];
    body = json['body'];
    screenTitle = json['screen_title'];
    url = json['url'];
    imgUrl = json['img_url'];
    tags = json['tags'];
    user = json['user'] != null ? UserInfoModel.fromJson(json['user']) : null;
  }

  String? title;
  String? body;
  String? screenTitle;
  String? url;
  String? imgUrl;
  String? tags;
  UserInfoModel? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['body'] = body;
    map['screen_title'] = screenTitle;
    map['url'] = url;
    map['img_url'] = imgUrl;
    map['tags'] = tags;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}

class FilterCondition {
  FilterCondition({
    this.typeRSM,
    this.statusRSM,
    this.topRSM,
  });

  FilterCondition.fromJson(dynamic json) {
    typeRSM = json['typeRSM'];
    statusRSM = json['statusRSM'];
    topRSM = json['topRSM'];
  }

  String? typeRSM;
  String? statusRSM;
  String? topRSM;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['typeRSM'] = typeRSM;
    map['statusRSM'] = statusRSM;
    map['topRSM'] = topRSM;
    return map;
  }
}
