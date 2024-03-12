class MFastAppInfoModel {
  Ios? ios;
  Ios? android;
  String? contactEmail;
  String? contactPhoneNumber;
  String? contactPhoneNumberPretty;
  String? introduceUrl;
  String? termsOfUsageUrl;
  String? privacyPolicyUrl;
  String? facebookFanpageURL;
  String? facebookFanpageText;
  String? zaloFanpageURL;
  String? zaloFanpageText;
  String? workingHourLine1;
  String? workingHourLine2;
  String? faqUrl;
  String? addBankURL;
  String? muasamTheCao;
  String? muasamBaoHiemXeMay;
  String? muasamBaoHiemSucKhoe;
  String? dulichCungWifiPocket;
  String? dienthoaiVanPhong;
  String? taingheVanPhong;
  String? appContestText;
  String? appContestImage;
  String? riCoffee;
  String? tos;
  String? urlMPL;
  String? taxAdjustmentUrl;
  String? withdrawalFeeUrl;
  bool? disabledStatisticMoney;
  bool? disabledListReferralUser;
  String? consentUrl;
  String? regulationTaxUrl;
  String? ctvUserMFastUrl;
  String? mFastCollaborators;
  String? mFastNewCollaborator;
  String? mFastHistoryShopping;
  String? mFastCustomer;
  String? mFastPredsaCustomer;
  String? mFastYourCustomer;
  String? forgetPasswordNote;
  String? forgetPasswordNoteHTML;
  String? introductionUrl;
  String? mFastReviewUserUrl;
  String? introduceUrlMFast;
  String? insuranceCommonUrl;
  String? potentialCustomer;
  String? withdrawalUrl;
  String? urlRuleCobllabNewModel;
  String? urlInfoNewModel;
  String? emptyReviewUrl;
  String? guideWithdrawMoneyUrl;
  Casa? casa;
  bool? disabledLawTab;
  bool? useGenieChat;
  bool? useFlutterChat;
  int? limitMemberGroupChat;
  int? limitUploadMediaSize; // Unit: MB
  List<String>? systemThreadId;

  MFastAppInfoModel({
    this.ios,
    this.android,
    this.contactEmail,
    this.contactPhoneNumber,
    this.contactPhoneNumberPretty,
    this.introduceUrl,
    this.termsOfUsageUrl,
    this.privacyPolicyUrl,
    this.facebookFanpageURL,
    this.facebookFanpageText,
    this.zaloFanpageURL,
    this.zaloFanpageText,
    this.workingHourLine1,
    this.workingHourLine2,
    this.faqUrl,
    this.addBankURL,
    this.muasamTheCao,
    this.muasamBaoHiemXeMay,
    this.muasamBaoHiemSucKhoe,
    this.dulichCungWifiPocket,
    this.dienthoaiVanPhong,
    this.taingheVanPhong,
    this.appContestText,
    this.appContestImage,
    this.riCoffee,
    this.tos,
    this.urlMPL,
    this.taxAdjustmentUrl,
    this.withdrawalFeeUrl,
    this.disabledStatisticMoney,
    this.disabledListReferralUser,
    this.consentUrl,
    this.regulationTaxUrl,
    this.ctvUserMFastUrl,
    this.mFastCollaborators,
    this.mFastNewCollaborator,
    this.mFastHistoryShopping,
    this.mFastCustomer,
    this.mFastPredsaCustomer,
    this.mFastYourCustomer,
    this.forgetPasswordNote,
    this.forgetPasswordNoteHTML,
    this.introductionUrl,
    this.mFastReviewUserUrl,
    this.introduceUrlMFast,
    this.insuranceCommonUrl,
    this.potentialCustomer,
    this.withdrawalUrl,
    this.urlRuleCobllabNewModel,
    this.urlInfoNewModel,
    this.emptyReviewUrl,
    this.guideWithdrawMoneyUrl,
    this.casa,
    this.disabledLawTab,
    this.useGenieChat,
    this.useFlutterChat,
    this.limitMemberGroupChat,
    this.limitUploadMediaSize,
    this.systemThreadId,
  });

  MFastAppInfoModel.fromJson(Map<String, dynamic> json) {
    ios = json['ios'] != null ? Ios.fromJson(json['ios']) : null;
    android = json['android'] != null ? Ios.fromJson(json['android']) : null;
    contactEmail = json['contactEmail'];
    contactPhoneNumber = json['contactPhoneNumber'];
    contactPhoneNumberPretty = json['contactPhoneNumberPretty'];
    introduceUrl = json['introduceUrl'];
    termsOfUsageUrl = json['termsOfUsageUrl'];
    privacyPolicyUrl = json['privacyPolicyUrl'];
    facebookFanpageURL = json['facebookFanpageURL'];
    facebookFanpageText = json['facebookFanpageText'];
    zaloFanpageURL = json['zaloFanpageURL'];
    zaloFanpageText = json['zaloFanpageText'];
    workingHourLine1 = json['workingHourLine1'];
    workingHourLine2 = json['workingHourLine2'];
    faqUrl = json['faqUrl'];
    addBankURL = json['addBankURL'];
    muasamTheCao = json['muasamTheCao'];
    muasamBaoHiemXeMay = json['muasamBaoHiemXeMay'];
    muasamBaoHiemSucKhoe = json['muasamBaoHiemSucKhoe'];
    dulichCungWifiPocket = json['dulichCungWifiPocket'];
    dienthoaiVanPhong = json['dienthoaiVanPhong'];
    taingheVanPhong = json['taingheVanPhong'];
    appContestText = json['appContestText'];
    appContestImage = json['appContestImage'];
    riCoffee = json['riCoffee'];
    tos = json['tos'];
    urlMPL = json['urlMPL'];
    taxAdjustmentUrl = json['taxAdjustmentUrl'];
    withdrawalFeeUrl = json['withdrawalFeeUrl'];
    disabledStatisticMoney = json['disabledStatisticMoney'];
    disabledListReferralUser = json['disabledListReferralUser'];
    consentUrl = json['consentUrl'];
    regulationTaxUrl = json['regulationTaxUrl'];
    ctvUserMFastUrl = json['ctvUserMFastUrl'];
    mFastCollaborators = json['mFastCollaborators'];
    mFastNewCollaborator = json['mFastNewCollaborator'];
    mFastHistoryShopping = json['mFastHistoryShopping'];
    mFastCustomer = json['mFastCustomer'];
    mFastPredsaCustomer = json['mFastPredsaCustomer'];
    mFastYourCustomer = json['mFastYourCustomer'];
    forgetPasswordNote = json['forgetPasswordNote'];
    forgetPasswordNoteHTML = json['forgetPasswordNoteHTML'];
    introductionUrl = json['introductionUrl'];
    mFastReviewUserUrl = json['mFastReviewUserUrl'];
    introduceUrlMFast = json['introduceUrlMFast'];
    insuranceCommonUrl = json['insuranceCommonUrl'];
    potentialCustomer = json['potentialCustomer'];
    withdrawalUrl = json['withdrawalUrl'];
    urlRuleCobllabNewModel = json['urlRuleCobllabNewModel'];
    urlInfoNewModel = json['urlInfoNewModel'];
    emptyReviewUrl = json['emptyReviewUrl'];
    guideWithdrawMoneyUrl = json['guideWithdrawMoneyUrl'];
    casa = json['casa'] != null ? Casa.fromJson(json['casa']) : null;
    disabledLawTab = json['disabledLawTab'];
    useGenieChat = json['useGenieChat'];
    useFlutterChat = json['useFlutterChat'];
    limitMemberGroupChat = json['limitMemberGroupChat'];
    limitUploadMediaSize = json['limitUploadMediaSize'];
    if (json['systemThreadId'] is List) {
      systemThreadId = List<String>.from(json['systemThreadId']);
    } else if (json['systemThreadId'] is String) {
      systemThreadId = [json['systemThreadId']];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ios != null) {
      data['ios'] = ios!.toJson();
    }
    if (android != null) {
      data['android'] = android!.toJson();
    }
    data['contactEmail'] = contactEmail;
    data['contactPhoneNumber'] = contactPhoneNumber;
    data['contactPhoneNumberPretty'] = contactPhoneNumberPretty;
    data['introduceUrl'] = introduceUrl;
    data['termsOfUsageUrl'] = termsOfUsageUrl;
    data['privacyPolicyUrl'] = privacyPolicyUrl;
    data['facebookFanpageURL'] = facebookFanpageURL;
    data['facebookFanpageText'] = facebookFanpageText;
    data['zaloFanpageURL'] = zaloFanpageURL;
    data['zaloFanpageText'] = zaloFanpageText;
    data['workingHourLine1'] = workingHourLine1;
    data['workingHourLine2'] = workingHourLine2;
    data['faqUrl'] = faqUrl;
    data['addBankURL'] = addBankURL;
    data['muasamTheCao'] = muasamTheCao;
    data['muasamBaoHiemXeMay'] = muasamBaoHiemXeMay;
    data['muasamBaoHiemSucKhoe'] = muasamBaoHiemSucKhoe;
    data['dulichCungWifiPocket'] = dulichCungWifiPocket;
    data['dienthoaiVanPhong'] = dienthoaiVanPhong;
    data['taingheVanPhong'] = taingheVanPhong;
    data['appContestText'] = appContestText;
    data['appContestImage'] = appContestImage;
    data['riCoffee'] = riCoffee;
    data['tos'] = tos;
    data['urlMPL'] = urlMPL;
    data['taxAdjustmentUrl'] = taxAdjustmentUrl;
    data['withdrawalFeeUrl'] = withdrawalFeeUrl;
    data['disabledStatisticMoney'] = disabledStatisticMoney;
    data['disabledListReferralUser'] = disabledListReferralUser;
    data['consentUrl'] = consentUrl;
    data['regulationTaxUrl'] = regulationTaxUrl;
    data['ctvUserMFastUrl'] = ctvUserMFastUrl;
    data['mFastCollaborators'] = mFastCollaborators;
    data['mFastNewCollaborator'] = mFastNewCollaborator;
    data['mFastHistoryShopping'] = mFastHistoryShopping;
    data['mFastCustomer'] = mFastCustomer;
    data['mFastPredsaCustomer'] = mFastPredsaCustomer;
    data['mFastYourCustomer'] = mFastYourCustomer;
    data['forgetPasswordNote'] = forgetPasswordNote;
    data['forgetPasswordNoteHTML'] = forgetPasswordNoteHTML;
    data['introductionUrl'] = introductionUrl;
    data['mFastReviewUserUrl'] = mFastReviewUserUrl;
    data['introduceUrlMFast'] = introduceUrlMFast;
    data['insuranceCommonUrl'] = insuranceCommonUrl;
    data['potentialCustomer'] = potentialCustomer;
    data['withdrawalUrl'] = withdrawalUrl;
    data['urlRuleCobllabNewModel'] = urlRuleCobllabNewModel;
    data['urlInfoNewModel'] = urlInfoNewModel;
    data['emptyReviewUrl'] = emptyReviewUrl;
    data['guideWithdrawMoneyUrl'] = guideWithdrawMoneyUrl;
    if (casa != null) {
      data['casa'] = casa!.toJson();
    }
    data['disabledLawTab'] = disabledLawTab;
    data['useGenieChat'] = useGenieChat;
    data['useFlutterChat'] = useFlutterChat;
    data['limitMemberGroupChat'] = limitMemberGroupChat;
    data['limitUploadMediaSize'] = limitUploadMediaSize;
    data['systemThreadId'] = systemThreadId;
    return data;
  }

  int getLimitMemberGroupChat() {
    if (limitMemberGroupChat == null || (limitMemberGroupChat ?? 0) <= 0) {
      return 0;
    }

    return (limitMemberGroupChat ?? 0);
  }
}

class Ios {
  String? version;
  String? details;
  String? appstore;
  bool? forceToUpdate;

  Ios({this.version, this.details, this.appstore, this.forceToUpdate});

  Ios.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    details = json['details'];
    appstore = json['appstore'];
    forceToUpdate = json['forceToUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['version'] = version;
    data['details'] = details;
    data['appstore'] = appstore;
    data['forceToUpdate'] = forceToUpdate;
    return data;
  }
}

class Casa {
  String? title;
  String? desc;
  String? url;
  String? descHtml;

  Casa({this.title, this.desc, this.url, this.descHtml});

  Casa.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    url = json['url'];
    descHtml = json['desc_html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['desc'] = desc;
    data['url'] = url;
    data['desc_html'] = descHtml;
    return data;
  }
}
