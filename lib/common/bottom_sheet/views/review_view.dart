import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/size.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/images.dart';

import '../../../models/collaborator/status_review_model.dart';

class UserReviewComponent extends StatefulWidget {
  const UserReviewComponent({
    Key? key,
    required this.name,
    required this.url,
    required this.onSubmitReview,
    this.listStatus = const [],
    this.rating,
    this.note,
  }) : super(key: key);

  final String name;
  final String url;
  final List<StatusReview> listStatus;
  final Function(int rating, String? note) onSubmitReview;
  final int? rating;
  final String? note;

  @override
  State<UserReviewComponent> createState() => _UserReviewComponentState();
}

class _UserReviewComponentState extends State<UserReviewComponent> {
  int rating = 0;
  String note = '';

  late FocusNode focusNode;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    controller = TextEditingController();
  }

  @override
  void didUpdateWidget(UserReviewComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rating == null && oldWidget.rating != widget.rating) {
      setState(() {
        rating = widget.rating ?? 0;
      });
    }
    if (oldWidget.note == null && oldWidget.note != widget.note) {
      controller.text = widget.note ?? "";
      setState(() {});
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: AppSize.instance.height * 0.75,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppImage.network(
              url: widget.url,
              width: 80,
              height: 80,
              borderRadius: BorderRadius.circular(40),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.name,
              style: UITextStyle.semiBold.copyWith(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RatingBar(
              glow: false,
              minRating: 0,
              initialRating: TextUtils.parseDouble(rating) ?? 0,
              allowHalfRating: false,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              ratingWidget: RatingWidget(
                full: const AppImage.asset(
                  asset: 'ic_star',
                  width: 24,
                  height: 24,
                  color: UIColors.green,
                ),
                half: const SizedBox(),
                empty: const AppImage.asset(
                  asset: 'ic_star_outline',
                  width: 24,
                  height: 24,
                ),
              ),
              onRatingUpdate: (star) {
                setState(() {
                  rating = star.toInt();
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              titleStatus ?? "Chạm vào dấu sao để đánh giá",
              style: titleStatus != null
                  ? UITextStyle.semiBold.copyWith(
                      color: UIColors.darkBlue,
                      fontSize: 20,
                    )
                  : UITextStyle.regular.copyWith(
                      color: UIColors.grayText,
                    ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              constraints: const BoxConstraints(
                minHeight: 48,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                cursorWidth: 2,
                cursorHeight: 23,
                cursorColor: UIColors.primaryColor,
                cursorRadius: const Radius.circular(8),
                style: UITextStyle.regular,
                onChanged: (value) {
                  note = value;
                },
                minLines: 3,
                maxLines: 3,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: UIColors.white,
                  hintText: "Nhập nhận xét (nếu có)",
                  hintStyle: UITextStyle.medium.copyWith(
                    fontSize: 16,
                    height: 1.5,
                    color: UIColors.grayText,
                  ),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: UIColors.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(
              onPressed: () {
                widget.onSubmitReview.call(rating, note);
              },
              padding: const EdgeInsets.symmetric(horizontal: 48),
              title: "Hoàn tất",
              enabled: enabledButton,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: UIColors.lightBlue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppImage.asset(
                    asset: 'ic_info_fill',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: UITextStyle.regular,
                        children: [
                          const TextSpan(
                            text:
                                'Đánh giá của bạn rất quan trọng trong việc nâng cao chất lượng làm việc. Vui lòng phản ánh ',
                          ),
                          TextSpan(
                            text: 'trung thực',
                            style: UITextStyle.bold.copyWith(color: UIColors.darkBlue),
                          ),
                          const TextSpan(text: ' và '),
                          TextSpan(
                            text: 'chi tiết.',
                            style: UITextStyle.bold.copyWith(color: UIColors.darkBlue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  String? get titleStatus => widget.listStatus
      .firstWhereOrNull(
        (element) => TextUtils.parseInt(element.defaultStar) == rating,
      )
      ?.statusName;

  bool get enabledButton => rating > 0;
}
