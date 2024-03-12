import 'package:flutter/material.dart';
import 'package:legend_mfast/common/bottom_sheet/wrapper/data_wrapper.dart';

class AppConstants {
  AppConstants._();

  static const Map<String, dynamic> product = {
    'productID': '1001',
    'orderProductId': 'be21de28-624b-44fd-9051-8e500dbde030',
    'productName': 'IPhone 14 Pro Max',
    'productPrice': '20000000',
    'productCategoryName': 'Điện thoại',
    'productMerchantCode': 'GOTIT',
    'productMerchantName': 'gotit',
    'productMerchantLogo': 'https://itel.png',
    'loanTerms': 6,
    'prepayPercent': 0,
    'prepayAmount': 15000000,
    'loanAmount': 5000000,
    'interestRate': 0,
    'insurance': 250000,
    'payMonthly': 1050000,
  };

  static const String vndCurrencySymbol = "\u20ab";
  static const String defaultDirectSale = 'allSales';
  static const bool visibleCollaboratorCanRemove = false;

  static const int defaultLoanTenor = 3;

  static const int maxPerPage = 10;
  static const int maxProductPerOrder = 20;
  static const int maxQuantityPerProduct = 99;

  static const int maxMessagesPerPage = 50;

  static const int maxSelectedMedia = 10;

  static const double keyboardHeight = 300;

  static const double maxScreenRatio = 0.85;

  static const List<String> deeplink = ["mfastmobiledev", "mfastmobile"];
  static const String appayDeeplinkScheme = "appaymobile";

  static const String avatar = "https://i.imgur.com/VVI0OSu.jpeg";
  static const String avatarMentor =
      "https://image-us.24h.com.vn/upload/3-2022/images/2022-07-11/21-1657535366-24-width650height650.jpg";
  static const Duration duration = Duration(milliseconds: 250);

  static const ScrollPhysics physics = AlwaysScrollableScrollPhysics(
    parent: BouncingScrollPhysics(),
  );

  static const double appbarHeight = 46;
  static const double homeSpaceDistance = 32;

  static const int maxRating = 5; // 1-5 star(s)
  static const int tabSize = 5;

  static const List<String> ratingFilters = ['Tất cả', '5 sao', '4 sao', '3 sao', '2 sao', '1 sao'];

  static const double responsiveSize = 500;
  static const double minGridWidth = 545;

  static const String addressImageKey = 'addressImageKey';
  static const String portraitImageKey = 'portraitImageKey';
  static const String documentImageKey = 'documentImageKey';
  static const String productImageKey = 'productImageKey';
  static const String setupImageKey = 'setupImageKey';
  static const String otherImageKey = 'otherImageKey';
  static const String invoiceImageCheckBoxKey = 'invoiceImageCheckBoxKey';
  static const String invoiceImageKey = 'invoiceImageKey';
  static const String reasonDelayKey = 'reasonDelayKey';
  static const String reasonFailureKey = 'reasonFailureKey';
  static const String paymentMethodKey = 'paymentMethodKey';

  // Delivery support
  static const String deliverySupportProvinceKey = 'deliverySupportProvinceKey';
  static const String deliverySupportDistrictKey = 'deliverySupportDistrictKey';

  // Order Address Key
  static const String orderFullNameKey = 'fullName';
  static const String orderPhoneNumberKey = 'phoneNumber';
  static const String orderEmailKey = 'email';
  static const String orderProvinceKey = 'province';
  static const String orderDistrictKey = 'district';
  static const String orderWardKey = 'ward';
  static const String orderStreetKey = 'street';
  static const String receiveTimeKey = 'receiveTimeKey';
  static const String orderAgencyNameKey = 'agencyName';
  static const String orderTaxKey = 'tax';
  static const String orderAddressKey = 'address';
  static const String orderIdNumberKey = 'idNumber';
  static const String orderPaymentMethodKey = 'orderPaymentMethod';
  static const String orderPolicyKey = 'policy';

  static const String buyerNameKey = 'buyerNameKey';
  static const String buyerPhoneKey = 'buyerPhoneKey';
  static const String buyerIDNumberKey = 'buyerIDNumberKey';
  static const String buyerProvinceKey = 'buyerProvinceKey';
  static const String buyerDistrictKey = 'buyerDistrictKey';

