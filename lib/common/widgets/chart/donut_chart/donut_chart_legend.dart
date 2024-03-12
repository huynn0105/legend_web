import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/donut_chart_helper.dart';
import 'package:legend_mfast/common/widgets/chart/donut_chart/growth_icon_widget.dart';
import 'package:legend_mfast/common/widgets/html_widget.dart';
import 'package:legend_mfast/common/widgets/images.dart';

import '../../../colors.dart';
import '../../../styles.dart';
import '../../../utils/format_util.dart';
import '../../buttons.dart';
import 'donut_chart_controller.dart';
import 'donut_chart_data.dart';

class DonutChartLegend extends StatefulWidget {
  const DonutChartLegend({
    Key? key,
    required this.controller,
    required this.onDisplayLabel,
    this.enableFocus = true,
    this.enableShowLoading = true,
    this.padding = EdgeInsets.zero,
    this.onTapLabel,
    this.emptyBuidler,
  }) : super(key: key);

  final DonutChartController controller;
  final String Function(DonutChartSectionData section) onDisplayLabel;
  final bool enableFocus;
  final bool enableShowLoading;
  final EdgeInsets padding;
  final Function(int index)? onTapLabel;
  final Function()? emptyBuidler;

  @override
  State<DonutChartLegend> createState() => _DonutChartLegendState();
}

class _DonutChartLegendState extends State<DonutChartLegend> {
  late final DonutChartController chartController;

  @override
  void initState() {
    super.initState();
    chartController = widget.controller;
    chartController.addListener(onListen);
  }

  @override
  void dispose() {
    chartController.removeListener(onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const int crossAxisCount = 2;
    final DonutChartData data = widget.enableShowLoading ? chartController.getData() : chartController.data;
    final int length = data.sections.length;
    final int indexToFocus = data.indexToFocus;
    final List<DonutChartSectionData> sections = data.sections;
    final List<double> percents = data.calculateSectionPercents();

    ///
    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: chartController.action.duration,
      child: chartController.getData().isLoading && widget.enableShowLoading
          ? const SizedBox(
              height: 30,
              width: double.infinity,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            )
          : Padding(
              padding: sections.isEmpty ? EdgeInsets.zero : widget.padding,
              child: chartController.action.isEmpty
                  ? widget.emptyBuidler != null
                      ? widget.emptyBuidler!()
                      : const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: AppImage.asset(
                              asset: "ic_no_balance",
                              width: 120,
                              height: 120,
                            ),
                          ),
                        )
                  : AlignedGridView.count(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: crossAxisCount,
                      itemCount: sections.length,
                      itemBuilder: (context, index) {
                        final section = sections[index];
                        return DonutChartLegendItem(
                          index: index,
                          length: length,
                          crossAxisCount: crossAxisCount,
                          label: section.label,
                          unit: section.unit,
                          value: widget.onDisplayLabel(section),
                          color: section.color,
                          percent: percents[index],
                          isFocus: widget.enableFocus && indexToFocus == index,
                          legendData: section.legendData,
                          onTap: () {
                            chartController.focus(index);
                          },
                          onTapLabel: widget.onTapLabel != null
                              ? () {
                                  widget.onTapLabel?.call(index);
                                }
                              : null,
                        );
                      },
                    ),
            ),
    );
  }

  onListen() {
    if (!mounted) {
      return;
    }
    final actions = [
      DonutChartAction.show,
      DonutChartAction.focus,
      DonutChartAction.empty,
    ];
    if (actions.contains(chartController.action)) {
      setState(() {});
    }
  }
}

class DonutChartLegendItem extends StatelessWidget {
  const DonutChartLegendItem({
    Key? key,
    required this.index,
    required this.length,
    required this.crossAxisCount,
    required this.percent,
    required this.label,
    required this.unit,
    required this.value,
    required this.color,
    this.isFocus = false,
    this.onTap,
    this.legendData,
    this.onTapLabel,
  }) : super(key: key);

  final int index;
  final int length;
  final int crossAxisCount;
  final String label;
  final String unit;
  final String value;
  final Color color;
  final double percent;
  final bool isFocus;
  final VoidCallback? onTap;
  final DonutChartLegendSectionData? legendData;
  final VoidCallback? onTapLabel;

