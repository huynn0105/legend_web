import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/color_util.dart';

import '../../../../../../../common/global_function.dart';
import '../../../../../../../models/legendary/legendary_experience_chart_model.dart';

class LegendaryRichText extends StatelessWidget {
  const LegendaryRichText({
    super.key,
    required this.data,
    this.prefix = '',
  });

  final List<HierNoteModel> data;
  final String prefix;

  @override
  Widget build(BuildContext context) {
    final hasPrefix = prefix.isNotEmpty;
    final items = List.generate(
      data.length,
      (index) {
        final item = data[index];
        final isLast = index == data.length - 1;
        final space = isLast ? '' : ' ';
        final text = item.text ?? '';
        final url = item.url ?? '';

        ///
        return TextSpan(
          text: '${item.text ?? ' '}$space',
          style: item.bold == true
              ? UITextStyle.bold.copyWith(
                  fontSize: 13,
                  color: ColorUtil.fromHex(item.color ?? ''),
                )
              : UITextStyle.regular.copyWith(
                  fontSize: 13,
                  color: ColorUtil.fromHex(item.color ?? ''),
                ),
          recognizer: url.isEmpty ? null : TapGestureRecognizer()
            ?..onTap = () {
              GlobalFunction.pushWebView(url: url);
            },
        );
      },
    );
    if (hasPrefix) {
      items.insert(
        0,
        TextSpan(
          text: '$prefix ',
          style: UITextStyle.regular.copyWith(
            color: UIColors.grayText,
          ),
        ),
      );
    }
    return RichText(
      text: TextSpan(
        children: items,
      ),
    );
  }
}
