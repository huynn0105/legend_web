import 'package:flutter/material.dart';
import 'package:legend_mfast/common/widgets/images.dart';

import '../../../../../common/colors.dart';
import '../../../../../common/global_function.dart';
import '../../../../../common/styles.dart';
import '../../../../../common/toast/toast_provider.dart';
import '../../../../../common/widgets/buttons.dart';
import '../../../../../models/user/referral_info_model.dart';

class ReferralComponent extends StatelessWidget {
  const ReferralComponent({
    Key? key,
    required this.referralCode,
    required this.referral,
    this.onGoQrCodeComponent,
  }) : super(key: key);

  final String? referralCode;
  final ReferralInfoModel? referral;
  final Function()? onGoQrCodeComponent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12, right: 12),
          decoration: const BoxDecoration(
            color: UIColors.darkBlue,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Mã MFast của bạn là:  ${referralCode ?? ''}',
                  style: UITextStyle.medium.copyWith(
                    fontSize: 16,
                    color: UIColors.white,
                  ),
                ),
              ),
              SplashButton(
                onTap: () {
                  GlobalFunction.copyText(referralCode ?? "").then(
                    (_) {
                      ToastProvider.instance.showCopy(context: context);
                    },
                  );
                },
                child: Row(
                  children: [
                    Text(
                      'Copy',
                      style: UITextStyle.regular.copyWith(
                        color: UIColors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const AppImage.asset(
                      asset: "ic_copy",
                      width: 24,
                      height: 24,
                      color: UIColors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Ba cách để mời Cộng tác viên tham gia cộng đồng của bạn',
            style: UITextStyle.regular.copyWith(
              color: UIColors.grayBackground,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SplashButton(
          onTap: () {
            GlobalFunction.copyText(referral?.cTVText2 ?? '').then(
                  (_) {
                ToastProvider.instance.showCopy(context: context);
              },
            );
            // GlobalFunction.shareText(referral?.cTVText2 ?? '');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppImage.asset(asset: 'ic_code', width: 40, height: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Mời tham gia thông qua nhập mã\nMFast: ',
                                    style: UITextStyle.medium.copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: referralCode ?? '',
                                    style: UITextStyle.bold.copyWith(
                                      fontSize: 16,
                                      color: UIColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const AppImage.asset(asset: 'ic_arrow_right', width: 20, height: 20),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          style: UITextStyle.regular.copyWith(
                            color: UIColors.grayText,
                            fontSize: 13,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Cộng tác viên ',
                            ),
                            TextSpan(
                              text: 'sử dụng mã trên',
                              style: UITextStyle.semiBold.copyWith(
                                color: UIColors.secondaryColor,
                                fontSize: 13,
                              ),
                            ),
                            const TextSpan(
                              text: ' để chọn bạn làm người hướng dẫn trong lần đầu đăng nhập vào MFast',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(height: 33, thickness: 1, color: UIColors.lightGray),
        ),
        SplashButton(
          onTap: () {
            // GlobalFunction.shareText(referral?.cTVText ?? '');
            GlobalFunction.copyText(referral?.cTVText ?? '').then(
                  (_) {
                ToastProvider.instance.showCopy(context: context);
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppImage.asset(asset: 'ic_download2', width: 40, height: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'Mời tham gia bằng liên kết tiếp thị',
                              style: UITextStyle.medium.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const AppImage.asset(asset: 'ic_arrow_right', width: 20, height: 20),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          style: UITextStyle.regular.copyWith(
                            color: UIColors.grayText,
                            fontSize: 13,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Cộng tác viên ',
                            ),
                            TextSpan(
                              text: 'truy cập vào link bạn gửi',
                              style: UITextStyle.semiBold.copyWith(
                                color: UIColors.secondaryColor,
                                fontSize: 13,
                              ),
                            ),
                            const TextSpan(
                              text: ' để tải MFast sẽ mặc định được ghi nhận là cộng tác viên của bạn',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(height: 33, thickness: 1, color: UIColors.lightGray),
        ),
        SplashButton(
          onTap: onGoQrCodeComponent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppImage.asset(asset: 'ic_qr_code', width: 40, height: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'Gửi mã QRCode cài đặt MFast',
                              style: UITextStyle.medium.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const AppImage.asset(asset: 'ic_arrow_right', width: 20, height: 20),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          style: UITextStyle.regular.copyWith(
                            color: UIColors.grayText,
                            fontSize: 13,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Dùng điện thoại của cộng tác viên ',
                            ),
                            TextSpan(
                              text: 'quét mã QRCode này',
                              style: UITextStyle.semiBold.copyWith(
                                color: UIColors.secondaryColor,
                                fontSize: 13,
                              ),
                            ),
                            const TextSpan(
                              text: ' để dẫn tới link cài đặt trên',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
