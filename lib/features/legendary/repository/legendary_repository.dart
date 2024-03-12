import 'package:legend_mfast/common/bottom_sheet/wrapper/data_wrapper.dart';
import 'package:legend_mfast/models/base_model.dart';
import 'package:legend_mfast/models/collaborator/collaborator_care_filter_model.dart';
import 'package:legend_mfast/models/collaborator/collaborator_filter_model.dart';
import 'package:legend_mfast/models/collaborator/collaborator_new_supporter_model.dart';
import 'package:legend_mfast/models/collaborator/collaborator_pending_model.dart';
import 'package:legend_mfast/models/collaborator/collaborator_review_filter_response_model.dart';
import 'package:legend_mfast/services/api/api_provider.dart';
import 'package:legend_mfast/services/api/legendary/payload/collaborators_pending_action_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/collaborators_pending_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/get_rsm_list_collaborator_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_activity_chart_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_collaborator_chart_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_collaborator_filter_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_collaborators_by_filter_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_collaborators_need_care_by_filter_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_experience_chart_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_hier_info_user_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_income_chart_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_review_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_review_user_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_road_chart_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_supporter_by_filter_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/send_notification_to_collaborator_payload.dart';

import '../../../models/collaborator/collaborator_care_list_model.dart';
import '../../../models/collaborator/collaborator_list_rsm_push_model.dart';
import '../../../models/collaborator/collaborator_model.dart';
import '../../../models/collaborator/collaborator_my_supporter_waiting_model.dart';
import '../../../models/collaborator/collaborator_pending_detail_model.dart';
import '../../../models/collaborator/collaborator_rsm_push_log_model.dart';
import '../../../models/collaborator/collaborator_status_model.dart';
import '../../../models/collaborator/mentor_rating_model.dart';
import '../../../models/legendary/check_change_supporter_model.dart';
import '../../../models/legendary/legendary_activity_chart_model.dart';
import '../../../models/legendary/legendary_collaborator_chart_model.dart';
import '../../../models/legendary/legendary_experience_chart_model.dart';
import '../../../models/legendary/legendary_hier_user_info_model.dart';
import '../../../models/legendary/legendary_income_chart_model.dart';
import '../../../models/legendary/legendary_road_chart_model.dart';
import '../../../services/api/legendary/payload/remove_collaborator_payload.dart';

class LegendaryRepository {
  Future<BaseModel<LegendaryHierUserInfoModel>> getLegendaryHierUserInfo({
    required LegendaryHierUserInfoPayload payload,
  }) {
    return ApiProvider.instance.legend.getLegendaryHierUserInfo(payload: payload);
  }

  Future<BaseModel<LegendaryRoadChartModel>> getLegendaryRoadChart({
    required LegendaryRoadChartPayload payload,
  }) {
    return ApiProvider.instance.legend.getLegendaryRoadChart(payload: payload);
  }

  Future<BaseModel<LegendaryExperienceChartModel>> getLegendaryExperienceChart({
    required LegendaryExperienceChartPayload payload,
  }) {
    return ApiProvider.instance.legend.getLegendaryExperienceChart(payload: payload);
  }

  Future<BaseModel<LegendaryIncomeChartModel>> getLegendaryIncomeChart({
    required LegendaryIncomeChartPayload payload,
  }) {
    return ApiProvider.instance.legend.getLegendaryIncomeChart(payload: payload);
  }

  Future<BaseModel<LegendaryActivityChartModel>> getLegendaryActivityChart({
    required LegendaryActivityChartPayload payload,
  }) {
    return ApiProvider.instance.legend.getLegendaryActivityChart(payload: payload);
  }

  Future<BaseModel<LegendaryCollaboratorChartModel>> getLegendaryCollaboratorChart({
    required LegendaryCollaboratorChartPayload payload,
  }) {
    return ApiProvider.instance.legend.getLegendaryCollaboratorChart(payload: payload);
  }

  Future<BaseModel<CollaboratorStatusModel>> getAllCollaboratorStatus() {
    return ApiProvider.instance.legend.getAllCollaboratorStatus();
  }

  Future<BaseModel<CollaboratorFilterModel>> getCollaboratorFilter({
    required LegendaryCollaboratorFilterPayload payload,
  }) {
    return ApiProvider.instance.legend.getCollaboratorFilter(payload: payload);
  }

