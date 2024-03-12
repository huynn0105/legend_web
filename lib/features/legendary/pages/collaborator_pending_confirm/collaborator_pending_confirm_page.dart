import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/app_data.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/bottom_sheet/bottom_sheet_provider.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/dialogs/dialog_provider.dart';
import 'package:legend_mfast/common/global_function.dart';
import 'package:legend_mfast/common/size.dart';
import 'package:legend_mfast/common/styles.dart';
import 'package:legend_mfast/common/toast/toast_provider.dart';
import 'package:legend_mfast/common/utils/count_down_util.dart';
import 'package:legend_mfast/common/utils/datetime_util.dart';
import 'package:legend_mfast/common/utils/text_util.dart';
import 'package:legend_mfast/common/widgets/app_layout.dart';
import 'package:legend_mfast/common/widgets/appbar.dart';
import 'package:legend_mfast/common/widgets/avatar_widget.dart';
import 'package:legend_mfast/common/widgets/buttons.dart';
import 'package:legend_mfast/common/widgets/images.dart';
import 'package:legend_mfast/common/widgets/loadmore_widget.dart';
import 'package:legend_mfast/features/legendary/cubit/collaborator_pending_confirm/collaborator_pending_confirm_cubit.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_review/legendary_review_cubit.dart';
import 'package:legend_mfast/features/legendary/pages/new_supporter/components/rating_component.dart';
import 'package:legend_mfast/models/collaborator/collaborator_pending_detail_model.dart';

import '../legendary/children/community/components/user_review_list_component.dart';

@RoutePage()
class CollaboratorPendingConfrimPage extends StatelessWidget implements AutoRouteWrapper {
  const CollaboratorPendingConfrimPage({
    super.key,
    @QueryParam('ID') this.id,
    this.onRemoveItem,
  });

