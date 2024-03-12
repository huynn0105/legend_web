class StatusReviewModel {
  List<StatusReview>? predsa;
  List<StatusReview>? tsa;
  List<StatusReview>? qaMeeting;

  StatusReviewModel({this.predsa, this.tsa, this.qaMeeting});

  StatusReviewModel.fromJson(Map<String, dynamic> json) {
    if (json['predsa'] != null) {
      predsa = <StatusReview>[];
      json['predsa'].forEach((v) {
        predsa!.add(StatusReview.fromJson(v));
      });
    }
    if (json['tsa'] != null) {
      tsa = <StatusReview>[];
      json['tsa'].forEach((v) {
        tsa!.add(StatusReview.fromJson(v));
      });
    }
    if (json['qa_meeting'] != null) {
      qaMeeting = <StatusReview>[];
      json['qa_meeting'].forEach((v) {
        qaMeeting!.add(StatusReview.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (predsa != null) {
      data['predsa'] = predsa!.map((v) => v.toJson()).toList();
    }
    if (tsa != null) {
      data['tsa'] = tsa!.map((v) => v.toJson()).toList();
    }
    if (qaMeeting != null) {
      data['qa_meeting'] = qaMeeting!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<StatusReview>? getListStatus(String role) {
    switch (role) {
      case 'predsa':
        return predsa;
      case 'tsa':
        return tsa;
      case 'qa_meeting':
        return qaMeeting;
      default:
        break;
    }
    return null;
  }
}

class StatusReview {
  String? iD;
  String? statusName;
  String? projectRoleAlias;
  String? defaultStar;

  StatusReview({this.iD, this.statusName, this.projectRoleAlias, this.defaultStar});

  StatusReview.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    statusName = json['statusName'];
    projectRoleAlias = json['projectRoleAlias'];
    defaultStar = json['defaultStar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['statusName'] = statusName;
    data['projectRoleAlias'] = projectRoleAlias;
    data['defaultStar'] = defaultStar;
    return data;
  }
}
