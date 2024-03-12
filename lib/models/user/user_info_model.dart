import 'package:legend_mfast/common/utils/text_util.dart';

/// accessToken : "9fb9bffabf8b4f23c7c6d36eac03006b89f6a460"
/// ID : "1240469574"
/// fullName : "nhapnhap123456789"
/// idNumber : "105557981"
/// idIssuedDate : -28800
/// idIssuedBy : "Bắc Cạn"
/// dob : 963421200
/// sex : "male"
/// mobilePhone : "0122222222"
/// email : "dang.duonghai@mfast.vn"
/// address : "Yên Thế, Thành Phố Pleiku, Gia Lai"
/// bankOwnerName : null
/// bankNumber : ""
/// bankName : ""
/// bankBranch : ""
/// money : "9593761"
/// point : "100000"
/// createdDate : 1584521930
/// avatarImage : "https://firebasestorage.googleapis.com/v0/b/mfast-dev-623d0.appspot.com/o/images/profile_avatar/1240469574_1698900298.jpg?alt=media&token=9fdec7d3-53a2-43a1-aad8-58679de4f409"
/// wallImage : null
/// SIPAccount : ""
/// SIPPassword : ""
/// SIPServer : ""
/// user_type : "pro"
/// referralCode : "888884"
/// rsm_description : "cộng đồng Digipay"
/// rsm_color : "#FFFFFF"
/// userReferralName : ""
/// userReferralID : null
/// prefix : ""
/// isShouldBeRemoved : false
/// ins_promotion_turn_count : 0
/// is_required_nickname : false
/// passcode : "e10adc3949ba59abbe56e057f20f883e"
/// rsmUserID : null
/// rsmRSALevelName : null
/// enable_insurance : false
/// show_legacy_list : false
/// use_rsm_push : false
/// is_line_partner : false

class UserInfoModel {
  UserInfoModel({
    this.accessToken,
    this.firebaseToken,
    this.id,
    this.fullName,
    this.idNumber,
    this.idIssuedDate,
    this.idIssuedBy,
    this.dob,
    this.sex,
    this.mobilePhone,
    this.email,
    this.address,
    this.bankOwnerName,
    this.bankNumber,
    this.bankName,
    this.bankBranch,
    this.money,
    this.point,
    // this.createdDate,
    this.avatarImage,
    this.wallImage,
    this.sIPAccount,
    this.sIPPassword,
    this.sIPServer,
    this.userType,
    this.referralCode,
    this.rsmDescription,
    this.rsmColor,
    this.userReferralName,
    this.userReferralID,
    this.prefix,
    this.isShouldBeRemoved,
    this.insPromotionTurnCount,
    this.isRequiredNickname,
    this.passcode,
    this.rsmUserID,
    this.rsmRSALevelName,
    this.enableInsurance,
    this.showLegacyList,
    this.useRsmPush,
    this.isLinePartner,
  });

  UserInfoModel.fromJson(dynamic json, {dynamic raw}) {
    accessToken = json['accessToken'];
    firebaseToken = json['firebaseToken'] ?? raw?['firebase']?['token'];
    id = json['ID'];
    fullName = json['fullName'];
    idNumber = json['idNumber'];
    idIssuedDate = TextUtils.parseInt(json['idIssuedDate']);
    idIssuedBy = json['idIssuedBy'];
    dob = TextUtils.parseInt(json['dob']);
    sex = json['sex'];
    mobilePhone = json['mobilePhone'];
    email = json['email'];
    address = json['address'];
    bankOwnerName = json['bankOwnerName'];
    bankNumber = json['bankNumber'];
    bankName = json['bankName'];
    bankBranch = json['bankBranch'];
    money = TextUtils.parseDouble(json['money']);
    point = json['point'];
    // createdDate = json['createdDate'];
    avatarImage = json['avatarImage'];
    wallImage = json['wallImage'];
    sIPAccount = json['SIPAccount'];
    sIPPassword = json['SIPPassword'];
    sIPServer = json['SIPServer'];
    userType = json['user_type'];
    referralCode = json['referralCode'];
    rsmDescription = json['rsm_description'];
    rsmColor = json['rsm_color'];
    userReferralName = json['userReferralName'];
    userReferralID = json['userReferralID'];
    prefix = json['prefix'];
    isShouldBeRemoved = json['isShouldBeRemoved'];
    insPromotionTurnCount = json['ins_promotion_turn_count'];
    isRequiredNickname = json['is_required_nickname'];
    passcode = json['passcode'];
    rsmUserID = json['rsmUserID'];
    rsmRSALevelName = json['rsmRSALevelName'];
    enableInsurance = json['enable_insurance'];
    showLegacyList = json['show_legacy_list'];
    useRsmPush = json['use_rsm_push'];
    isLinePartner = json['is_line_partner'];
  }