  static const String householdHeadNameKey = 'householdHeadNameKey';
  static const String householdHeadIdNumberKey = 'householdHeadIdNumberKey';

  //
  static const String prefixSkuOption = "sku-option";
  static const String prefixMessengerDomain = "https://m.me/";

  //
  static const String productLocationSupportKey = 'productLocationSupportKey';
  static const String productInvalidKey = 'productInvalidKey';

  //
  static const String websiteSetupContactMethodKey = 'websiteSetupContactMethodKey';
  static const String websiteSetupContactMethodMessengerKey = 'websiteSetupContactMethodMessengerKey';

  static const int otpCountdown = 60;
  static const String phoneKey = 'phone';
  static const String idNumberKey = 'idNumber';
  static const String policyAcceptedKey = 'policyAccepted';
  static const String otpKey = 'otp';
  // Cart
  static const String ruleOnlyPayLaterType = "ruleOnlyPayLaterType";
  static const String ruleOnlyOneHighRisk = "ruleOnlyOneHighRisk";
  static const String ruleOnlyOneProductPerCategory = "ruleOnlyOneProductPerCategory";
  static const String ruleOnlyOneSkuPerProduct = "ruleOnlyOneSkuPerProduct";
  static const String ruleUnsupported = "ruleUnsupported";

  static const String ruleOnlyOneQuantityPerSku = "ruleOnlyOneQuantityPerSku";

  //
  static const String iframeKey = "iframeKey";

  // Invoice
  static const String invoicePersonalFullNameKey = 'invoicePersonalNameKey';
  static const String invoicePersonalAddressKey = 'invoicePersonalAddressKey';
  static const String invoiceCompanyNameKey = 'invoiceCompanyNameKey';
  static const String invoiceCompanyTaxKey = 'invoiceCompanyTaxKey';
  static const String invoiceCompanyAddressKey = 'invoiceCompanyAddressKey';
  static const String invoiceEmailKey = 'invoiceEmailKey';

  static const String linkGuideGetIdFacebook =
      'https://drive.google.com/file/d/1yhnpKQ3fjQQiRdt-YxjNPrkCVtLLm0cI/view?usp=drivesdk';

  /// Face match
  static const int validMatchCore = 80;
  static const String documentType = 'CCCD';

  /// Bank
  static const String bankAccountNameKey = 'bankAccountNameKey';
  static const String bankAccountNumberKey = 'bankAccountNumberKey';
  static const String generalBankKey = 'generalBankKey';
  static const String generalBankBranchKey = 'generalBankBranchKey';

  /// Contract Collaborator
  static const String contractPolicyKey = 'contractPolicyKey';

  //Collaborator
  static const String collaboratorLeaveDetailUrl =
      'https://mfast.vn/quy-dinh-ve-quyen-so-huu-cong-tac-vien-tren-mfast/';

  static final List<DataWrapper> defaultRatingFilters = [
    DataWrapper(id: "all", value: "Tất cả"),
    DataWrapper(id: "5", value: "5 sao"),
    DataWrapper(id: "4", value: "4 sao"),
    DataWrapper(id: "3", value: "3 sao"),
    DataWrapper(id: "2", value: "2 sao"),
    DataWrapper(id: "1", value: "1 sao"),
  ];

  static final List<DataWrapper> defaultSkillChatFilters = [
    DataWrapper(id: "sell", value: "Kỹ năng bán hàng"),
    DataWrapper(id: "lead", value: "Kỹ năng dẫn dắt"),
  ];

  static final List<DataWrapper> defaultSkillFilters = [
    DataWrapper(id: "top_lead", value: "Được đánh giá tốt nhất"),
    DataWrapper(id: "top_ctv_pl", value: "Giúp CTV có thu nhập tốt nhất từ Tài Chính"),
    DataWrapper(id: "top_level", value: "Giúp CTV có thu nhập tốt nhất từ Bảo hiểm"),
    DataWrapper(id: "top_ctv_sale", value: "Giúp CTV có thu nhập tốt nhất từ Tài khoản số"),
    DataWrapper(id: "top_ctv_earning", value: "Giúp CTV có thu nhập tốt nhất"),
  ];
}
