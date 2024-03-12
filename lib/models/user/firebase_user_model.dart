
import 'package:legend_mfast/common/utils/text_util.dart';

class FirebaseUserModel {
  FirebaseUserModel({
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
    this.createdDate,
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

  FirebaseUserModel.fromJson(dynamic json, dynamic raw) {
    accessToken = json['accessToken'];
    firebaseToken = raw['firebase']?['token'];
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
    money = json['money'];
    point = json['point'];
    createdDate = json['createdDate'];
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
  dynamic bankOwnerName;
  String? bankNumber;
  String? bankName;
  String? bankBranch;
  String? money;
  String? point;
  int? createdDate;
  String? avatarImage;
  dynamic wallImage;
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
  int? insPromotionTurnCount;
  bool? isRequiredNickname;
  dynamic passcode;
  dynamic rsmUserID;
  dynamic rsmRSALevelName;
  bool? enableInsurance;
  bool? showLegacyList;
  bool? useRsmPush;
  bool? isLinePartner;
}