  String? accessToken;
  String? firebaseToken;
  String? id;
  String? fullName;
  String? idNumber;
  int? idIssuedDate;
  String? idIssuedBy;
  int? dob;
  String? sex;
  String? mobilePhone;
  String? email;
  String? address;
  String? bankOwnerName;
  String? bankNumber;
  String? bankName;
  String? bankBranch;
  double? money;
  String? point;
  // num? createdDate;
  String? avatarImage;
  String? wallImage;
  String? sIPAccount;
  String? sIPPassword;
  String? sIPServer;
  String? userType;
  String? referralCode;
  String? rsmDescription;
  String? rsmColor;
  String? userReferralName;
  String? userReferralID;
  String? prefix;
  bool? isShouldBeRemoved;
  num? insPromotionTurnCount;
  bool? isRequiredNickname;
  String? passcode;
  String? rsmUserID;
  String? rsmRSALevelName;
  bool? enableInsurance;
  bool? showLegacyList;
  bool? useRsmPush;
  bool? isLinePartner;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = accessToken;
    map['firebase'] = firebaseToken;
    map['ID'] = id;
    map['fullName'] = fullName;
    map['idNumber'] = idNumber;
    map['idIssuedDate'] = idIssuedDate;
    map['idIssuedBy'] = idIssuedBy;
    map['dob'] = dob;
    map['sex'] = sex;
    map['mobilePhone'] = mobilePhone;
    map['email'] = email;
    map['address'] = address;
    map['bankOwnerName'] = bankOwnerName;
    map['bankNumber'] = bankNumber;
    map['bankName'] = bankName;
    map['bankBranch'] = bankBranch;
    map['money'] = money;
    map['point'] = point;
    // map['createdDate'] = createdDate;
    map['avatarImage'] = avatarImage;
    map['wallImage'] = wallImage;
    map['SIPAccount'] = sIPAccount;
    map['SIPPassword'] = sIPPassword;
    map['SIPServer'] = sIPServer;
    map['user_type'] = userType;
    map['referralCode'] = referralCode;
    map['rsm_description'] = rsmDescription;
    map['rsm_color'] = rsmColor;
    map['userReferralName'] = userReferralName;
    map['userReferralID'] = userReferralID;
    map['prefix'] = prefix;
    map['isShouldBeRemoved'] = isShouldBeRemoved;
    map['ins_promotion_turn_count'] = insPromotionTurnCount;
    map['is_required_nickname'] = isRequiredNickname;
    map['passcode'] = passcode;
    map['rsmUserID'] = rsmUserID;
    map['rsmRSALevelName'] = rsmRSALevelName;
    map['enable_insurance'] = enableInsurance;
    map['show_legacy_list'] = showLegacyList;
    map['use_rsm_push'] = useRsmPush;
    map['is_line_partner'] = isLinePartner;
    return map;
  }

  UserInfoModel copyWith({
    String? accessToken,
    String? firebaseToken,
    String? id,
    String? fullName,
    String? idNumber,
    int? idIssuedDate,
    String? idIssuedBy,
    int? dob,
    String? sex,
    String? mobilePhone,
    String? email,
    String? address,
    String? bankOwnerName,
    String? bankNumber,
    String? bankName,
    String? bankBranch,
    double? money,
    String? point,
    // num? createdDate,
    String? avatarImage,
    String? wallImage,
    String? sIPAccount,
    String? sIPPassword,
    String? sIPServer,
    String? userType,
    String? referralCode,
    String? rsmDescription,
    String? rsmColor,
    String? userReferralName,
    String? userReferralID,
    String? prefix,
    bool? isShouldBeRemoved,
    num? insPromotionTurnCount,
    bool? isRequiredNickname,
    String? passcode,
    String? rsmUserID,
    String? rsmRSALevelName,
    bool? enableInsurance,
    bool? showLegacyList,
    bool? useRsmPush,
    bool? isLinePartner,
  }) {
    return UserInfoModel(
      accessToken: accessToken ?? this.accessToken,
      firebaseToken: firebaseToken ?? this.firebaseToken,
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      idNumber: idNumber ?? this.idNumber,
      idIssuedDate: idIssuedDate ?? this.idIssuedDate,
      idIssuedBy: idIssuedBy ?? this.idIssuedBy,
      dob: dob ?? this.dob,
      sex: sex ?? this.sex,
      mobilePhone: mobilePhone ?? this.mobilePhone,
      email: email ?? this.email,
      address: address ?? this.address,
      bankOwnerName: bankOwnerName ?? this.bankOwnerName,
      bankNumber: bankNumber ?? this.bankNumber,
      bankName: bankName ?? this.bankName,
      bankBranch: bankBranch ?? this.bankBranch,
      money: money ?? this.money,
      point: point ?? this.point,
      // createdDate: createdDate ?? this.createdDate,
      avatarImage: avatarImage ?? this.avatarImage,
      wallImage: wallImage ?? this.wallImage,
      sIPAccount: sIPAccount ?? this.sIPAccount,
      sIPPassword: sIPPassword ?? this.sIPPassword,
      sIPServer: sIPServer ?? this.sIPServer,
      userType: userType ?? this.userType,
      referralCode: referralCode ?? this.referralCode,
      rsmDescription: rsmDescription ?? this.rsmDescription,
      rsmColor: rsmColor ?? this.rsmColor,
      userReferralName: userReferralName ?? this.userReferralName,
      userReferralID: userReferralID ?? this.userReferralID,
      prefix: prefix ?? this.prefix,
      isShouldBeRemoved: isShouldBeRemoved ?? this.isShouldBeRemoved,
      insPromotionTurnCount: insPromotionTurnCount ?? this.insPromotionTurnCount,
      isRequiredNickname: isRequiredNickname ?? this.isRequiredNickname,
      passcode: passcode ?? this.passcode,
      rsmUserID: rsmUserID ?? this.rsmUserID,
      rsmRSALevelName: rsmRSALevelName ?? this.rsmRSALevelName,
      enableInsurance: enableInsurance ?? this.enableInsurance,
      showLegacyList: showLegacyList ?? this.showLegacyList,
      useRsmPush: useRsmPush ?? this.useRsmPush,
      isLinePartner: isLinePartner ?? this.isLinePartner,
    );
  }
}
