import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/bottom_sheet/wrapper/data_wrapper.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/size.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/widgets/avatar/chat_avatar.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/images.dart';
import 'package:legend_mfast/common/widgets/loadmore_widget.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_review/legendary_review_cubit.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/community/components/user_review_list_component.dart';
import 'package:legend_mfast/models/collaborator/collaborator_supporter_model.dart';
import 'package:legend_mfast/services/firebase/firebase_database/firebase_database_util.dart';

class YourSupporterReviewComponent extends StatelessWidget {
  const YourSupporterReviewComponent({
    super.key,
    this.user,
    this.skills,
    this.tabs,
  });
  final CollaboratorSupporterModel? user;
  final List<DataWrapper>? skills;
  final List<DataWrapper>? tabs;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LegendaryReviewCubit, LegendaryReviewState>(
      builder: (context, state) {
        final cubit = context.read<LegendaryReviewCubit>();
        if (state.status.isInitial) {
          cubit.updatePayload(
            userID: user?.toUserID,
            page: 1,
          );
          cubit.getReviews();
        }
        return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: double.infinity,
            maxHeight: AppSize.instance.height * 0.8,
          ),
          child: LoadMoreWidget(
            onLoadMore: () async {
              final length = state.reviews.length;
              await cubit.getReviews(loadMore: true);

              return length != state.reviews.length;
            },
            child: ListView(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    ChatAvatar(
                      url: FirebaseDatabaseUtil.convertUrlAvatar(user?.avatarImage),
                      name: user?.fullName ?? "",
                      size: 64,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user?.fullName ?? "",
                                      style: UITextStyle.semiBold.copyWith(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      user?.title ?? "",
                                      style: UITextStyle.semiBold.copyWith(
                                        color: UIColors.darkBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // SplashButton(
                              //   onTap: () {
                              //     GlobalFunction.moveToChatPage(chatUserID: user?.toUserID);
                              //   },
                              //   child: const AppImage.asset(
                              //     asset: "ic_message_bold",
                              //     width: 24,
                              //     height: 24,
                              //   ),
                              // ),
                              // const SizedBox(
                              //   width: 20,
                              // ),
                              // SplashButton(
                              //   onTap: () {
                              //     GlobalFunction.launchPhone(user?.mobilePhone ?? "");
                              //   },
                              //   child: const AppImage.asset(
                              //     asset: "ic_phone_bold",
                              //     width: 24,
                              //     height: 24,
                              //   ),
                              // ),
                            ],
                          ),
                          Text(
                            "“Đừng ngại tương tác khi cần hỗ trợ nhé, mình ở đây là để đi cùng bạn.”",
                            style: UITextStyle.regular.copyWith(
                              fontStyle: FontStyle.italic,
                              color: UIColors.grayText,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: UIColors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SplashButton(
                        onTap: () {
                          Navigator.of(context).pop(0);
                        },
                        child: SizedBox(
                          width: 82,
                          child: Column(
                            children: [
                              const AppImage.asset(
                                asset: "ic_trash",
                                width: 24,
                                height: 24,
                              ),
                              Text(
                                "Bỏ người\ndẫn dắt",
                                style: UITextStyle.medium.copyWith(
                                  fontSize: 13,
                                  color: UIColors.red,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SplashButton(
                        onTap: () {
                          Navigator.of(context).pop(1);
                        },
                        child: SizedBox(
                          width: 82,
                          child: Column(
                            children: [
                              const AppImage.asset(
                                asset: "ic_academy_like",
                                width: 24,
                                height: 24,
                                color: UIColors.primaryColor,
                              ),
                              Text(
                                "Đánh giá\nngười này",
                                style: UITextStyle.medium.copyWith(
                                  fontSize: 13,
                                  color: UIColors.primaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SplashButton(
                        onTap: () {
                          Navigator.of(context).pop(2);
                        },
                        child: SizedBox(
                          width: 82,
                          child: Column(
                            children: [
                              const AppImage.asset(
                                asset: "ic_edit",
                                width: 24,
                                height: 24,
                                color: UIColors.orange,
                              ),
                              Text(
                                "Đổi người\ndẫn dắt khác",
                                style: UITextStyle.medium.copyWith(
                                  fontSize: 13,
                                  color: UIColors.orange,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Kỹ năng dẫn dắt của ${user?.fullName}",
                  style: UITextStyle.regular.copyWith(
                    color: UIColors.grayText,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                UserReviewListComponent(
                  isLoading: state.status.isLoading,
                  tabs: tabs,
                  data: state.reviews,
                  totalAmount: state.totalAmount,
                  totalAvg: state.totalAvg,
                  totalPercent: state.totalPercent,
                  onChangeTab: (id) {
                    cubit.updatePayload(
                      tab: id,
                      page: 1,
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
