import 'dart:math';

import 'package:flutter/material.dart';
import 'package:legend_mfast/common/bottom_sheet/wrapper/data_wrapper.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/loading.dart';

import '../../../../../../../models/collaborator/mentor_rating_model.dart';
import '../items/overall_rating_item.dart';
import '../items/rating_item.dart';

class UserReviewListComponent extends StatefulWidget {
  const UserReviewListComponent({
    super.key,
    required this.data,
    this.totalPercent,
    this.totalAvg,
    this.totalAmount,
    this.onChangeTab,
    this.onChangeSkill,
    this.tabs,
    this.skills,
    this.isLoading = false,
  });

  final List<MentorRatingUserModel> data;
  final RatingPercentModel? totalPercent;
  final double? totalAvg;
  final int? totalAmount;
  final Function(String id)? onChangeTab;
  final Function(String id)? onChangeSkill;
  final List<DataWrapper>? tabs;
  final List<DataWrapper>? skills;
  final bool isLoading;

  @override
  State<UserReviewListComponent> createState() => _UserReviewListComponentState();
}

class _UserReviewListComponentState extends State<UserReviewListComponent> {
  String tabSelected = "";
  String skillSelected = "";

  @override
  void initState() {
    super.initState();
    tabSelected = widget.tabs?.first.id ?? "";
    skillSelected = widget.skills?.first.id ?? "";
  }

  @override
  void didUpdateWidget(covariant UserReviewListComponent oldWidget) {
    super.didUpdateWidget(oldWidget);

    if ((oldWidget.tabs == null || oldWidget.tabs?.isEmpty == true) && widget.tabs?.isNotEmpty == true) {
      setState(() {
        tabSelected = widget.tabs?.first.id ?? "";
      });
    }
    if ((oldWidget.skills == null || oldWidget.skills?.isEmpty == true) && widget.skills?.isNotEmpty == true) {
      setState(() {
        skillSelected = widget.skills?.first.id ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.skills != null) ...[
          SizedBox(
            height: 32,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = widget.skills![index];
                final isSelected = skillSelected == item.id;

                return SplashButton(
                  onTap: () {
                    widget.onChangeSkill?.call(item.id ?? "");
                    setState(() {
                      skillSelected = item.id ?? "";
                    });
                  },
                  child: Chip(
                    label: Text(
                      item.value ?? "",
                      style: isSelected
                          ? UITextStyle.medium.copyWith(
                              color: UIColors.white,
                            )
                          : UITextStyle.regular.copyWith(
                              color: UIColors.grayText,
                            ),
                    ),
                    padding: const EdgeInsets.only(left: 12, right: 12, bottom: 7, top: 5),
                    backgroundColor: isSelected ? UIColors.primaryColor : UIColors.white,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 8,
                );
              },
              itemCount: widget.skills!.length,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: UIColors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OverallRatingItem(
                avg: widget.totalAvg ?? 0,
                amount: widget.totalAmount ?? 0,
                percent: widget.totalPercent,
              ),
              const SizedBox(
                height: 12,
              ),
              const Divider(
                color: UIColors.lightGray,
                height: 1,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Chi tiết đánh giá",
                style: UITextStyle.regular.copyWith(
                  color: UIColors.grayText,
                ),
              ),
              if (widget.tabs != null) ...[
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 32,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = widget.tabs![index];
                      final isSelected = tabSelected == item.id;

                      return SplashButton(
                        onTap: () {
                          widget.onChangeTab?.call(item.id ?? "");
                          setState(() {
                            tabSelected = item.id ?? "";
                          });
                        },
                        child: Chip(
                          label: Text(
                            item.value ?? "",
                            style: isSelected
                                ? UITextStyle.medium.copyWith(
                                    color: UIColors.white,
                                  )
                                : UITextStyle.regular.copyWith(
                                    color: UIColors.grayText,
                                  ),
                          ),
                          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 7, top: 5),
                          backgroundColor: isSelected ? UIColors.primaryColor : UIColors.background,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 8,
                      );
                    },
                    itemCount: widget.tabs!.length,
                  ),
                ),
              ],
              const SizedBox(
                height: 16,
              ),
              if (widget.isLoading) ...[
                const LoadingWidget.withoutText(),
              ] else if (widget.data.isEmpty) ...[
                const EmptyRatingItem(),
              ] else ...[
                ...List.generate(max(0, widget.data.length * 2 - 1), (index) {
                  final int itemIndex = index ~/ 2;
                  if (index.isEven) {
                    return RatingItem(
                      data: widget.data[itemIndex],
                    );
                  }
                  return const SizedBox(
                    height: 12,
                  );
                }),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