  Future<BaseModel<CollaboratorCareFilterModel>> getCollaboratorCareFilter() {
    return ApiProvider.instance.legend.getCollaboratorCareFilter();
  }

  Future<BaseModel<List<CollaboratorModel>>> getCollaboratorsByFilter({
    required LegendaryCollaboratorsByFilterPayload payload,
  }) {
    return ApiProvider.instance.legend.getCollaboratorsByFilter(payload: payload);
  }

  Future<BaseModel<CollaboratorCareListModel>> getCollaboratorsNeedCareByFilter({
    required LegendaryCollaboratorsNeedCareByFilterPayload payload,
  }) {
    return ApiProvider.instance.legend.getCollaboratorsNeedCareByFilter(payload: payload);
  }

  Future<BaseModel<MentorRatingModel>> getReviews({
    required LegendaryReviewPayload payload,
  }) {
    return ApiProvider.instance.legend.getReviews(payload: payload);
  }

  Future<BaseModel<LegendaryReviewFilterResponseModel>> getReviewFilter({
    required String userID,
  }) {
    return ApiProvider.instance.legend.getReviewFilter(userID: userID);
  }

  Future<BaseModel<MentorRatingUserModel>> getUserReview({
    required String userID,
    required String toUserID,
  }) {
    return ApiProvider.instance.legend.getUserReview(
      userID: userID,
      toUserID: toUserID,
    );
  }

  Future<BaseModel<bool>> reviewUser({
    required LegendaryReviewUserPayload payload,
  }) {
    return ApiProvider.instance.legend.reviewUser(
      payload: payload,
    );
  }

  Future<BaseModel<CheckChangeSupporterModel>> checkChangeSupporter() {
    return ApiProvider.instance.legend.checkChangeSupporter();
  }

  Future<BaseModel<bool>> leaveSupporter() {
    return ApiProvider.instance.legend.leaveSupporter();
  }

  Future<BaseModel<List<DataWrapper>>> getProvinces() {
    return ApiProvider.instance.legend.getProvinces();
  }

  Future<BaseModel<List<DataWrapper>>> getDistricts({required String provinceID}) {
    return ApiProvider.instance.legend.getDistricts(provinceID: provinceID);
  }

  Future<BaseModel<List<LegendaryNewSupporterModel>>> getSupporters({
    required LegendarySupporterByFilterPayload payload,
  }) {
    return ApiProvider.instance.legend.getSupporters(payload: payload);
  }

  Future<BaseModel<bool>> changeSupporter({
    required String toUserID,
    String? note,
  }) {
    return ApiProvider.instance.legend.changeSupporter(toUserID: toUserID, note: note);
  }

  Future<BaseModel<String>> removeCollaborator(RemoveCollaboratorPayload payload) {
    return ApiProvider.instance.legend.removeCollaborator(payload);
  }

  Future<BaseModel<String>> checkExistRemoveAction() {
    return ApiProvider.instance.legend.checkExistRemoveAction();
  }

  Future<BaseModel<CollaboratorListRsmPushModel>> getRSMListCollaborator(GetRsmListCollaboratorPayload payload) {
    return ApiProvider.instance.legend.getRSMListCollaborator(payload);
  }

  Future<BaseModel<List<CollaboratorRsmPushLogModel>>> getRSMPushLog() {
    return ApiProvider.instance.legend.getRSMPushLog();
  }

  Future<BaseModel<bool>> sendNotificationToCollaborator(SendNotificationToCollaboratorPayload payload) {
    return ApiProvider.instance.legend.sendNotificationToCollaborator(payload);
  }

  Future<BaseModel<MySupporterWaitingModel>> getMySupporterWaiting() {
    return ApiProvider.instance.legend.getSupporterWaiting();
  }

  Future<BaseModel<List<CollaboratorPendingModel>>> getCollaboratorPending(CollaboratorsPendingPayload payload) {
    return ApiProvider.instance.legend.getCollaboratorPending(payload);
  }

  Future<BaseModel> confirmCollaboratorPending(CollaboratorsPendingActionPayload payload) {
    return ApiProvider.instance.legend.confirmCollaboratorPending(payload);
  }
  Future<BaseModel<List<CollaboratorPendingDetailModel>>> getDetailCollaboratorPending(String id) {
    return ApiProvider.instance.legend.getDetailCollaboratorPending(id);
  }
}
