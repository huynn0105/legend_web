import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../size.dart';
import '../../styles.dart';
import '../../widgets/buttons.dart';
import '../../widgets/images.dart';
import '../../widgets/widget_layout.dart';
import '../wrapper/data_wrapper.dart';

class CupertinoWrapperSheetView extends StatefulWidget {
  const CupertinoWrapperSheetView({
    Key? key,
    required this.title,
    required this.data,
    this.selectedItem,
    this.initIndex = 0,
    this.autoScrollToIndex = false,
  }) : super(key: key);

  final String title;
  final List<DataWrapper> data;
  final DataWrapper? selectedItem;
  final bool autoScrollToIndex;
  final int initIndex;

  @override
  State<CupertinoWrapperSheetView> createState() => _CupertinoWrapperSheetViewState();
}

class _CupertinoWrapperSheetViewState extends State<CupertinoWrapperSheetView> {
  late final FixedExtentScrollController _scrollController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    final selectedIndex = widget.data.indexWhere((e) => e.id == widget.selectedItem?.id);
    if (selectedIndex >= 0) {
      _currentIndex = selectedIndex;
    } else {
      _currentIndex = widget.initIndex;
    }
    _scrollController = FixedExtentScrollController(initialItem: _currentIndex);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetLayout(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SplashButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const SizedBox(
                      width: 48,
                      height: 48,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AppImage.asset(
                          asset: "ic_close",
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.title,
                        style: UITextStyle.medium.copyWith(
                          fontSize: 16,
                          color: UIColors.grayText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SplashButton(
                    onTap: () {
                      Navigator.of(context).pop(widget.data[_currentIndex]);
                    },
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Chọn",
                          style: UITextStyle.bold.copyWith(
                            fontSize: 14,
                            color: UIColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: AppSize.instance.height / 2.5,
              child: CupertinoPicker(
                backgroundColor: UIColors.lightGray,
                scrollController: _scrollController,
                diameterRatio: 1.5,
                itemExtent: 43,
                selectionOverlay: Container(
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: UIColors.gray,
                      ),
                    ),
                  ),
                ),
                onSelectedItemChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: List.generate(
                  widget.data.length,
                  (index) {
                    final item = widget.data[index];
                    final isFocus = _currentIndex == index;
                    return Center(
                      child: Text(
                        item.value ?? '',
                        style: isFocus
                            ? UITextStyle.bold.copyWith(
                                fontSize: 16,
                                color: UIColors.defaultText,
                              )
                            : UITextStyle.regular.copyWith(
                                fontSize: 16,
                                color: UIColors.lightBlack,
                              ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
