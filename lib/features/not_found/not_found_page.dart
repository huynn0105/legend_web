import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../common/styles.dart';
import '../../../../common/widgets/images.dart';

@RoutePage()
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            const AppImage.asset(
              asset: 'ic_404',
              width: 200,
              height: 150,
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Liên kết không tồn tại, vui lòng liên hệ nhân viên tư vấn để được hỗ trợ.',
                style: UITextStyle.medium.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
