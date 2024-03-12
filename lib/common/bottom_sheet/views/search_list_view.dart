import 'package:flutter/material.dart';
import 'package:legend_mfast/common/widgets/widget_layout.dart';

import '../../../../../../common/colors.dart';
import '../../../../../../common/styles.dart';
import '../../../../../../common/widgets/buttons.dart';
import '../../utils/vietnamese_util.dart';
import '../../widgets/mtrade_text_field.dart';
import '../wrapper/data_wrapper.dart';

class SearchListView extends StatefulWidget {
  const SearchListView({
    Key? key,
    required this.id,
    required this.data,
  }) : super(key: key);

  final String id;
  final List<DataWrapper> data;

  @override
  State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
  final double size = 45.0;
  late List<DataWrapper> data;
  late final ScrollController _scrollController;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    data = widget.data;
    _searchController = TextEditingController();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final int index = widget.data.indexWhere((e) => e.id == widget.id);
      if (index >= 0) {
        _scrollController.jumpTo(index * size);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WidgetLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: MTradeSearchTextField(
              controller: _searchController,
              hintText: "Tìm kiếm",
              textAlign: TextAlign.center,
              onChanged: onChanged,
            ),
          ),
          Flexible(
            child: SizedBox(
              height: 360,
              child: ListView.builder(
                controller: _scrollController,
                itemExtent: size,
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 100),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final item = data[index];
                  final isSelected = item.id == widget.id;
                  return SplashButton(
                    onTap: () {
                      Navigator.of(context).pop(item);
                    },
                    child: Container(
                      height: size,
                      alignment: Alignment.center,
                      child: Text(
                        item.value ?? "",
                        textAlign: TextAlign.center,
                        style: isSelected
                            ? UITextStyle.bold.copyWith(fontSize: 16)
                            : UITextStyle.regular.copyWith(fontSize: 16, color: UIColors.grayText),
                      ),
                    ),
                  );
                },
                itemCount: data.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  onChanged(String value) {
    if (value.isNotEmpty) {
      setState(() {
        data = widget.data.where((e) {
          String query = VietnameseUtils.toEnglish(value).toLowerCase();
          String data = VietnameseUtils.toEnglish(e.value ?? "").toLowerCase();
          return data.toLowerCase().contains(query) == true;
        }).toList();
      });
    } else {
      setState(() {
        data = widget.data;
      });
    }
  }
}
