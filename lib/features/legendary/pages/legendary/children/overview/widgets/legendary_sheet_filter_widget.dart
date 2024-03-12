import 'package:flutter/material.dart';
import 'package:legend_mfast/common/bottom_sheet/bottom_sheet_provider.dart';
import 'package:legend_mfast/common/bottom_sheet/wrapper/data_wrapper.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/widgets/images.dart';

import '../../../../../../../common/widgets/buttons.dart';

class LegendarySheetFilterWidget extends StatelessWidget {
  const LegendarySheetFilterWidget({
    super.key,
    required this.data,
    required this.selectedItem,
    required this.sheetTitle,
    this.onSelected,
    this.onShowCustomSheet,
    this.onDateWrapperUpdated,
  });

  final List<DataWrapper> data;
  final DataWrapper? selectedItem;
  final String sheetTitle;
  final Function(DataWrapper)? onSelected;
  final Function(BuildContext context, List<DataWrapper>)? onShowCustomSheet;
  final List<DataWrapper>? Function(List<DataWrapper>)? onDateWrapperUpdated;

  @override
  Widget build(BuildContext context) {
    return SplashButton(
      onTap: () => _onShowSheet(context),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: UIColors.white,
          border: Border.all(
            color: UIColors.lightGray,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const AppImage.asset(
              asset: 'ic_mfast_filter',
              width: 24,
              height: 24,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                selectedItem?.value ?? '---',
                style: UITextStyle.semiBold.copyWith(
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onShowSheet(BuildContext context) async {
    final data = onDateWrapperUpdated?.call([...this.data]) ?? this.data;

    final result = await BottomSheetProvider.instance.showCupertinoWrapperPicker(
      context,
      title: sheetTitle,
      data: data,
      selectedItem: selectedItem,
    );
    if (result != null) {
      onSelected?.call(result);
    }
  }
}
