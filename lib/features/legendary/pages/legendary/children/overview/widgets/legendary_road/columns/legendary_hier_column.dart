import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/extension/list_extension.dart';
import 'package:legend_mfast/common/global_function.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/color_util.dart';
import 'package:legend_mfast/common/utils/format_util.dart';
import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:legend_mfast/common/widgets/images.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/widgets/legendary_road/cells/legendary_hier_data_cell.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/widgets/legendary_road/cells/legendary_hier_rank_cell.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/widgets/legendary_road/legendary_road_column.dart';

import '../../../../../../../../../common/utils/legendary_util.dart';
import '../../../../../../../../../models/legendary/hier_rank_chart_model.dart';

class LegendaryHierColumn extends StatelessWidget {
  const LegendaryHierColumn({
    super.key,
    required this.data,
    required this.commissionInit,
    required this.month,
    required this.gender,
    required this.level,
    required this.hierIndex,
    required this.hierLength,
    required this.maxCount,
    required this.minHeight,
    required this.maxHeight,
    required this.minWidth,
    required this.isMyLegendaryHier,
  });

  final HierRankChartModel? data;
  final double commissionInit;
  final int month;
  final String? gender;
  final String? level;

  final int hierIndex;
  final int hierLength;
  final int maxCount;
  final double minHeight;
  final double maxHeight;
  final double minWidth;
  final bool isMyLegendaryHier;

  @override
  Widget build(BuildContext context) {
    final amount = data?.amount ?? <double>[];
    final ratioLine = data?.ratioLine ?? <double>[];
    final hasAmount = amount.isNotEmpty;
    final values = hasAmount ? amount : ratioLine;
    final activeColor = TextUtils.isEmpty(data?.activeColor) ? UIColors.white : ColorUtil.fromHex(data!.activeColor!);
    final backgroundColor = TextUtils.isEmpty(data?.background) ? UIColors.white : ColorUtil.fromHex(data!.background!);
    final rankLabel = LegendaryUtil.getLegendaryRankByTitle(data?.title ?? '');
    final title = rankLabel.title ?? '';
    final star = rankLabel.star ?? 0;

    ///
    final isActive = data?.amount?.isNotEmpty == true;

    ///
    return LegendaryRoadColumn(
      itemCount: maxCount,
      itemBuilder: (context, index, isFirst, isLast) {
        /// TODO: 1. Render base row
        if (index == 0) {
          return LegendaryHierDataCell(
            label: isActive ? FormatUtil.currencyDoubleFormat(commissionInit) : '',
            height: minHeight,
            isActive: isActive,
            backgroundColor: UIColors.darkBlue,
          );
        }

        if (index > values.length && index < maxCount) {
          final remainCells = maxCount - values.length - 3;

          /// TODO: 2. Render head Mascot
          if (index == maxCount - 1) {
            return Container(
              height: maxHeight,
              constraints: BoxConstraints(
                minWidth: minWidth,
              ),
              alignment: Alignment.center,
              child: Visibility(
                visible: isActive,
                child: AppImage.asset(
                  asset: GlobalFunction.getRankingMascotAssetImage(gender, level),
                  width: maxHeight,
                  height: maxHeight,
                ),
              ),
            );
          }

          /// TODO: 3. Render head Collaborator
          if (index == maxCount - 2 && remainCells != 0) {
            return Container(
              height: maxHeight,
              constraints: BoxConstraints(
                minWidth: minWidth,
              ),
              alignment: Alignment.center,
              child: Visibility(
                visible: isActive,
                child: Text(
                  '${isMyLegendaryHier ? 'Bạn' : 'CTV'} của tháng $month',
                  style: UITextStyle.semiBold.copyWith(
                    fontSize: 14,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          /// TODO: 4. Render gradient space
          if (index == values.length + 1) {
            if (remainCells == 0) {
              return LegendaryHierRankCell(
                title: title,
                star: star,
                primaryColor: activeColor,
                backgroundColor: Colors.transparent,
                width: minWidth,
                height: maxHeight,
                showRightBorder: hierIndex != 0 && hierIndex != hierLength - 1,
                showCornerBorder: hierIndex != 0,
              );
            }
            return Container(
              height: maxHeight * remainCells + (remainCells),
              constraints: BoxConstraints(
                minWidth: minWidth,
              ),
              child: Stack(
                children: [
                  Column(
                    verticalDirection: VerticalDirection.up,
                    children: [
                      LegendaryHierRankCell(
                        title: title,
                        star: star,
                        primaryColor: activeColor,
                        backgroundColor: Colors.transparent,
                        width: minWidth,
                        height: maxHeight,
                        showRightBorder: hierIndex != 0 && hierIndex != hierLength - 1,
                        showCornerBorder: hierIndex != 0,
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: maxHeight * remainCells,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: !isActive ? Radius.zero : const Radius.circular(4),
                        topRight: !isActive ? Radius.zero : const Radius.circular(4),
                      ),
                      gradient: !isActive
                          ? null
                          : LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                activeColor.withOpacity(0.4),
                                activeColor.withOpacity(0.2),
                                activeColor.withOpacity(0.1),
                                Colors.transparent,
                              ],
                              tileMode: TileMode.mirror,
                            ),
                    ),
                    constraints: BoxConstraints(
                      minWidth: minWidth,
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        }

        /// TODO: 5. Render rank data cell
        final itemIndex = values.length - index;
        final amountItem = amount.valueAt(itemIndex) ?? 0;
        final ratioLineItem = ratioLine.valueAt(itemIndex) ?? 0;
        final item = amountItem != 0 ? amountItem : ratioLineItem;
        final unit = amountItem != 0 ? '' : '%';

        return LegendaryHierDataCell(
          label: '${FormatUtil.doubleFormat(item)}$unit',
          height: maxHeight,
          isActive: isActive,
          backgroundColor: isActive ? activeColor : backgroundColor,
        );
      },
      separatorBuilder: (context, index) {
        final divider = Container(
          height: 1,
          constraints: BoxConstraints(
            minWidth: minWidth,
          ),
          decoration: const BoxDecoration(
            color: UIColors.white,
          ),
        );
        if (index > values.length && index < maxCount) {
          if (index == values.length + 1) {
            return divider;
          }
          return const SizedBox.shrink();
        }
        return divider;
      },
    );
  }

// String getAssetMascotImage(String? rawGender, String? rawLevel) {
//   ///
//   String convertGender(String? rawGender) {
//     final gender = VietnameseUtils.toEnglish(rawGender?.toLowerCase() ?? '');
//     switch (gender) {
//       case 'female':
//       case 'nu':
//         return 'female';
//       default:
//         return 'male';
//     }
//   }
//
//   ///
//   String convertLevel(String? rawLevel) {
//     final level = LegendaryRankLevel.values.firstWhereOrNull((e) => e.code == rawLevel);
//
//     switch (level) {
//       case LegendaryRankLevel.HEAD:
//         return 'diamond';
//       case LegendaryRankLevel.FIX_RSM:
//       case LegendaryRankLevel.KPI_RSM:
//       case LegendaryRankLevel.VAR_RSM:
//         return 'gold';
//       case LegendaryRankLevel.FIX_RSA:
//       case LegendaryRankLevel.KPI_RSA:
//       case LegendaryRankLevel.VAR_RSA:
//         return 'silver';
//       default:
//         return 'stone';
//     }
//   }
//
//   /// ic_mascot_head_male_diamond
//   String gender = convertGender(rawGender);
//   String level = convertLevel(rawLevel);
//   String result = 'ic_mascot_head_${gender.toString()}_${level.toString()}';
//   return result;
// }
}
