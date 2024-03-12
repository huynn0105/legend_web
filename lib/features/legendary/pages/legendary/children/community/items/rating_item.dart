import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../../../app_data.dart';
import '../../../../../../../common/colors.dart';
import '../../../../../../../common/global_function.dart';
import '../../../../../../../common/styles.dart';
import '../../../../../../../common/utils/datetime_util.dart';
import '../../../../../../../common/widgets/images.dart';
import '../../../../../../../models/collaborator/mentor_rating_model.dart';

class RatingItem extends StatelessWidget {
  const RatingItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  final MentorRatingUserModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: UIColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: UITextStyle.semiBold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(rating, (index) {
                    return const AppImage.asset(
                      asset: "ic_star",
                      width: 16,
                      height: 16,
                      color: UIColors.green,
                    );
                  }),
                ),
              ),
              Flexible(
                child: Text(
                  "$name - $elapsedTime",
                  style: UITextStyle.regular.copyWith(
                    fontSize: 12,
                    color: UIColors.grayText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            comment,
            style: UITextStyle.regular.copyWith(
              fontSize: 13,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  int get rating => data.rating ?? 0;
  String get title => data.title ?? "";
  String get comment => data.comment ?? "";
  String get name => data.fullName ?? "";
  String get elapsedTime {
    return DateTimeUtil.convertTimeAgo(
      data.createdDate ?? "",
      format: DateTimeFormat.yyyy_MM_dd_HH_mm_ss,
      isFromUtc: false,
    );
  }
}

class EmptyRatingItem extends StatelessWidget {
  const EmptyRatingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: AppImage.asset(
            asset: "ic_null",
            width: 24,
            height: 24,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          "Không tìm thấy đánh giá nào",
          style: UITextStyle.regular.copyWith(
            color: UIColors.grayText,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text:
                "“Kỹ năng bán hàng” và “Kỹ năng dẫn dắt” đại diện cho sự thừa nhận của mọi người về năng lực và uy tín của bạn, ",
            style: UITextStyle.regular.copyWith(
              color: UIColors.grayText,
            ),
            children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    GlobalFunction.pushWebView(url: AppData.instance.appInfo.emptyReviewUrl);
                  },
                text: "tìm hiểu thêm >>",
                style: UITextStyle.regular.copyWith(
                  color: UIColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