  final String? id;
  final Function(String? id)? onRemoveItem;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CollaboratorPendingConfirmCubit();
        cubit.getData(id ?? '');
        return cubit;
      },
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppLayout(
        child: Column(
          children: [
            MFastSimpleAppBar(
              context: context,
              title: "Xác nhận lời mời",
            ),
            Expanded(
              child: BlocConsumer<CollaboratorPendingConfirmCubit, CollaboratorPendingConfirmState>(
                listener: (context, state) {
                  if (state.status.isFailure) {
                    DialogProvider.instance.showErrorMsgDialog(
                      context: context,
                      btnTitle: 'Quay lại',
                      message: state.errorMessage,
                      title: 'Thông báo',
                      barrierDismissible: false,
                      callback: () {
                        context.router.pop();
                      },
                    );
                  }
                  if (state.confirmStatus.isSuccess) {
                    if (state.action == CollaboratorPendingAction.confirm) {
                      ToastProvider.instance.display('Đã đồng ý lời mời');
                    }
                    if (state.action == CollaboratorPendingAction.reject) {
                      ToastProvider.instance.display('Đã từ chối lời mời');
                    }
                    onRemoveItem?.call(id);
                    context.router.pop();
                  }
                  if (state.confirmStatus.isFailure) {
                    DialogProvider.instance.showMascotErrorDialog(
                      context: context,
                      message: state.errorMessage,
                    );
                  }
                },
                builder: (context, state) {
                  final collaborator = state.collaborator;
                  final isHasLastRating = collaborator?.lastRating != null;
                  String dateAgo = '';
                  if (collaborator != null) {
                    dateAgo = [
                      if (collaborator.year != null && collaborator.year! > 0) '${collaborator.year} năm,',
                      if (collaborator.month != null && collaborator.month! > 0) '${collaborator.month} tháng,',
                      if (collaborator.day != null && collaborator.day! > 0) '${collaborator.day} ngày',
                    ].join(" ");
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                // Align(
                                //   alignment: Alignment.centerRight,
                                //   child: Row(
                                //     mainAxisSize: MainAxisSize.min,
                                //     children: [
                                //       AppSplashButton(
                                //         onTap: () {
                                //           GlobalFunction.launchPhone(state.collaborator?.mobilePhone ?? '');
                                //         },
                                //         child: const AppImage.asset(
                                //           asset: 'icon_call',
                                //           height: 28,
                                //           width: 28,
                                //         ),
                                //       ),
                                //       const SizedBox(width: 20),
                                //       AppSplashButton(
                                //         onTap: () {
                                //           GlobalFunction.moveToChatPage(chatUserID: state.collaborator?.userId);
                                //         },
                                //         child: const AppImage.asset(
                                //           asset: 'icon_chat',
                                //           height: 28,
                                //           width: 28,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                Align(
                                  alignment: Alignment.center,
                                  child: state.collaborator?.avatarImage?.isNotEmpty == true
                                      ? AvatarWidget(
                                          url: state.collaborator?.avatarImage,
                                          size: 96,
                                        )
                                      : const CircleAvatar(
                                          radius: 48,
                                          child: AppImage.asset(asset: 'avatar_default_male'),
                                        ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              height: 24,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      state.collaborator?.fullName ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: UITextStyle.medium.copyWith(
                                        color: UIColors.lightBlack,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 4,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: UIColors.darkGray,
                                    ),
                                    margin: const EdgeInsets.only(left: 6, right: 6, top: 2),
                                  ),
                                  Text(
                                    state.collaborator?.level ?? '',
                                    style: UITextStyle.medium.copyWith(
                                      color: UIColors.darkBlue,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Tham gia: $dateAgo trước',
                              style: UITextStyle.regular.copyWith(
                                color: UIColors.grayText,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height: state.status.isLoading ? null : 150,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: double.infinity,
                                    height: isHasLastRating || state.status.isLoading ? null : 120,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: UIColors.darkBlue,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: state.status.isLoading
                                        ? const Center(child: CircularProgressIndicator())
                                        : isHasLastRating
                                            ? Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                        'Đánh giá gần nhất về ${state.collaborator?.fullName}',
                                                        style: UITextStyle.regular.copyWith(
                                                          fontSize: 13,
                                                          color: UIColors.divider,
                                                        ),
                                                      )),
                                                      AppSplashButton(
                                                        onTap: () {
                                                          BottomSheetProvider.instance.show(
                                                            context,
                                                            title: "Đánh giá về cộng tác viên",
                                                            child: BlocProvider(
                                                              create: (context) {
                                                                final cubit = LegendaryReviewCubit();
                                                                cubit.updatePayload(
                                                                  userID: state.collaborator?.userId,
                                                                  page: 1,
                                                                  skill: UserSkill.sell.name,
                                                                );
                                                                cubit.getReviews();
                                                                return cubit;
                                                              },
                                                              child: _ReviewWidget(
                                                                collaborator: state.collaborator,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Xem thêm',
                                                              style: UITextStyle.regular.copyWith(
                                                                fontSize: 13,
                                                                color: UIColors.divider,
                                                              ),
                                                            ),
                                                            const Icon(
                                                              Icons.navigate_next,
                                                              size: 30,
                                                              color: UIColors.darkGray,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(
                                                    color: UIColors.divider,
                                                  ),
                                                  Row(
                                                    children: [
                                                      RatingComponent(
                                                        star:
                                                            TextUtils.parseDouble(state.collaborator?.lastRating?.rating) ?? 0,
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        '${state.collaborator?.lastRating?.fullName} - ${CountDownUtil.formatDateAgo(DateTimeUtil.getRemainSeconds(
                                                          state.collaborator?.lastRating?.createdDate,
                                                          format: DateTimeFormat.yyyy_MM_dd_HH_mm_ss,
                                                          isFromUtc: false,
                                                        ))} trước',
                                                        style: UITextStyle.regular.copyWith(
                                                          fontSize: 13,
                                                          color: UIColors.divider,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 9),
                                                  Text(
                                                    'Xử lý tốt, nhiệt tình, muốn được hỗ trợ tiếp',
                                                    style: UITextStyle.regular.copyWith(
                                                      fontSize: 14,
                                                      color: UIColors.divider,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : null,
                                  ),
                                ),
                                state.status.isLoading
                                    ? const SizedBox.shrink()
                                    : Visibility(
                                        visible: (state.status.isSuccess && !isHasLastRating),
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Column(
                                            children: [
                                              const AppImage.asset(
                                                asset: 'ic_mtrade_mascot_ekyc',
                                                width: 110,
                                                height: 110,
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                'Chưa có đánh giá về ${state.collaborator?.fullName}',
                                                style: UITextStyle.regular.copyWith(
                                                  fontSize: 14,
                                                  color: UIColors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Lời nhắn của ${state.collaborator?.fullName}',
                          style: UITextStyle.regular.copyWith(
                            color: UIColors.grayText,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: UIColors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            state.collaborator?.note ?? '',
                            style: UITextStyle.regular.copyWith(
                              color: UIColors.lightBlack,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: AppOutlinedButton(
                                onPressed: () {
                                  context
                                      .read<CollaboratorPendingConfirmCubit>()
                                      .confirmCollaboratorPending(id ?? '', CollaboratorPendingAction.reject);
                                },
                                borderColor: UIColors.grayBackground,
                                borderWidth: 1,
                                borderRadius: BorderRadius.circular(24),
                                child: Text(
                                  'Bỏ qua',
                                  style: UITextStyle.regular.copyWith(
                                    fontSize: 14,
                                    color: UIColors.extraGrayText,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: PrimaryButton(
                                onPressed: () {
                                  context
                                      .read<CollaboratorPendingConfirmCubit>()
                                      .confirmCollaboratorPending(id ?? '', CollaboratorPendingAction.confirm);
                                },
                                title: 'Đồng ý',
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewWidget extends StatelessWidget {
  const _ReviewWidget({
    required this.collaborator,
  });
  final CollaboratorPendingDetailModel? collaborator;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        maxHeight: AppSize.instance.height * 0.7,
      ),
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<LegendaryReviewCubit, LegendaryReviewState>(
        builder: (context, fillterState) {
          if (fillterState.reviewStatus.isInitial) {
            final cubit = context.read<LegendaryReviewCubit>();

            cubit.updateReviewPayload(userID: AppData.instance.userID, toUserID: collaborator?.userId ?? "");
            cubit.getUserReview(toUserID: collaborator?.userId ?? "");
          }

          return LoadMoreWidget(
            onLoadMore: () async {
              final length = fillterState.reviews.length;
              await context.read<LegendaryReviewCubit>().getReviews(loadMore: true);

              return length != fillterState.reviews.length;
            },
            child: ListView(
              children: [
                Row(
                  children: [
                    collaborator?.avatarImage?.isNotEmpty == true
                        ? AvatarWidget(
                            url: collaborator?.avatarImage,
                            size: 56,
                          )
                        : const CircleAvatar(
                            radius: 28,
                            child: AppImage.asset(asset: 'avatar_default_male'),
                          ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            collaborator?.fullName ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: UITextStyle.semiBold.copyWith(
                              color: UIColors.blurBackground,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            collaborator?.fullName ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: UITextStyle.medium.copyWith(
                              color: UIColors.darkBlue,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     AppSplashButton(
                    //       onTap: () {
                    //         GlobalFunction.launchPhone(collaborator?.mobilePhone ?? '');
                    //       },
                    //       child: const AppImage.asset(
                    //         asset: 'icon_call',
                    //         height: 28,
                    //         width: 28,
                    //       ),
                    //     ),
                    //     const SizedBox(width: 20),
                    //     AppSplashButton(
                    //       onTap: () {
                    //         GlobalFunction.moveToChatPage(chatUserID: collaborator?.userId);
                    //       },
                    //       child: const AppImage.asset(
                    //         asset: 'icon_chat',
                    //         height: 28,
                    //         width: 28,
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                UserReviewListComponent(
                  isLoading: fillterState.status.isLoading,
                  data: fillterState.reviews,
                  tabs: fillterState.filters?.tab,
                  skills: fillterState.filters?.skill,
                  totalAmount: fillterState.totalAmount,
                  totalAvg: fillterState.totalAvg,
                  totalPercent: fillterState.totalPercent,
                  onChangeTab: (id) {
                    context.read<LegendaryReviewCubit>().updatePayload(
                          tab: id,
                          page: 1,
                        );
                    context.read<LegendaryReviewCubit>().getReviews();
                  },
                  onChangeSkill: (id) {
                    context.read<LegendaryReviewCubit>().updatePayload(
                          skill: id,
                          page: 1,
                        );
                    context.read<LegendaryReviewCubit>().getReviews();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
