import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../../../../common/colors.dart';
import '../../../../../../../common/constants.dart';
import '../../../../../../../common/styles.dart';
import '../../../../../../../common/widgets/images.dart';
import '../../../../../../../models/collaborator/mentor_rating_model.dart';

class OverallRatingItem extends StatelessWidget {
  const OverallRatingItem({
    Key? key,
    required this.avg,
    required this.amount,
    required this.percent,
  }) : super(key: key);
  final double avg;
  final int amount;
  final RatingPercentModel? percent;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(
              avg.toStringAsFixed(1).replaceAll('.', ','),
              style: UITextStyle.bold.copyWith(
                fontSize: 40,
                color: UIColors.green,
                height: 1,
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Text(
              '/5 sao',
              style: UITextStyle.regular.copyWith(
                fontSize: 13,
                color: UIColors.grayText,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 24,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              StarRatingWidget(
                rating: 5,
                percent: percent?.star5 ?? 0,
              ),
              const SizedBox(
                height: 2,
              ),
              StarRatingWidget(
                rating: 4,
                percent: percent?.star4 ?? 0,
              ),
              const SizedBox(
                height: 2,
              ),
              StarRatingWidget(
                rating: 3,
                percent: percent?.star3 ?? 0,
              ),
              const SizedBox(
                height: 2,
              ),
              StarRatingWidget(
                rating: 2,
                percent: percent?.star2 ?? 0,
              ),
              const SizedBox(
                height: 2,
              ),
              StarRatingWidget(
                rating: 1,
                percent: percent?.star1 ?? 0,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "$amount đánh giá",
                style: UITextStyle.regular.copyWith(
                  fontSize: 13,
                  color: UIColors.grayText,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StarRatingWidget extends StatelessWidget {
  const StarRatingWidget({
    Key? key,
    required this.rating,
    required this.percent,
  }) : super(key: key);

  final int rating;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: List.generate(AppConstants.maxRating, (index) {
            if (index < (AppConstants.maxRating - rating)) {
              return const SizedBox(
                width: 10,
                height: 10,
              );
            }
            return const AppImage.asset(
              asset: "ic_star",
              width: 10,
              height: 10,
            );
          }),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constrains) {
              return LinearPercentIndicator(
                lineHeight: 4,
                width: constrains.maxWidth,
                percent: percent / 100,
                padding: EdgeInsets.zero,
                progressColor: UIColors.grayText,
                backgroundColor: UIColors.lightGray,
                barRadius: const Radius.circular(8),
              );
            },
          ),
        ),
      ],
    );
  }
}
