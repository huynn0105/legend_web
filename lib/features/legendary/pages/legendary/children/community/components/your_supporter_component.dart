import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/common/bottom_sheet/bottom_sheet_provider.dart';
import 'package:legend_mfast/common/utils/datetime_util.dart';
import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:legend_mfast/common/widgets/avatar/chat_avatar.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_change_supporter/legendary_change_supporter_cubit.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_review/legendary_review_cubit.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_supporter/legendary_supporter_cubit.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/community/components/check_change_supporter_component.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/community/components/leave_supporter_component.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/community/components/review_user_component.dart';
import 'package:legend_mfast/features/legendary/pages/legendary/children/community/components/your_supporter_review_component.dart';
import 'package:legend_mfast/features/legendary/pages/new_supporter/components/action_header.dart';
import 'package:legend_mfast/models/collaborator/collaborator_my_supporter_waiting_model.dart';
import 'package:legend_mfast/models/collaborator/collaborator_review_filter_response_model.dart';
import 'package:legend_mfast/routes/routes.gr.dart';
import 'package:legend_mfast/services/firebase/firebase_database/firebase_database_util.dart';

import '../../../../../../../common/colors.dart';
import '../../../../../../../common/styles.dart';
import '../../../../../../../common/widgets/buttons.dart';
import '../../../../../../../common/widgets/images.dart';

class YourSupporterComponent extends StatelessWidget {
  const YourSupporterComponent({
    super.key,
    this.title = "Người dẫn dắt của bạn",
    this.titleStyle,
    this.showToolTips = true,
    this.hasVerified = true,
  });

