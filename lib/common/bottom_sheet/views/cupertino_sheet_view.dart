import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/images.dart';

import '../../colors.dart';
import '../../size.dart';

class CupertinoSheetView extends StatefulWidget {
  const CupertinoSheetView({
    Key? key,
    required this.title,
    required this.data,
    this.autoScrollToIndex = false,
    this.initIndex = 0,
  }) : super(key: key);

  final String title;
  final List<String> data;
  final bool autoScrollToIndex;
  final int initIndex;

  @override
  State<CupertinoSheetView> createState() => _CupertinoSheetViewState();
}

class _CupertinoSheetViewState extends State<CupertinoSheetView> {
  late final FixedExtentScrollController _scrollController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = FixedExtentScrollController(initialItem: widget.initIndex);
    _currentIndex = widget.initIndex;

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Future.delayed(const Duration(seconds: 1), () {
    //     _scrollController.jumpToItem(10);
    //   });
    // });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Navigator.of(context).pop(_currentIndex);
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
                _currentIndex = index;
              },
              children: widget.data.map((e) {
                return Center(
                  child: Text(
                    e,
                    style: UITextStyle.regular.copyWith(
                      fontSize: 16,
                      color: UIColors.lightBlack,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
