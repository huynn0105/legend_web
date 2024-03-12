import 'package:flutter/material.dart';

import '../../../colors.dart';
import '../../../styles.dart';
import '../../images.dart';

class CustomCurrentLocationMarker extends StatelessWidget {
  const CustomCurrentLocationMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: UIColors.darkBlue,
              ),
              margin: const EdgeInsets.only(bottom: 9),
              padding: const EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
              child: Text(
                'Vị trí hiện tại',
                style: UITextStyle.semiBold.copyWith(
                  fontSize: 24,
                  color: UIColors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 2,
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(45 / 360),
                child: Container(
                  color: UIColors.darkBlue,
                  height: 16,
                  width: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 9,),
        const AppImage.asset(
          asset: 'ic_marker',
          width: 60,
          height: 60,
        ),
      ],
    );
  }
}
