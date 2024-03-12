import 'package:flutter/material.dart';
import 'package:legend_mfast/common/widgets/separated_widget.dart';

class LegendaryRoadColumn extends StatelessWidget {
  const LegendaryRoadColumn({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index, bool isFirst, bool isLast) itemBuilder;
  final Widget Function(BuildContext context, int index) separatorBuilder;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: SeparatedColumn(
        verticalDirection: VerticalDirection.up,
        separatorBuilder: separatorBuilder,
        crossAxisAlignment: crossAxisAlignment,
        children: List.generate(
          itemCount,
          (index) {
            return itemBuilder(
              context,
              index,
              index == 0,
              index == itemCount - 1,
            );
          },
        ),
      ),
    );
  }
}
