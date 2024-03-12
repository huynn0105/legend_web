import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../models/general_object.dart';
import '../../colors.dart';
import '../../widgets/buttons.dart';
import '../../widgets/checkbox.dart';
import 'bottom_sheet_view.dart';

class LevelView extends StatefulWidget {
  const LevelView({
    Key? key,
    required this.selectData,
    required this.data,
  }) : super(key: key);

  final List<GeneralObject> selectData;
  final List<GeneralObject> data;

  @override
  State<LevelView> createState() => _LevelViewState();
}

class _LevelViewState extends State<LevelView> {

  late List<GeneralObject> selectedData;

  @override
  void initState() {
    super.initState();
    selectedData = List<GeneralObject>.from(widget.selectData);
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetView(
      title: 'Lọc cộng tác viên',
      enabledOnDone: enabledOnDone,
      closeOnRight: false,
      onDone: () {
        Navigator.of(context).pop(selectedData);
      },
      child: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 16, left: 16, right: 16),
        color: UIColors.background,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 170/24,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final item = widget.data[index];
                final isSelected = selectedData.map((e) => e.code).contains(item.code);
                return SplashButton(
                  onTap: () {
                    onSelected(item);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: IgnorePointer(
                      ignoring: true,
                      child: AppCheckbox.rectangle(
                        value: isSelected,
                        title: item.name ?? '',
                        onChanged: (_) {},
                      ),
                    ),
                  ),
                );
              },
              itemCount: widget.data.length,
            ),
          ],
        ),
      ),
    );
  }

  onSelected(GeneralObject item) {
    bool isSelected = selectedData.firstWhereOrNull((e) => e.code == item.code) != null;
    setState(() {
      if (isSelected) {
        selectedData.removeWhere((e) => e.code == item.code);
      } else {
        selectedData.add(item);
      }
    });
  }

  bool get enabledOnDone => true;//selectedData.isNotEmpty;
}
