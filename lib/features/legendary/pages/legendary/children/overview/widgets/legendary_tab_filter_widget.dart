import 'package:flutter/material.dart';
import 'package:legend_mfast/common/bottom_sheet/wrapper/data_wrapper.dart';
import 'package:legend_mfast/common/colors.dart';

import '../../../../../../../widgets/selector_item.dart';

class LegendaryTabFilterWidget extends StatelessWidget {
  const LegendaryTabFilterWidget({
    super.key,
    required this.data,
    required this.selectedItem,
    required this.onSelected,
    this.padding = EdgeInsets.zero,
    this.itemBackgroundColor = UIColors.white,
  });

  final List<DataWrapper> data;
  final DataWrapper? selectedItem;
  final Function(DataWrapper) onSelected;
  final Color itemBackgroundColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Visibility(
        visible: data.isNotEmpty,
        child: ListView.separated(
          padding: padding,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final item = data[index];
            final isSelected = item.id == selectedItem?.id;
            return SelectorItem.rounded(
              title: item.value ?? '',
              isSelected: isSelected,
              height: 32,
              backgroundColor: itemBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              onTap: () => onSelected(item),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemCount: data.length,
        ),
      ),
    );
  }
}
