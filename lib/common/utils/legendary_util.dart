import 'package:legend_mfast/common/utils/text_util.dart';

import '../../models/legendary/rank_model.dart';

class LegendaryUtil {
  LegendaryUtil._();

  static RankModel getLegendaryRankByTitle(String value) {
    String? title;
    int? star;
    value.splitMapJoin(
      RegExp('[0-9]'),
      onMatch: (match) {
        star = TextUtils.parseInt(match[0]);
        return '';
      },
      onNonMatch: (value) {
        title = '${title ?? ''}$value'.trim();
        return '';
      },
    );
    return RankModel(
      title: title,
      star: star,
    );
  }
}
