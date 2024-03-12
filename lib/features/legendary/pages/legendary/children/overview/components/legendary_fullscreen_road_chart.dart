import 'package:flutter/material.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/images.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/widgets/legendary_road/legendary_road_chart.dart';

import '../../../../../../../models/legendary/legendary_road_chart_model.dart';

class LegendaryFullScreenRoadChart extends StatelessWidget {
  const LegendaryFullScreenRoadChart({
    super.key,
    required this.data,
    required this.date,
    required this.gender,
    required this.isMyLegendaryHier,
  });

  final LegendaryRoadChartModel data;
  final DateTime date;
  final String gender;
  final bool isMyLegendaryHier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.white,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(top: 12, right: 75),
              child: RotatedBox(
                quarterTurns: 1,
                child: LegendaryRoadChart(
                  data: data,
                  gender: gender,
                  month: date.month,
                  isMyLegendaryHier: isMyLegendaryHier,
                ),
              ),
            ),
            Positioned(
              right: 12,
              bottom: 12,
              child: AppSplashButton(
                onTap: Navigator.of(context).pop,
                child: Container(
                  width: 54,
                  height: 54,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: UIColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const AppImage.asset(
                    asset: 'ic_close_square',
                    width: 32,
                    height: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
