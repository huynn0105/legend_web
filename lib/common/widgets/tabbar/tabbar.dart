import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/common/widgets/app_layout.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/images.dart';
import 'package:legend_mfast/common/widgets/widget_layout.dart';

import '../../colors.dart';
import '../../styles.dart';
import 'tabbar_decoration.dart';
import 'tile_data.dart';

class RoundedIndicatorTabbar extends StatefulWidget {
  const RoundedIndicatorTabbar({
    Key? key,
    required this.controller,
    required this.titles,
    this.height = 40,
    this.width,
    this.margin = EdgeInsets.zero,
    this.backgroundColor = UIColors.white,
    this.onTap,
    this.initIndex,
  }) : super(key: key);

  final TabController controller;
  final List<String> titles;
  final double height;
  final double? width;
  final EdgeInsets margin;
  final Color backgroundColor;
  final Function(int index)? onTap;
  final int? initIndex;

  @override
  State<RoundedIndicatorTabbar> createState() => _RoundedIndicatorTabbarState();
}

class _RoundedIndicatorTabbarState extends State<RoundedIndicatorTabbar> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initIndex != null) {
        widget.onTap?.call(widget.initIndex!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.height / 2),
      ),
      child: TabBar(
        controller: widget.controller,
        labelPadding: EdgeInsets.zero,
        indicatorColor: Colors.transparent,
        indicator: RectangularIndicator(
          color: UIColors.primaryColor,
          borderRadius: BorderRadius.circular(widget.height / 2),
        ),
        labelColor: UIColors.white,
        labelStyle: UITextStyle.medium,
        unselectedLabelColor: UIColors.grayText,
        unselectedLabelStyle: UITextStyle.medium,
        splashBorderRadius: BorderRadius.circular(widget.height / 2),
        onTap: (index) {
          FocusManager.instance.primaryFocus?.unfocus();
          widget.onTap?.call(index);
        },
        tabs: widget.titles.map((e) {
          if (widget.width != null) {
            return SizedBox(
              width: widget.width,
              child: Tab(text: e),
            );
          }
          return Tab(text: e);
        }).toList(),
      ),
    );
  }
}

class UnderlineIndicatorTabbar extends StatefulWidget {
  const UnderlineIndicatorTabbar({
    Key? key,
    required this.controller,
    required this.titles,
    this.icons,
    this.height = 40,
    this.width,
    this.margin = EdgeInsets.zero,
    this.backgroundColor = UIColors.white,
    this.onTap,
    this.initIndex,
  }) : super(key: key);

  final TabController controller;
  final List<String> titles;
  final List<Widget>? icons;
  final double height;
  final double? width;
  final EdgeInsets margin;
  final Color backgroundColor;
  final Function(int index)? onTap;
  final int? initIndex;

  @override
  State<UnderlineIndicatorTabbar> createState() => _UnderlineIndicatorTabbarState();
}

