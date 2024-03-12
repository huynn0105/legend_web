import 'dart:math';

import 'package:flutter/material.dart';
import 'package:legend_mfast/models/general_object.dart';

import '../../../../../common/colors.dart';
import '../../../../../common/styles.dart';
import '../../../../../common/widgets/buttons.dart';
import '../../../../../common/widgets/images.dart';

class RSMFilterTag extends StatelessWidget {
  const RSMFilterTag({super.key, this.data = const [], this.onDeleted});

  final Function(GeneralObject)? onDeleted;
  final List<GeneralObject> data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          max(0, data.length * 2 - 1),
          (index) {
            if (index.isOdd) {
              return const SizedBox(width: 8);
            }
            index = index ~/ 2;
            return Container(
              height: 32,
              padding: const EdgeInsets.only(left: 12, right: 6),
              decoration: BoxDecoration(
                color: UIColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data[index].name ?? '',
                    style: UITextStyle.medium,
                  ),
                  // const SizedBox(
                  //   width: 7,
                  // ),
                  // SplashButton(
                  //   onTap: () => onDeleted?.call(data[index]),
                  //   child: const AppImage.asset(
                  //     asset: 'ic_close',
                  //     width: 20,
                  //     height: 20,
                  //   ),
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
