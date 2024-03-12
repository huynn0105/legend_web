import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/widgets/legendary_rich_text.dart';

import '../../../../../../../models/legendary/legendary_experience_chart_model.dart';

class LegendaryTooltipWidget extends StatelessWidget {
  const LegendaryTooltipWidget({
    super.key,
    required this.data,
  });

  final List<List<HierNoteModel>> data;

  @override
  Widget build(BuildContext context) {
    final values = convertToTextSpan(data);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: UIColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: values,
      ),
    );
  }

  List<Widget> convertToTextSpan(List<List<HierNoteModel>> data) {
    return data.map(
      (e) {
        return LegendaryRichText(
          data: e,
          prefix: '-',
        );
      },
    ).toList();
  }
}