class _UnderlineIndicatorTabbarState extends State<UnderlineIndicatorTabbar> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initIndex != null) {
        widget.onTap?.call(widget.initIndex!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WidgetLayout(
      child: Container(
        height: widget.height,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          border: const Border(
            bottom: BorderSide(
              color: UIColors.gray,
            ),
          ),
        ),
        child: TabBar(
          controller: widget.controller,
          labelPadding: EdgeInsets.zero,
          indicatorColor: Colors.transparent,
          indicator: UnderlineTabIndicator(
            borderRadius: BorderRadius.circular(1),
            borderSide: const BorderSide(
              width: 2,
              color: UIColors.primaryColor,
            ),
          ),
          labelColor: UIColors.primaryColor,
          labelStyle: UITextStyle.bold,
          unselectedLabelColor: UIColors.grayText,
          unselectedLabelStyle: UITextStyle.medium,
          onTap: (index) {
            FocusManager.instance.primaryFocus?.unfocus();
            widget.onTap?.call(index);
          },
          tabs: widget.titles.mapIndexed((index, e) {
            return Stack(
              children: [
                SizedBox(
                  width: widget.width ?? double.infinity,
                  child: Tab(
                    text: e,
                    icon: widget.icons?[index],
                  ),
                ),
                Container(
                  width: widget.width ?? double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: index == widget.titles.length - 1
                        ? null
                        : const Border(
                            right: BorderSide(
                              color: UIColors.lightGray,
                              width: 0.8,
                            ),
                          ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class SingleRoundedIndicatorTabbar extends StatefulWidget {
  const SingleRoundedIndicatorTabbar({
    Key? key,
    required this.controller,
    required this.titles,
    this.height = 40,
    this.width,
    this.margin = EdgeInsets.zero,
    this.backgroundColor = UIColors.white,
    this.onTap,
    this.initIndex,
  }) : super(key: key);

  final TabController controller;
  final List<String> titles;
  final double height;
  final double? width;
  final EdgeInsets margin;
  final Color backgroundColor;
  final Function(int index)? onTap;
  final int? initIndex;

  @override
  State<SingleRoundedIndicatorTabbar> createState() => _SingleRoundedIndicatorTabbarState();
}

class _SingleRoundedIndicatorTabbarState extends State<SingleRoundedIndicatorTabbar> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initIndex ?? 0;
    widget.controller.addListener(() {
      setState(() {
        selectedIndex = widget.controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      margin: widget.margin,
      decoration: BoxDecoration(
        // color: backgroundColor,
        borderRadius: BorderRadius.circular(widget.height / 2),
      ),
      child: TabBar(
        isScrollable: true,
        controller: widget.controller,
        labelPadding: EdgeInsets.zero,
        indicator: const BoxDecoration(),
        labelColor: UIColors.white,
        labelStyle: UITextStyle.medium,
        unselectedLabelColor: UIColors.grayText,
        unselectedLabelStyle: UITextStyle.medium,
        splashBorderRadius: BorderRadius.circular(widget.height / 2),
        onTap: (index) {
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {
            selectedIndex = index;
          });
        },
        tabs: widget.titles.mapIndexed((index, e) {
          if (widget.width != null) {
            return SizedBox(
              width: widget.width,
              child: Tab(text: e),
            );
          }
          final bool isActive = index == selectedIndex;

          return Tab(
            child: Container(
              height: 32,
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isActive ? UIColors.primaryColor : UIColors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(child: Text(e)),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class UnderlineIconIndicatorTabbar extends StatefulWidget {
  const UnderlineIconIndicatorTabbar({
    Key? key,
    required this.controller,
    required this.tiles,
    this.height = 88,
    this.width,
    this.initIndex,
    this.margin = EdgeInsets.zero,
    this.backgroundColor = UIColors.white,
    this.itemWidth,
    this.minItemWidth,
    this.onIndexSelected,
    this.onValueSelected,
    this.activeColor = UIColors.primaryColor,
    this.inactiveColor = UIColors.grayText,
    this.showActiveIconColor = true,
    this.isScrollable = true,
    this.maxLinesTitle,
    this.iconSize = 24,
  }) : super(key: key);

  final TabController controller;
  final List<TileData> tiles;
  final double height;
  final double? width;
  final EdgeInsets margin;
  final Color backgroundColor;
  final int? initIndex;
  final double? itemWidth;
  final double? minItemWidth;
  final bool isScrollable;
  final int? maxLinesTitle;
  final double iconSize;

  final Color activeColor;
  final Color inactiveColor;
  final bool showActiveIconColor;
  final Function(String)? onValueSelected;
  final Function(int)? onIndexSelected;

  @override
  State<UnderlineIconIndicatorTabbar> createState() => _UnderlineIconIndicatorTabbarState();
}

class _UnderlineIconIndicatorTabbarState extends State<UnderlineIconIndicatorTabbar> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initIndex ?? 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onIndexSelected?.call(selectedIndex);
      widget.controller.addListener(() {
        if (selectedIndex != widget.controller.index) {
          setState(() {
            selectedIndex = widget.controller.index;
          });
        }
      });
    });
  }

  @override
  void didUpdateWidget(covariant UnderlineIconIndicatorTabbar oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: UIColors.extraLightGray,
          ),
        ),
      ),
      child: Container(
        height: widget.height,
        margin: widget.margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.height / 2),
          color: widget.backgroundColor,
        ),
        child: TabBar(
          isScrollable: widget.isScrollable,
          controller: widget.controller,
          labelPadding: EdgeInsets.zero,
          indicator: const BoxDecoration(),
          labelColor: UIColors.white,
          labelStyle: UITextStyle.medium,
          unselectedLabelColor: UIColors.grayText,
          unselectedLabelStyle: UITextStyle.medium,
          splashBorderRadius: BorderRadius.circular(widget.height / 2),
          onTap: (index) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          tabs: widget.tiles.mapIndexed(
            (index, e) {
              final item = widget.tiles[index];
              final isActive = index == selectedIndex;
              final color = isActive ? widget.activeColor : widget.inactiveColor;
              final iconColor = widget.showActiveIconColor ? color : widget.inactiveColor;
              return Tab(
                height: widget.height,
                iconMargin: EdgeInsets.zero,
                child: SplashButton(
                  onTap: () {
                    widget.onIndexSelected?.call(index);
                    if (item.code != null) {
                      widget.onValueSelected?.call(item.code!);
                    }
                  },
                  child: AnimatedContainer(
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 200),
                    width: widget.itemWidth,
                    constraints: BoxConstraints(
                      minWidth: widget.minItemWidth ?? 0.0,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      border: Border(
                        bottom: BorderSide(
                          color: !isActive ? Colors.transparent : color,
                          width: 4,
                        ),
                        right: index >= widget.tiles.length
                            ? BorderSide.none
                            : const BorderSide(
                                width: 1,
                                color: UIColors.extraLightGray,
                              ),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppImage.asset(
                          asset: item.icon,
                          width: widget.iconSize,
                          height: widget.iconSize,
                          color: !widget.showActiveIconColor ? null : iconColor,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          item.title ?? "",
                          style: isActive
                              ? UITextStyle.semiBold.copyWith(
                                  fontSize: 14,
                                  color: color,
                                  height: 1.25,
                                )
                              : UITextStyle.regular.copyWith(
                                  fontSize: 14,
                                  color: color,
                                  height: 1.25,
                                ),
                          textAlign: TextAlign.center,
                          maxLines: widget.maxLinesTitle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
