import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:legend_mfast/app_data.dart';
import 'package:legend_mfast/common/bloc_status.dart';
import 'package:legend_mfast/features/legendary/repository/legendary_repository.dart';
import 'package:legend_mfast/models/collaborator/collaborator_review_filter_response_model.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_review_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_review_user_payload.dart';

import '../../../../models/collaborator/mentor_rating_model.dart';

part 'legendary_review_state.dart';

class LegendaryReviewCubit extends Cubit<LegendaryReviewState> {
  LegendaryReviewCubit() : super(const LegendaryReviewState());

  final _repository = LegendaryRepository();
  LegendaryReviewPayload _payload = LegendaryReviewPayload();
  LegendaryReviewUserPayload _reviewPayload = LegendaryReviewUserPayload();

  updatePayload({
    String? userID,
    String? tab,
    String? skill,
    int? page,
  }) {
    _payload = _payload.copyWith(
      skill: skill,
      tab: tab,
      userID: userID,
      page: page,
    );
  }

  updateReviewPayload({
    String? userID,
    String? toUserID,
    int? rating,
    String? comment,
    String? skill,
  }) {
    _reviewPayload = _reviewPayload.copyWith(
      userID: userID,
      toUserID: toUserID,
      rating: rating,
      comment: comment,
      skill: skill,
    );
  }

  getReviews({bool loadMore = false}) async {
    if (loadMore) {
      _payload = _payload.copyWith(
        page: (_payload.page ?? 0) + 1,
      );
    } else {
      emit(state.copyWith(
        status: BlocStatus.loading,
      ));
    }

    final result = await _repository.getReviews(payload: _payload);

    if (result.status) {
      final List<MentorRatingUserModel> reviews =
          loadMore ? [...state.reviews, ...?result.data?.ratingUser] : [...?result.data?.ratingUser];

      emit(state.copyWith(
        status: BlocStatus.success,
        reviews: reviews,
        totalAmount: result.data?.amountRating,
        totalAvg: result.data?.avgRating,
        totalPercent: result.data?.percent,
      ));
    } else {
      emit(state.copyWith(
        status: BlocStatus.failure,
      ));
    }
  }

  getUserReview({required String toUserID}) async {
    emit(state.copyWith(
      reviewStatus: BlocStatus.loading,
    ));
    final result = await Future.wait([
      _repository.getUserReview(
        userID: AppData.instance.userID,
        toUserID: toUserID,
      ),
      _repository.getReviewFilter(userID: toUserID),
    ]);

    if (result.first.status && result.last.status) {
      emit(state.copyWith(
        reviewStatus: BlocStatus.success,
        reviewed: result.first.data as MentorRatingUserModel?,
        filters: result.last.data as LegendaryReviewFilterResponseModel?,
      ));
    } else {
      emit(state.copyWith(
        reviewStatus: BlocStatus.failure,
      ));
    }
  }

  reviewUser() async {
    emit(state.copyWith(
      sendReviewStatus: BlocStatus.loading,
    ));

    final result = await _repository.reviewUser(payload: _reviewPayload);

    if (result.status) {
      emit(state.copyWith(
        sendReviewStatus: BlocStatus.success,
      ));
    } else {
      emit(state.copyWith(
        sendReviewStatus: BlocStatus.failure,
      ));
    }
  }
}
