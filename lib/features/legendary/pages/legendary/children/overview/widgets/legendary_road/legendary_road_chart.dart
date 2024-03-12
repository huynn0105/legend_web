import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/format_util.dart';
import 'package:legend_mfast/common/widgets/separated_widget.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/widgets/legendary_road/columns/legendary_hier_column.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/widgets/legendary_road/legendary_road_column.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../../../../../models/legendary/hier_rank_chart_model.dart';
import '../../../../../../../../models/legendary/legendary_road_chart_model.dart';

class LegendaryRoadChart extends StatefulWidget {
  const LegendaryRoadChart({
    super.key,
    required this.data,
    required this.month,
    required this.gender,
    required this.isMyLegendaryHier,
  });

  final LegendaryRoadChartModel? data;
  final int month;
  final String? gender;
  final bool isMyLegendaryHier;

  @override
  State<LegendaryRoadChart> createState() => _LegendaryRoadChartState();
}

class _LegendaryRoadChartState extends State<LegendaryRoadChart> {
  late final AutoScrollController autoScrollController;

  bool hasAutoScrolled = false;

  double minHeight = 30;
  double maxHeight = 50;
  double minWidth = 86;
  double smallWidth = 30;
  double bottomSpacing = 40;

  int maxCount = 10;

  String currentRankLevel = '';
  List<int> numCollaborators = [];
  List<MapEntry<String, HierRankChartModel>> details = [];

  @override
  void initState() {
    super.initState();
    autoScrollController = AutoScrollController();
    onInitializedData(widget);
  }

  @override
  void dispose() {
    autoScrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LegendaryRoadChart oldWidget) {
    onUpdatedData(oldWidget, widget);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    ///
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: bottomSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              LegendaryRoadColumn(
                itemCount: maxCount,
                crossAxisAlignment: CrossAxisAlignment.end,
                itemBuilder: (context, index, isFirst, isLast) {
                  if (index == 0) {
                    return Container(
                      constraints: BoxConstraints(
                        minWidth: smallWidth,
                      ),
                      height: isFirst ? minHeight : maxHeight,
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Bạn',
                        style: UITextStyle.semiBold.copyWith(
                          fontSize: 14,
                          color: UIColors.darkBlue,
                        ),
                      ),
                    );
                  }
                  if (index == 8) {
                    return SizedBox(
                      width: minHeight,
                      height: maxHeight,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            right: -35,
                            bottom: 5,
                            child: Text(
                              'Phân tầng\nvà số CTV',
                              style: UITextStyle.regular.copyWith(
                                fontSize: 14,
                                color: UIColors.grayText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (index > numCollaborators.length) {
                    return const SizedBox();
                  }
                  final item = numCollaborators[index - 1];
                  return Container(
                    constraints: const BoxConstraints(
                      minWidth: 30,
                    ),
                    height: maxHeight,
                    alignment: Alignment.centerRight,
                    child: Text(
                      FormatUtil.doubleFormat(item.toDouble()),
                      style: UITextStyle.semiBold.copyWith(
                        fontSize: 14,
                        color: UIColors.darkBlue,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  );
                },
                separatorBuilder: (_, __) => const Divider(
                  height: 1,
                  thickness: 2,
                  color: UIColors.white,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              LegendaryRoadColumn(
                itemCount: maxCount,
                itemBuilder: (context, index, isFirst, isLast) {
                  if (index > 7) {
                    return SizedBox(
                      width: 25,
                      height: maxHeight,
                    );
                  }
                  return Container(
                    width: 25,
                    height: isFirst ? minHeight : maxHeight,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: UIColors.darkBlue,
                      borderRadius: BorderRadius.only(
                        topLeft: index == 7 ? const Radius.circular(4) : Radius.zero,
                        topRight: index == 7 ? const Radius.circular(4) : Radius.zero,
                        bottomLeft: isFirst ? const Radius.circular(4) : Radius.zero,
                        bottomRight: Radius.zero,
                      ),
                    ),
                    child: index <= 6
                        ? Text(
                            '$index',
                            style: UITextStyle.bold.copyWith(
                              color: UIColors.white,
                            ),
                          )
                        : const Icon(
                            Icons.arrow_upward_rounded,
                            size: 20,
                            color: UIColors.white,
                          ),
                  );
                },
                separatorBuilder: (_, __) => const Divider(
                  height: 1,
                  thickness: 2,
                  color: UIColors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                controller: autoScrollController,
                padding: const EdgeInsets.only(left: 1),
                scrollDirection: Axis.horizontal,
                child: SeparatedRow(
                  mainAxisAlignment: MainAxisAlignment.start,
                  separatorBuilder: (_, __) => const SizedBox(width: 1),
                  children: List.generate(
                    details.length,
                    (index) {
                      final item = details[index];
                      final value = item.value;
                      return AutoScrollTag(
                        index: index,
                        key: ValueKey(index),
                        controller: autoScrollController,
                        child: SizedBox(
                          width: minWidth,
                          child: LegendaryHierColumn(
                            data: value,
                            month: widget.month,
                            gender: widget.gender,
                            level: currentRankLevel,
                            commissionInit: widget.data?.commissionInit ?? 0,
                            hierIndex: index,
                            hierLength: details.length,
                            maxCount: maxCount,
                            minHeight: minHeight,
                            maxHeight: maxHeight,
                            minWidth: minWidth,
                            isMyLegendaryHier: widget.isMyLegendaryHier,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: bottomSpacing,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Tổng thu nhập',
                        style: UITextStyle.regular.copyWith(
                          fontSize: 14,
                          color: UIColors.grayText,
                        ),
                      ),
                    ),
                    Text(
                      FormatUtil.currencyDoubleFormat(widget.data?.commission),
                      style: UITextStyle.bold.copyWith(
                        fontSize: 16,
                        color: UIColors.defaultText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onInitializedData(LegendaryRoadChart widget) {
    numCollaborators = widget.data?.amountCollaborator ?? <int>[];
    details = widget.data?.detail?.entries.toList() ?? <MapEntry<String, HierRankChartModel>>[];
    currentRankLevel = widget.data?.rank?.level?.level ?? '';
  }

  void onUpdatedData(LegendaryRoadChart oldWidget, LegendaryRoadChart widget) {
    onInitializedData(widget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final oldDetails = oldWidget.data?.detail?.entries.toList() ?? <MapEntry<String, HierRankChartModel>>[];
      final oleRankLevel = oldWidget.data?.rank?.level?.level ?? '';
      final oldActiveIndex = oldDetails.indexWhere((e) => e.key == oleRankLevel);

      final newActiveIndex = details.indexWhere((e) => e.key == currentRankLevel);

      if (oldActiveIndex != newActiveIndex && newActiveIndex >= 0 && !hasAutoScrolled) {
        hasAutoScrolled = true;
        autoScrollController.scrollToIndex(
          newActiveIndex,
          preferPosition: AutoScrollPosition.middle,
          duration: const Duration(milliseconds: 500),
        );
      }
    });
  }
}
