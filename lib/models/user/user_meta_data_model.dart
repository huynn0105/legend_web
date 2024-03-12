import 'package:legend_mfast/common/enum/gender_type.dart';
import 'package:legend_mfast/common/extension/map_extension.dart';
import 'package:legend_mfast/common/utils/vietnamese_util.dart';

/// tax_number : "2124124134"
/// full_name : "nhapnhap123456789"
/// mobile_phone : "0122222222"
/// email_address : "dang.duonghai@mfast.vn"
/// address_current : "146 tan bin"
/// gender : "male"
/// country_id_number : "105557981"
/// country_id_date_of_birth : "13-07-2000"
/// country_id_issued_date : "2010-01-01"
/// country_id_issued_by : "Bắc Cạn"
/// selfie_photo : "https://appay-rc.cloudcms.vn/uploads/support/2049610744/liveness_selfie_20230622113947.png"
/// place_of_birth : "Ý Yên Nam Định"
/// country_id_number_household : "112222222"
/// date_of_birth : "13-07-2000"
/// tax_number_status : "failed"
/// address_current_district : "Q. 9 - Hồ Chí Minh"
/// country_id_name : "LE BA HOANG"
/// country_id_address : "Yên Thế, Thành Phố Pleiku, Gia Lai"
/// payment_gateway_confirm : true
/// tax_number_org : ""
/// selfie_photo_with_id_number : "https://appay-rc.cloudcms.vn/uploads/support/1240469574/023159caf7bae10f4dd04f2ff01fce99.png"
/// full_name_ancii : "nhapnhap123456789"
/// potential_skills : "2"
/// last_time_login : "1700559827561"
/// is_online : true
/// is_review_tax_number : "SUCCESS"
/// tax_committed_photo : "https://appay-rc.cloudcms.vn/uploads/support/1240469574/f6ce506a37fcba07116000135b6e5e2f.png"
/// tax_committed_photo_status : "SUCCESS"
/// tax_committed_photo_message : "Cam kết thuế hợp lệ"
/// is_show_hier_popup : false
/// hierarchical_point : "5339.5"
/// hierarchical_level : "KPI_RSM"
/// is_show_hier_guide_popup : "0"
/// country_old_id_number : "352631669"
/// is_verified_email : false
/// ctv_agreement : true
/// is_signed_ins_certificate : true
/// has_ins_certificate : false
/// country_id_photo_front : "https://appay.cloudcms.vn/uploads/support/1240649076/218170e8029ec5da8b0a6e1244ef6c1e.png"
/// country_id_photo_back : "https://appay-rc.cloudcms.vn/uploads/support/2049610755/54ede78ef8ce5740d5339d776b6bc614.png"
/// disabled_press_ctv : true
/// is_banking : true

class UserMetaDataModel {
  UserMetaDataModel({
    this.taxNumber,
    this.fullName,
    this.mobilePhone,
    this.emailAddress,
    this.addressCurrent,
    this.gender,
    this.countryIdNumber,
    this.countryIdDateOfBirth,
    this.countryIdIssuedDate,
    this.countryIdIssuedBy,
    this.selfiePhoto,
    this.placeOfBirth,
    this.countryIdNumberHousehold,
    this.dateOfBirth,
    this.taxNumberStatus,
    this.addressCurrentDistrict,
    this.countryIdName,
    this.countryIdAddress,
    this.paymentGatewayConfirm,
    this.taxNumberOrg,
    this.selfiePhotoWithIdNumber,
    this.fullNameAncii,
    this.potentialSkills,
    this.lastTimeLogin,
    this.isOnline,
    this.isReviewTaxNumber,
    this.taxCommittedPhoto,
    this.taxCommittedPhotoStatus,
    this.taxCommittedPhotoMessage,
    this.isShowHierPopup,
    this.hierarchicalPoint,
    this.hierarchicalLevel,
    this.isShowHierGuidePopup,
    this.countryOldIdNumber,
    this.isVerifiedEmail,
    this.ctvAgreement,
    this.isSignedInsCertificate,
    this.hasInsCertificate,
    this.countryIdPhotoFront,
    this.countryIdPhotoBack,
    this.disabledPressCtv,
    this.isBanking,
  });

  UserMetaDataModel.fromJson(dynamic json) {
    taxNumber = json['tax_number'];
    fullName = json['full_name'];
    mobilePhone = json['mobile_phone'];
    emailAddress = json['email_address'];
    addressCurrent = json['address_current'];
    gender = json['gender'];
    countryIdNumber = json['country_id_number'];
    countryIdDateOfBirth = json['country_id_date_of_birth'];
    countryIdIssuedDate = json['country_id_issued_date'];
    countryIdIssuedBy = json['country_id_issued_by'];
    selfiePhoto = json['selfie_photo'];
    placeOfBirth = json['place_of_birth'];
    countryIdNumberHousehold = json['country_id_number_household'];
    dateOfBirth = json['date_of_birth'];
    taxNumberStatus = json['tax_number_status'];
    addressCurrentDistrict = json['address_current_district'];
    countryIdName = json['country_id_name'];
    countryIdAddress = json['country_id_address'];
    paymentGatewayConfirm = json['payment_gateway_confirm'];
    taxNumberOrg = json['tax_number_org'];
    selfiePhotoWithIdNumber = json['selfie_photo_with_id_number'];
    fullNameAncii = json['full_name_ancii'];
    potentialSkills = json['potential_skills'];
    lastTimeLogin = json['last_time_login'];
    isOnline = json['is_online'];
    isReviewTaxNumber = json['is_review_tax_number'];
    taxCommittedPhoto = json['tax_committed_photo'];
    taxCommittedPhotoStatus = json['tax_committed_photo_status'];
    taxCommittedPhotoMessage = json['tax_committed_photo_message'];
    isShowHierPopup = json['is_show_hier_popup'];
    hierarchicalPoint = json['hierarchical_point'];
    hierarchicalLevel = json['hierarchical_level'];
    isShowHierGuidePopup = json['is_show_hier_guide_popup'];
    countryOldIdNumber = json['country_old_id_number'];
    isVerifiedEmail = json['is_verified_email'];
    ctvAgreement = json['ctv_agreement'];
    isSignedInsCertificate = json['is_signed_ins_certificate'];
    hasInsCertificate = json['has_ins_certificate'];
    countryIdPhotoFront = json['country_id_photo_front'];
    countryIdPhotoBack = json['country_id_photo_back'];
    disabledPressCtv = json['disabled_press_ctv'];
    isBanking = json['is_banking'];
  }

