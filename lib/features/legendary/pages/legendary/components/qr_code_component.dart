import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrCodeComponent extends StatelessWidget {
  const QrCodeComponent({
    Key? key,
    required this.data,
    this.title = "Dùng điện thoại của khách hàng quét mã QRCode này để dẫn tới Website bán hàng của bạn",
  }) : super(key: key);

  final String data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: UITextStyle.regular.copyWith(
              fontSize: 14,
              color: UIColors.grayText,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: 240,
            height: 240,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: UIColors.white,
            ),
            child: PrettyQr(
              size: 220,
              data: data,
              elementColor: UIColors.darkBlue,
              errorCorrectLevel: QrErrorCorrectLevel.M,
              roundEdges: true,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: UITextStyle.medium.copyWith(
                fontSize: 16,
                color: UIColors.grayText,
              ),
              children: [
                const TextSpan(
                  text: "Quét bằng ",
                ),
                TextSpan(
                  text: "ứng dụng Zalo ",
                  style: UITextStyle.medium.copyWith(
                    fontSize: 16,
                    color: UIColors.darkBlue,
                  ),
                ),
                const TextSpan(
                  text: "hoặc ",
                ),
                TextSpan(
                  text: "Máy ảnh mặc định của điện thoại",
                  style: UITextStyle.medium.copyWith(
                    fontSize: 16,
                    color: UIColors.darkBlue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
