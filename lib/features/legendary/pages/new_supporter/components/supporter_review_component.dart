import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/constants.dart';
import 'package:legend_mfast/common/size.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:legend_mfast/common/widgets/avatar/chat_avatar.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/checkbox.dart';
import 'package:legend_mfast/common/widgets/loadmore_widget.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_review/legendary_review_cubit.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/community/components/user_review_list_component.dart';
import 'package:legend_mfast/features/legendary/pages/new_supporter/components/rating_component.dart';
import 'package:legend_mfast/models/collaborator/collaborator_new_supporter_model.dart';
import 'package:legend_mfast/services/firebase/firebase_database/firebase_database_util.dart';

class SupporterReviewComponent extends StatefulWidget {
  const SupporterReviewComponent({
    super.key,
    this.user,
    this.isSelected = false,
    this.onChangeSelected,
  });

  final LegendaryNewSupporterModel? user;
  final bool isSelected;
  final Function(bool value)? onChangeSelected;

  @override
  State<SupporterReviewComponent> createState() => _SupporterReviewComponentState();
}

class _SupporterReviewComponentState extends State<SupporterReviewComponent> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LegendaryReviewCubit, LegendaryReviewState>(
      builder: (context, state) {
        final cubit = context.read<LegendaryReviewCubit>();
        if (state.status.isInitial) {
          cubit.updatePayload(
            userID: widget.user?.toUserID,
            page: 1,
          );
          cubit.getReviews();
        }
        return SizedBox(
          height: AppSize.instance.height * 0.75,
          width: double.infinity,
          child: LoadMoreWidget(
            onLoadMore: () async {
              final length = state.reviews.length;
              await cubit.getReviews(loadMore: true);

              return length != state.reviews.length;
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    ChatAvatar(
                      url: FirebaseDatabaseUtil.convertUrlAvatar(widget.user?.avatarImage) ?? "",
                      name: widget.user?.fullName ?? "",
                      size: 64,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.user?.fullName ?? "",
                                  style: UITextStyle.semiBold.copyWith(
                                    fontSize: 18,
                                  ),
                                ),
                                RatingComponent(
                                  star: TextUtils.parseDouble(widget.user?.avgRating) ?? 0,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Chọn",
                            style: UITextStyle.regular.copyWith(
                              fontSize: 13,
                              color: UIColors.grayText,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          SplashButton(
                            onTap: () {
                              setState(() {
                                isSelected = !isSelected;
                              });
                              widget.onChangeSelected?.call(isSelected);
                            },
                            child: AppOutlineCheckbox(
                              value: isSelected,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Kỹ năng dẫn dắt của ${widget.user?.fullName}",
                  style: UITextStyle.regular.copyWith(
                    color: UIColors.grayText,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                UserReviewListComponent(
                  isLoading: state.status.showLoading,
                  data: state.reviews,
                  totalAmount: state.totalAmount,
                  totalAvg: state.totalAvg,
                  totalPercent: state.totalPercent,
                  tabs: AppConstants.defaultRatingFilters,
                  onChangeTab: (id) {
                    cubit.updatePayload(
                      userID: widget.user?.toUserID,
                      page: 1,
                      tab: id,
                    );
                    cubit.getReviews();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