  String? taxNumber;
  String? fullName;
  String? mobilePhone;
  String? emailAddress;
  String? addressCurrent;
  String? gender;
  String? countryIdNumber;
  String? countryIdDateOfBirth;
  String? countryIdIssuedDate;
  String? countryIdIssuedBy;
  String? selfiePhoto;
  String? placeOfBirth;
  String? countryIdNumberHousehold;
  String? dateOfBirth;
  String? taxNumberStatus;
  String? addressCurrentDistrict;
  String? countryIdName;
  String? countryIdAddress;
  bool? paymentGatewayConfirm;
  String? taxNumberOrg;
  String? selfiePhotoWithIdNumber;
  String? fullNameAncii;
  String? potentialSkills;
  String? lastTimeLogin;
  bool? isOnline;
  String? isReviewTaxNumber;
  String? taxCommittedPhoto;
  String? taxCommittedPhotoStatus;
  String? taxCommittedPhotoMessage;
  bool? isShowHierPopup;
  String? hierarchicalPoint;
  String? hierarchicalLevel;
  String? isShowHierGuidePopup;
  String? countryOldIdNumber;
  bool? isVerifiedEmail;
  bool? ctvAgreement;
  bool? isSignedInsCertificate;
  bool? hasInsCertificate;
  String? countryIdPhotoFront;
  String? countryIdPhotoBack;
  bool? disabledPressCtv;
  bool? isBanking;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tax_number'] = taxNumber;
    map['full_name'] = fullName;
    map['mobile_phone'] = mobilePhone;
    map['email_address'] = emailAddress;
    map['address_current'] = addressCurrent;
    map['gender'] = gender;
    map['country_id_number'] = countryIdNumber;
    map['country_id_date_of_birth'] = countryIdDateOfBirth;
    map['country_id_issued_date'] = countryIdIssuedDate;
    map['country_id_issued_by'] = countryIdIssuedBy;
    map['selfie_photo'] = selfiePhoto;
    map['place_of_birth'] = placeOfBirth;
    map['country_id_number_household'] = countryIdNumberHousehold;
    map['date_of_birth'] = dateOfBirth;
    map['tax_number_status'] = taxNumberStatus;
    map['address_current_district'] = addressCurrentDistrict;
    map['country_id_name'] = countryIdName;
    map['country_id_address'] = countryIdAddress;
    map['payment_gateway_confirm'] = paymentGatewayConfirm;
    map['tax_number_org'] = taxNumberOrg;
    map['selfie_photo_with_id_number'] = selfiePhotoWithIdNumber;
    map['full_name_ancii'] = fullNameAncii;
    map['potential_skills'] = potentialSkills;
    map['last_time_login'] = lastTimeLogin;
    map['is_online'] = isOnline;
    map['is_review_tax_number'] = isReviewTaxNumber;
    map['tax_committed_photo'] = taxCommittedPhoto;
    map['tax_committed_photo_status'] = taxCommittedPhotoStatus;
    map['tax_committed_photo_message'] = taxCommittedPhotoMessage;
    map['is_show_hier_popup'] = isShowHierPopup;
    map['hierarchical_point'] = hierarchicalPoint;
    map['hierarchical_level'] = hierarchicalLevel;
    map['is_show_hier_guide_popup'] = isShowHierGuidePopup;
    map['country_old_id_number'] = countryOldIdNumber;
    map['is_verified_email'] = isVerifiedEmail;
    map['ctv_agreement'] = ctvAgreement;
    map['is_signed_ins_certificate'] = isSignedInsCertificate;
    map['has_ins_certificate'] = hasInsCertificate;
    map['country_id_photo_front'] = countryIdPhotoFront;
    map['country_id_photo_back'] = countryIdPhotoBack;
    map['disabled_press_ctv'] = disabledPressCtv;
    map['is_banking'] = isBanking;
    return map;
  }

  Map<String, dynamic> toCleanJson() {
    return toJson().removeFalsyValue();
  }

  bool get isCTVConfirmed {
    return ctvAgreement == true;
  }

  GenderType getGenderType() {
    final gender = this.gender ?? '';
    final isMale = ['male', 'nam', 'm'].contains(VietnameseUtils.toEnglish(gender.toLowerCase()));
    final isFemale = ['female', 'nu', 'f'].contains(VietnameseUtils.toEnglish(gender.toLowerCase()));

    ///
    if (isMale) {
      return GenderType.male;
    }
    if (isFemale) {
      return GenderType.female;
    }
    return GenderType.other;
  }
}
