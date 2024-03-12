import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/widgets/app_scroll_bar.dart';
import 'package:legend_mfast/common/widgets/images.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/widgets/legendary_rich_text.dart';

import '../../../../../../../models/legendary/legendary_experience_chart_model.dart';

class LegendaryChartDetailWidget extends StatefulWidget {
  const LegendaryChartDetailWidget({
    super.key,
    required this.data,
  });

  final List<List<HierNoteModel>> data;

  @override
  State<LegendaryChartDetailWidget> createState() => _LegendaryChartDetailWidgetState();
}

class _LegendaryChartDetailWidgetState extends State<LegendaryChartDetailWidget> {
  late final ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final values = convertToTextSpan(widget.data);
    return Container(
      height: 160,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: UIColors.purple,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10, right: 10),
            child: AppImage.asset(
              asset: 'ic_mfast_light_idea',
              width: 32,
              height: 32,
            ),
          ),
          Expanded(
            child: AppScrollBar.light(
              controller: controller,
              child: ListView.separated(
                controller: controller,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 10),
                separatorBuilder: (_, __) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  return values[index];
                },
                itemCount: values.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> convertToTextSpan(List<List<HierNoteModel>> data) {
    return data.map(
      (e) {
        return LegendaryRichText(
          data: e,
          prefix: '',
        );
      },
    ).toList();
  }
}