  final String title;
  final TextStyle? titleStyle;
  final bool showToolTips;
  final bool hasVerified;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LegendarySupporterCubit, LegendarySupporterState>(
      builder: (context, state) {
        if (state.filters == null || state.filters?.hideSupporter == true) {
          return const SizedBox();
        }

        if (!hasVerified && TextUtils.isEmpty(state.filters?.supporter?.toUserID)) {
          return const SizedBox();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: titleStyle ??
                      UITextStyle.semiBold.copyWith(
                        fontSize: 18,
                        color: UIColors.lightBlack,
                      ),
                ),
                if (showToolTips) ...[
                  const SizedBox(
                    width: 6,
                  ),
                  const ActionHeader()
                ],
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Builder(
              builder: (context) {
                if (state.mySupporterWaiting?.toUserID != null) {
                  return _MySupporterWaitingComponent(
                    mySupporterWaiting: state.mySupporterWaiting!,
                  );
                }

                if (TextUtils.isEmpty(state.filters?.supporter?.toUserID)) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: UIColors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Column(
                      children: [
                        const AppImage.asset(
                          asset: "ic_mascot_student",
                          width: 96,
                          height: 96,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Bạn chưa có người dẫn dắt",
                          style: UITextStyle.bold.copyWith(
                            color: UIColors.darkBlue,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Người đứng ngay trên nhánh của bạn, do bạn tự chỉ định, sẽ trực tiếp hỗ trợ, dẫn dắt bạn trong suốt con đường Huyền thoại.",
                          style: UITextStyle.regular.copyWith(
                            fontSize: 13,
                            color: UIColors.grayText,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        PrimaryButton(
                          height: 45,
                          onPressed: () {
                            context.pushRoute(NewSupporterRoute());
                          },
                          title: "Chọn người dẫn dắt",
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSplashButton(
                      onTap: () {
                        _onOpenBottomSheetSupporterReview(
                          context,
                          filters: state.filters,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: UIColors.darkBlue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ChatAvatar(
                                  url: FirebaseDatabaseUtil.convertUrlAvatar(state.filters?.supporter?.avatarImage),
                                  size: 48,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        state.filters?.supporter?.fullName ?? "",
                                                        style: UITextStyle.medium.copyWith(
                                                          fontSize: 16,
                                                          color: UIColors.white,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    const AppImage.asset(
                                                      asset: 'ic_arrow_right',
                                                      width: 20,
                                                      height: 20,
                                                      color: UIColors.white,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  state.filters?.supporter?.title ?? "",
                                                  style: UITextStyle.regular.copyWith(
                                                    fontSize: 14,
                                                    color: UIColors.white.withOpacity(0.6),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 80,
                                            height: 56,
                                            child: Stack(
                                              children: [
                                                Positioned.fill(
                                                  child: AppImage.asset(
                                                    asset: "ic_white_logo_mfast",
                                                    width: 62,
                                                    height: 56,
                                                    color: UIColors.white.withOpacity(0.2),
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                // Center(
                                                //   child: Row(
                                                //     children: [
                                                //       SplashButton(
                                                //         onTap: () {
                                                //           GlobalFunction.moveToChatPage(
                                                //             chatUserID: state.filters?.supporter?.toUserID,
                                                //           );
                                                //         },
                                                //         borderRadius: BorderRadius.circular(20),
                                                //         child: const Padding(
                                                //           padding: EdgeInsets.all(5),
                                                //           child: AppImage.asset(
                                                //             asset: "ic_chat",
                                                //             width: 24,
                                                //             height: 24,
                                                //           ),
                                                //         ),
                                                //       ),
                                                //       const SizedBox(
                                                //         width: 10,
                                                //       ),
                                                //       IgnorePointer(
                                                //         ignoring: false,
                                                //         child: SplashButton(
                                                //           onTap: () {
                                                //             GlobalFunction.launchPhone(
                                                //               state.filters?.supporter?.mobilePhone ?? "",
                                                //             );
                                                //           },
                                                //           borderRadius: BorderRadius.circular(20),
                                                //           child: const Padding(
                                                //             padding: EdgeInsets.all(5),
                                                //             child: AppImage.asset(
                                                //               asset: "ic_call",
                                                //               width: 24,
                                                //               height: 24,
                                                //             ),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          // AppSplashButton(
                                          //   onTap: () {
                                          //     context.pushRoute(ChatRoute(
                                          //       chatUserID: state.filters?.supporter?.toUserID,
                                          //     ));
                                          //   },
                                          //   child: const AppImage.asset(
                                          //     asset: "ic_message_bold",
                                          //     width: 24,
                                          //     height: 24,
                                          //     color: UIColors.white,
                                          //   ),
                                          // ),
                                          // const SizedBox(
                                          //   width: 16,
                                          // ),
                                          // AppSplashButton(
                                          //   onTap: () {
                                          //     GlobalFunction.launchPhone(
                                          //       state.filters?.supporter?.mobilePhone ?? "",
                                          //     );
                                          //   },
                                          //   child: const AppImage.asset(
                                          //     asset: "ic_phone_bold",
                                          //     width: 24,
                                          //     height: 24,
                                          //     color: UIColors.white,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // const SizedBox(
                            //   height: 12,
                            // ),
                            // Container(
                            //   padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 11),
                            //   decoration: BoxDecoration(
                            //     color: UIColors.lightBlue,
                            //     borderRadius: BorderRadius.circular(8),
                            //   ),
                            //   child: Row(
                            //     children: [
                            //       Expanded(
                            //         child: Text(
                            //           "Làm sao để chọn người hướng dẫn?",
                            //           style: UITextStyle.medium.copyWith(
                            //             color: UIColors.primaryColor,
                            //             fontSize: 16,
                            //           ),
                            //         ),
                            //       ),
                            //       const Padding(
                            //         padding: EdgeInsets.only(top: 4),
                            //         child: AppImage.asset(
                            //           asset: "ic_arrow_right",
                            //           width: 16,
                            //           height: 16,
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }

  _onReviewUser(
    BuildContext context,
    LegendaryReviewFilterResponseModel? filters,
  ) {
    BottomSheetProvider.instance.show(
      context,
      title: "Bạn đánh giá sao về chất lượng dẫn dắt của ${filters?.supporter?.fullName} ?",
      child: BlocProvider(
        create: (context) => LegendaryReviewCubit(),
        child: ReviewUserComponent(
          supporter: filters?.supporter,
          titleRating: filters?.titleRating,
        ),
      ),
    );
  }

  _onLeaveCollaborator(
    BuildContext context,
    LegendaryReviewFilterResponseModel? filters,
  ) async {
    final result = await BottomSheetProvider.instance.show(
      context,
      title: "Người dẫn dắt",
      child: BlocProvider.value(
        value: context.read<LegendaryChangeSupporterCubit>(),
        child: const CheckChangeCollaboratorComponent(),
      ),
    );
    if (result is bool && result == true && context.mounted) {
      BottomSheetProvider.instance.show(
        context,
        title: "Bỏ người dẫn dắt",
        child: BlocProvider.value(
          value: context.read<LegendaryChangeSupporterCubit>(),
          child: LeaveSupporterComponent(supporter: filters?.supporter),
        ),
      );
    }
  }

  _onChangeCollaborator(
    BuildContext context,
    LegendaryReviewFilterResponseModel? filters,
  ) async {
    final result = await BottomSheetProvider.instance.show(
      context,
      title: "Người dẫn dắt",
      child: BlocProvider.value(
        value: context.read<LegendaryChangeSupporterCubit>(),
        child: const CheckChangeCollaboratorComponent(),
      ),
    );
    if (result is bool && result == true && context.mounted) {
      context.pushRoute(NewSupporterRoute());
    }
  }

  _onOpenBottomSheetSupporterReview(
    BuildContext context, {
    LegendaryReviewFilterResponseModel? filters,
  }) async {
    final result = await BottomSheetProvider.instance.show(
      context,
      title: "Người dẫn dắt",
      child: BlocProvider(
        create: (context) => LegendaryReviewCubit(),
        child: YourSupporterReviewComponent(
          user: filters?.supporter,
          tabs: filters?.tab,
        ),
      ),
    );
    if (result is int && context.mounted) {
      switch (result) {
        case 0:
          _onLeaveCollaborator(context, filters);
          break;
        case 1:
          _onReviewUser(context, filters);
          break;
        case 2:
          _onChangeCollaborator(context, filters);
          break;
      }
    }
  }
}

class _MySupporterWaitingComponent extends StatelessWidget {
  const _MySupporterWaitingComponent({
    super.key,
    required this.mySupporterWaiting,
  });

  final MySupporterWaitingModel mySupporterWaiting;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSplashButton(
          onTap: () {
            context.pushRoute(NewSupporterRoute(
              mySupporterWaiting: mySupporterWaiting,
            ));
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                ChatAvatar(
                  url: FirebaseDatabaseUtil.convertUrlAvatar(mySupporterWaiting.avatarImage),
                  size: 48,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              mySupporterWaiting.fullName ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: UITextStyle.medium.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const AppImage.asset(
                            asset: 'ic_arrow_right',
                            width: 20,
                            height: 20,
                            color: UIColors.gray,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            'Chờ chấp nhận',
                            style: UITextStyle.semiBold.copyWith(
                              color: UIColors.orangeText,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            ' - ${DateTimeUtil.getNumberDayBetween(mySupporterWaiting.time ?? '')}',
                            style: UITextStyle.regular.copyWith(
                              color: UIColors.grayText,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
