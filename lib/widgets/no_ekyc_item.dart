import 'package:flutter/material.dart';

import '../../widgets/no_information_widget.dart';

class NoEkycItem extends StatelessWidget {
  const NoEkycItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoInformationWidget(
      asset: "ic_no_ekyc",
      title: "Bạn chưa định danh tài khoản.",
      content: "Thông tin định danh giúp bảo vệ tài khoản,"
          " rút tiền và được mở các tính năng, nghiệp vụ bán hàng nâng cao",
      titleButton: "Định danh ngay",
      onTap: () {
        // context.router.push(const MFastAccountIdentificationRoute());
      },
    );
  }
}
