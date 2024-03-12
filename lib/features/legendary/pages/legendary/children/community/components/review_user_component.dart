import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legend_mfast/app_data.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/common/bottom_sheet/wrapper/data_wrapper.dart';
import 'package:legend_mfast/common/colors.dart';
import 'package:legend_mfast/common/dialogs/dialog_view/mascot_dialog_view.dart';
import 'package:legend_mfast/common/widgets/loading.dart';
import 'package:legend_mfast/features/legendary/cubit/legendary_review/legendary_review_cubit.dart';
import 'package:legend_mfast/models/collaborator/collaborator_supporter_model.dart';
import 'package:legend_mfast/services/firebase/firebase_database/firebase_database_util.dart';

import '../../../../../../../common/bottom_sheet/views/review_view.dart';
import '../../../../../../../models/collaborator/status_review_model.dart';

class ReviewUserComponent extends StatelessWidget {
  const ReviewUserComponent({
    super.key,
    this.supporter,
    this.titleRating,
  });
  final CollaboratorSupporterModel? supporter;
  final List<DataWrapper>? titleRating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: BlocBuilder<LegendaryReviewCubit, LegendaryReviewState>(
        builder: (context, state) {
          if (state.reviewStatus.isInitial) {
            final cubit = context.read<LegendaryReviewCubit>();
            cubit.updateReviewPayload(userID: AppData.instance.userID, toUserID: supporter?.toUserID ?? "");
            cubit.getUserReview(toUserID: supporter?.toUserID ?? "");
          }

          if (state.sendReviewStatus.isSuccess || state.sendReviewStatus.isFailure) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 60,
                ),
                MascotDialogView(
                  asset: state.sendReviewStatus.isSuccess ? "ic_mtrade_mascot_success" : "ic_mtrade_mascot_error",
                  title: state.sendReviewStatus.isSuccess ? "Đánh giá thành công" : "Đánh giá thất bại",
                  message: "",
                  titleColor: state.sendReviewStatus.isSuccess ? UIColors.accentGreen : UIColors.red,
                  messageColor: UIColors.defaultText,
                  positiveTitle: "Quay lại",
                  positiveCallback: () {
                    context.popRoute();
                  },
                  messageAlign: TextAlign.center,
                ),
              ],
            );
          }

          return FractionallySizedBox(
            heightFactor: 0.8,
            child: Stack(
              children: [
                UserReviewComponent(
                  rating: state.reviewed?.rating,
                  note: state.reviewed?.comment,
                  name: supporter?.fullName ?? "",
                  url: FirebaseDatabaseUtil.convertUrlAvatar(supporter?.avatarImage) ?? "",
                  listStatus:
                      titleRating?.map((e) => StatusReview(defaultStar: e.id, statusName: e.value)).toList() ?? [],
                  onSubmitReview: (int rating, String? note) {
                    final cubit = context.read<LegendaryReviewCubit>();
                    cubit.updateReviewPayload(comment: note, rating: rating);
                    cubit.reviewUser();
                  },
                ),
                Visibility(
                  visible: state.reviewStatus.showLoading,
                  child: const LoadingWidget.withoutText(),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