  @override
  Widget build(BuildContext context) {
    const double radius = 10;
    final int col = index % crossAxisCount;
    final int row = index ~/ crossAxisCount;
    final int rows = getRows(length, crossAxisCount);
    return AppSplashButton(
      isDisable: onTap == null,
      onTap: onTap,
      child: Material(
        color: isFocus ? UIColors.primaryColor.withOpacity(0.1) : UIColors.white,
        clipBehavior: Clip.antiAlias,
        shape: BeveledRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.only(
            topLeft: (row > 0) && (col > 0) ? const Radius.circular(radius) : Radius.zero,
            topRight: (row > 0) && col < (crossAxisCount - 1) ? const Radius.circular(radius) : Radius.zero,
            bottomLeft: (row < rows - 1) && (col > 0) ? const Radius.circular(radius) : Radius.zero,
            bottomRight: (row < rows - 1) && (col < crossAxisCount - 1) ? const Radius.circular(radius) : Radius.zero,
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(
            right: col < crossAxisCount - 1 ? radius : 0,
            left: col > 0 ? radius : 0,
            top: radius,
            bottom: radius,
          ),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                width: 1,
                color: col < crossAxisCount - 1 ? UIColors.lightGray : Colors.transparent,
              ),
              bottom: BorderSide(
                width: 1,
                color: row < rows - 1 ? UIColors.lightGray : Colors.transparent,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipPath(
                    clipBehavior: Clip.hardEdge,
                    clipper: const ArcClipper(),
                    child: Container(
                      width: 30,
                      height: 20,
                      color: color,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    "${FormatUtil.doubleFormat(percent.round().toDouble())}%",
                    style: UITextStyle.regular.copyWith(
                      fontSize: 14,
                      color: UIColors.grayText,
                      height: 1.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  if (legendData != null) ...[
                    DonutGrowthWidget(
                      data: legendData!,
                    ),
                  ],
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                value,
                style: UITextStyle.medium.copyWith(
                  fontSize: 16,
                  height: 1.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SplashButton(
                isDisabled: onTapLabel == null,
                onTap: onTapLabel,
                child: HtmlWidget(
                  data: label,
                  lineHeight: 1.2,
                  textColor: UIColors.grayText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int getRows(int length, int crossAxisCount) {
    if (length % crossAxisCount == 0) {
      return (length ~/ crossAxisCount);
    } else {
      return (length ~/ crossAxisCount) + 1;
    }
  }
}

class ArcClipper extends CustomClipper<Path> {
  const ArcClipper();

  @override
  Path getClip(Size size) {
    final w = size.width, h = size.height;

    var path = Path()
      ..moveTo(0, h / 2)
      ..lineTo(w - h / 2, 0)
      ..quadraticBezierTo(w, h / 2, w - h / 2, h)
      ..lineTo(0, h / 2);

    return path;
  }

  @override
  bool shouldReclip(covariant oldClipper) => false;
}

class DonutGrowthWidget extends StatelessWidget {
  const DonutGrowthWidget({
    super.key,
    required this.data,
  });

  final DonutChartLegendSectionData data;

  @override
  Widget build(BuildContext context) {
    if (data.growthValue <= 0) {
      return const SizedBox();
    }

    final isUp = data.getStatus() == DonutLegendGrowthStatus.up;
    final upColor = getColor(DonutLegendGrowthStatus.up);
    final downColor = getColor(DonutLegendGrowthStatus.down);
    final valueColor = getColor(data.getStatus());

    ///
    return Row(
      children: [
        GrowthIcon(
          isUp: isUp,
          upColor: upColor,
          downColor: downColor,
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          "${FormatUtil.doubleFormat(data.growthValue.round().toDouble())}%",
          style: UITextStyle.semiBold.copyWith(
            fontSize: 13,
            color: valueColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Color? getColor(DonutLegendGrowthStatus? status) {
    final map = {
      DonutLegendGrowthStatus.up: UIColors.green,
      DonutLegendGrowthStatus.down: UIColors.red,
    };
    return map[status];
  }

  IconData? getIcon(DonutLegendGrowthStatus? status) {
    final map = {
      DonutLegendGrowthStatus.up: Icons.arrow_upward_rounded,
      DonutLegendGrowthStatus.down: Icons.arrow_downward_rounded,
    };
    return map[status];
  }
}
