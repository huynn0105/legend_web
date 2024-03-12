import 'package:legend_mfast/common/bottom_sheet/wrapper/data_wrapper.dart';
import 'package:legend_mfast/models/base_model.dart';
import 'package:legend_mfast/models/collaborator/collaborator_new_supporter_model.dart';
import 'package:legend_mfast/models/collaborator/collaborator_pending_detail_model.dart';
import 'package:legend_mfast/models/collaborator/collaborator_review_filter_response_model.dart';
import 'package:legend_mfast/models/collaborator/collaborator_status_model.dart';
import 'package:legend_mfast/models/legendary/check_change_supporter_model.dart';
import 'package:legend_mfast/models/legendary/legendary_activity_chart_model.dart';
import 'package:legend_mfast/models/legendary/legendary_collaborator_chart_model.dart';
import 'package:legend_mfast/models/legendary/legendary_experience_chart_model.dart';
import 'package:legend_mfast/models/legendary/legendary_hier_user_info_model.dart';
import 'package:legend_mfast/models/legendary/legendary_income_chart_model.dart';
import 'package:legend_mfast/models/legendary/legendary_road_chart_model.dart';
import 'package:legend_mfast/services/api/api_service.dart';
import 'package:legend_mfast/services/api/legendary/legendary_endpoint.dart';
import 'package:legend_mfast/services/api/legendary/payload/collaborators_pending_action_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/collaborators_pending_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/get_rsm_list_collaborator_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_activity_chart_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_collaborator_chart_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_collaborator_filter_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_collaborators_by_filter_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_experience_chart_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_hier_info_user_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_income_chart_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_review_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_review_user_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_road_chart_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/legendary_supporter_by_filter_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/send_notification_to_collaborator_payload.dart';
import 'package:legend_mfast/services/base/base_response.dart';

import '../../../models/collaborator/collaborator_care_filter_model.dart';
import '../../../models/collaborator/collaborator_care_list_model.dart';
import '../../../models/collaborator/collaborator_filter_model.dart';
import '../../../models/collaborator/collaborator_list_rsm_push_model.dart';
import '../../../models/collaborator/collaborator_model.dart';
import '../../../models/collaborator/collaborator_my_supporter_waiting_model.dart';
import '../../../models/collaborator/collaborator_pending_model.dart';
import '../../../models/collaborator/collaborator_rsm_push_log_model.dart';
import '../../../models/collaborator/mentor_rating_model.dart';
import 'payload/legendary_collaborators_need_care_by_filter_payload.dart';
import 'payload/remove_collaborator_payload.dart';

abstract class LegendaryApi {
  Future<BaseModel<LegendaryHierUserInfoModel>> getLegendaryHierUserInfo({
    required LegendaryHierUserInfoPayload payload,
  });

  Future<BaseModel<LegendaryRoadChartModel>> getLegendaryRoadChart({
    required LegendaryRoadChartPayload payload,
  });

  Future<BaseModel<LegendaryExperienceChartModel>> getLegendaryExperienceChart({
    required LegendaryExperienceChartPayload payload,
  });

  Future<BaseModel<LegendaryIncomeChartModel>> getLegendaryIncomeChart({
    required LegendaryIncomeChartPayload payload,
  });

  Future<BaseModel<LegendaryActivityChartModel>> getLegendaryActivityChart({
    required LegendaryActivityChartPayload payload,
  });

  Future<BaseModel<LegendaryCollaboratorChartModel>> getLegendaryCollaboratorChart({
    required LegendaryCollaboratorChartPayload payload,
  });

  Future<BaseModel<CollaboratorStatusModel>> getAllCollaboratorStatus();

  Future<BaseModel<CollaboratorFilterModel>> getCollaboratorFilter({
    required LegendaryCollaboratorFilterPayload payload,
  });

  Future<BaseModel<CollaboratorCareFilterModel>> getCollaboratorCareFilter();

  Future<BaseModel<List<CollaboratorModel>>> getCollaboratorsByFilter({
    required LegendaryCollaboratorsByFilterPayload payload,
  });

  Future<BaseModel<CollaboratorCareListModel>> getCollaboratorsNeedCareByFilter({
    required LegendaryCollaboratorsNeedCareByFilterPayload payload,
  });

  Future<BaseModel<MentorRatingModel>> getReviews({
    required LegendaryReviewPayload payload,
  });

  Future<BaseModel<LegendaryReviewFilterResponseModel>> getReviewFilter({
    required String userID,
  });

  Future<BaseModel<MentorRatingUserModel>> getUserReview({
    required String userID,
    required String toUserID,
  });

  Future<BaseModel<bool>> reviewUser({
    required LegendaryReviewUserPayload payload,
  });

  Future<BaseModel<CheckChangeSupporterModel>> checkChangeSupporter();

  Future<BaseModel<bool>> leaveSupporter();

  Future<BaseModel<List<DataWrapper>>> getProvinces();

  Future<BaseModel<List<DataWrapper>>> getDistricts({required String provinceID});

  Future<BaseModel<List<LegendaryNewSupporterModel>>> getSupporters({
    required LegendarySupporterByFilterPayload payload,
  });

  Future<BaseModel<bool>> changeSupporter({
    required String toUserID,
    String? note,
  });

  Future<BaseModel<String>> checkExistRemoveAction();

  Future<BaseModel<String>> removeCollaborator(RemoveCollaboratorPayload payload);

  Future<BaseModel<CollaboratorListRsmPushModel>> getRSMListCollaborator(GetRsmListCollaboratorPayload payload);

  Future<BaseModel<bool>> sendNotificationToCollaborator(SendNotificationToCollaboratorPayload payload);

  Future<BaseModel<List<CollaboratorRsmPushLogModel>>> getRSMPushLog();

  Future<BaseModel<MySupporterWaitingModel>> getSupporterWaiting();

  Future<BaseModel<List<CollaboratorPendingModel>>> getCollaboratorPending(CollaboratorsPendingPayload payload);

  Future<BaseModel> confirmCollaboratorPending(CollaboratorsPendingActionPayload payload);

  Future<BaseModel<List<CollaboratorPendingDetailModel>>> getDetailCollaboratorPending(String id);
}

class LegendaryApiImpl implements LegendaryApi {
  @override
  Future<BaseModel<LegendaryHierUserInfoModel>> getLegendaryHierUserInfo({
    required LegendaryHierUserInfoPayload payload,
  }) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getLegendaryHierUserInfo(payload: payload),
    );
    if (apiResponse.status == true) {
      return BaseModel<LegendaryHierUserInfoModel>(
        status: true,
        data: LegendaryHierUserInfoModel.fromJson(apiResponse.data),
      );
    } else {
      return BaseModel<LegendaryHierUserInfoModel>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<LegendaryRoadChartModel>> getLegendaryRoadChart({
    required LegendaryRoadChartPayload payload,
  }) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getLegendaryRoadChart(payload: payload),
    );
    if (apiResponse.status == true) {
      return BaseModel<LegendaryRoadChartModel>(
        status: true,
        data: LegendaryRoadChartModel.fromJson(apiResponse.data),
      );
    } else {
      return BaseModel<LegendaryRoadChartModel>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<LegendaryExperienceChartModel>> getLegendaryExperienceChart({
    required LegendaryExperienceChartPayload payload,
  }) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getLegendaryExperienceChart(payload: payload),
    );
    if (apiResponse.status == true) {
      return BaseModel<LegendaryExperienceChartModel>(
        status: true,
        data: LegendaryExperienceChartModel.fromChartJson(apiResponse.data, keyword: payload.directSales),
      );
    } else {
      return BaseModel<LegendaryExperienceChartModel>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<LegendaryIncomeChartModel>> getLegendaryIncomeChart({
    required LegendaryIncomeChartPayload payload,
  }) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getLegendaryIncomeChart(payload: payload),
    );
    if (apiResponse.status == true) {
      return BaseModel<LegendaryIncomeChartModel>(
        status: true,
        data: LegendaryIncomeChartModel.fromChartJson(apiResponse.data, keyword: payload.directSales),
      );
    } else {
      return BaseModel<LegendaryIncomeChartModel>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<LegendaryActivityChartModel>> getLegendaryActivityChart({
    required LegendaryActivityChartPayload payload,
  }) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getLegendaryActivityChart(payload: payload),
    );
    if (apiResponse.status == true) {
      return BaseModel<LegendaryActivityChartModel>(
        status: true,
        data: LegendaryActivityChartModel.fromJson(apiResponse.data),
      );
    } else {
      return BaseModel<LegendaryActivityChartModel>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<LegendaryCollaboratorChartModel>> getLegendaryCollaboratorChart({
    required LegendaryCollaboratorChartPayload payload,
  }) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getLegendaryCollaboratorChart(payload: payload),
    );
    if (apiResponse.status == true) {
      return BaseModel<LegendaryCollaboratorChartModel>(
        status: true,
        data: LegendaryCollaboratorChartModel.fromJson(apiResponse.data),
      );
    } else {
      return BaseModel<LegendaryCollaboratorChartModel>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<CollaboratorStatusModel>> getAllCollaboratorStatus() async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getAllCollaboratorStatus(),
    );
    if (apiResponse.status == true) {
      return BaseModel<CollaboratorStatusModel>(
        status: true,
        data: CollaboratorStatusModel.fromJson(apiResponse.data),
      );
    } else {
      return BaseModel<CollaboratorStatusModel>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<CollaboratorFilterModel>> getCollaboratorFilter({
    required LegendaryCollaboratorFilterPayload payload,
  }) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getCollaboratorFilter(payload: payload),
    );
    if (apiResponse.status == true) {
      return BaseModel<CollaboratorFilterModel>(
        status: true,
        data: CollaboratorFilterModel.fromJson(apiResponse.data),
      );
    } else {
      return BaseModel<CollaboratorFilterModel>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<CollaboratorCareFilterModel>> getCollaboratorCareFilter() async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getCollaboratorCareFilter(),
    );
    if (apiResponse.status == true) {
      return BaseModel<CollaboratorCareFilterModel>(
        status: true,
        data: CollaboratorCareFilterModel.fromJson(apiResponse.data),
      );
    } else {
      return BaseModel<CollaboratorCareFilterModel>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<List<CollaboratorModel>>> getCollaboratorsByFilter({
    required LegendaryCollaboratorsByFilterPayload payload,
  }) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getCollaboratorsByFilter(payload: payload),
    );
    if (apiResponse.status == true) {
      final data = apiResponse.data?['list'] as List?;
      return BaseModel<List<CollaboratorModel>>(
        status: true,
        data: data?.map((e) => CollaboratorModel.fromJson(e)).toList(),
      );
    } else {
      return BaseModel<List<CollaboratorModel>>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<CollaboratorCareListModel>> getCollaboratorsNeedCareByFilter({
    required LegendaryCollaboratorsNeedCareByFilterPayload payload,
  }) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getCollaboratorsNeedCareByFilter(payload: payload),
    );
    if (apiResponse.status == true) {
      return BaseModel<CollaboratorCareListModel>(
        status: true,
        data: CollaboratorCareListModel.fromJson(apiResponse.data),
      );
    } else {
      return BaseModel<CollaboratorCareListModel>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<MentorRatingModel>> getReviews({
    required LegendaryReviewPayload payload,
  }) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getReviews(payload: payload),
    );
    if (apiResponse.status == true) {
      return BaseModel<MentorRatingModel>(
        status: true,
        data: MentorRatingModel.fromJson(apiResponse.data?['listRating']),
      );
    } else {
      return BaseModel<MentorRatingModel>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<LegendaryReviewFilterResponseModel>> getReviewFilter({required String userID}) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getReviewFilter(userID: userID),
    );
    if (apiResponse.status == true) {
      return BaseModel<LegendaryReviewFilterResponseModel>(
        status: true,
        data: LegendaryReviewFilterResponseModel.fromJson(apiResponse.data),
      );
    } else {
      return BaseModel<LegendaryReviewFilterResponseModel>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<MentorRatingUserModel>> getUserReview({required String userID, required String toUserID}) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getUserReview(userID: userID, toUserID: toUserID),
    );
    if (apiResponse.status == true) {
      return BaseModel<MentorRatingUserModel>(
        status: true,
        data: MentorRatingUserModel.fromJson(apiResponse.data),
      );
    } else {
      return BaseModel<MentorRatingUserModel>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<bool>> reviewUser({required LegendaryReviewUserPayload payload}) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().reviewUser(payload: payload),
    );
    if (apiResponse.status == true) {
      return BaseModel<bool>(
        status: true,
      );
    } else {
      return BaseModel<bool>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<CheckChangeSupporterModel>> checkChangeSupporter() async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().checkChangeSupporter(),
    );
    if (apiResponse.status == true) {
      return BaseModel<CheckChangeSupporterModel>(
        status: true,
      );
    } else {
      return BaseModel<CheckChangeSupporterModel>(
        status: false,
        data: CheckChangeSupporterModel.fromJson(apiResponse.data),
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<bool>> leaveSupporter() async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().leaveSupporter(),
    );
    if (apiResponse.status == true) {
      return BaseModel<bool>(
        status: true,
      );
    } else {
      return BaseModel<bool>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<List<DataWrapper>>> getProvinces() async {
    BaseResponse apiResponse = await APIService.instance.requestOldData(
      LegendaryEndpoint().getProvinces(),
    );
    if (apiResponse.status == true) {
      List<DataWrapper> data = [];
      if (apiResponse.data is Map) {
        data = (apiResponse.data as Map).entries.map((e) => DataWrapper(id: e.key, value: e.value)).toList();
      }

      return BaseModel<List<DataWrapper>>(
        status: true,
        data: data,
      );
    } else {
      return BaseModel<List<DataWrapper>>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<List<DataWrapper>>> getDistricts({required String provinceID}) async {
    BaseResponse apiResponse = await APIService.instance.requestOldData(
      LegendaryEndpoint().getDistricts(provinceID: provinceID),
    );
    if (apiResponse.status == true) {
      List<DataWrapper> data = [];
      if (apiResponse.data is Map) {
        data = (apiResponse.data as Map).entries.map((e) => DataWrapper(id: e.key, value: e.value)).toList();
      }

      return BaseModel<List<DataWrapper>>(
        status: true,
        data: data,
      );
    } else {
      return BaseModel<List<DataWrapper>>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<List<LegendaryNewSupporterModel>>> getSupporters({
    required LegendarySupporterByFilterPayload payload,
  }) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getSupporters(payload: payload),
    );
    if (apiResponse.status == true) {
      List<LegendaryNewSupporterModel> data = [];
      if (apiResponse.data is List) {
        data = (apiResponse.data as List).map((e) => LegendaryNewSupporterModel.fromJson(e)).toList();
      }

      return BaseModel<List<LegendaryNewSupporterModel>>(
        status: true,
        data: data,
      );
    } else {
      return BaseModel<List<LegendaryNewSupporterModel>>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<bool>> changeSupporter({required String toUserID, String? note}) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().changeSupporter(toUserID: toUserID, note: note),
    );
    if (apiResponse.status == true) {
      return BaseModel<bool>(
        status: true,
      );
    } else {
      return BaseModel<bool>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<String>> removeCollaborator(RemoveCollaboratorPayload payload) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().removeCollaborator(payload),
    );
    if (apiResponse.status == true) {
      return BaseModel<String>(
        status: true,
        data: apiResponse.data['type'],
        errorMessage: apiResponse.errorMessage,
      );
    } else {
      return BaseModel<String>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<String>> checkExistRemoveAction() async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().checkExistRemoveAction(),
    );
    if (apiResponse.status == true) {
      return BaseModel<String>(
        status: true,
        data: apiResponse.data['type'],
        errorMessage: apiResponse.errorMessage,
      );
    } else {
      return BaseModel<String>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<CollaboratorListRsmPushModel>> getRSMListCollaborator(GetRsmListCollaboratorPayload payload) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getRSMListCollaborator(payload),
    );
    if (apiResponse.status == true) {
      return BaseModel<CollaboratorListRsmPushModel>(
        status: true,
        data: CollaboratorListRsmPushModel.fromJson(apiResponse.raw),
        errorMessage: apiResponse.errorMessage,
      );
    } else {
      return BaseModel<CollaboratorListRsmPushModel>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<bool>> sendNotificationToCollaborator(SendNotificationToCollaboratorPayload payload) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().sendNotificationToCollaborator(payload),
    );
    if (apiResponse.status == true) {
      return BaseModel<bool>(
        status: true,
        errorMessage: apiResponse.errorMessage,
      );
    } else {
      return BaseModel<bool>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<List<CollaboratorRsmPushLogModel>>> getRSMPushLog() async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getRSMPushLog(),
    );
    if (apiResponse.status == true) {
      final data = apiResponse.data as List?;
      return BaseModel<List<CollaboratorRsmPushLogModel>>(
        status: true,
        data: data?.map((e) => CollaboratorRsmPushLogModel.fromJson(e)).toList(),
        errorMessage: apiResponse.errorMessage,
      );
    } else {
      return BaseModel<List<CollaboratorRsmPushLogModel>>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<MySupporterWaitingModel>> getSupporterWaiting() async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getMySupporterWaiting(),
    );
    if (apiResponse.status == true) {
      return BaseModel<MySupporterWaitingModel>(
        status: true,
        data: apiResponse.data is List ? null : MySupporterWaitingModel.fromJson(apiResponse.data),
        errorMessage: apiResponse.errorMessage,
      );
    } else {
      return BaseModel<MySupporterWaitingModel>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }

  @override
  Future<BaseModel<List<CollaboratorPendingModel>>> getCollaboratorPending(CollaboratorsPendingPayload payload) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getCollaboratorPending(payload),
    );
    if (apiResponse.status == true && apiResponse.data is List) {
      return BaseModel<List<CollaboratorPendingModel>>(
        status: true,
        data: (apiResponse.data as List).map((e) => CollaboratorPendingModel.fromJson(e)).toList(),
        errorMessage: apiResponse.errorMessage,
      );
    } else {
      return BaseModel<List<CollaboratorPendingModel>>(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }
  
  @override
  Future<BaseModel> confirmCollaboratorPending(CollaboratorsPendingActionPayload payload) async {
    BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().confirmCollaboratorPending(payload),
    );
    if (apiResponse.status == true ) {
      return BaseModel(
        status: true,
        
      );
    } else {
      return BaseModel(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }
  
  @override
  Future<BaseModel<List<CollaboratorPendingDetailModel>>> getDetailCollaboratorPending(String id) async {
        BaseResponse apiResponse = await APIService.instance.requestData(
      LegendaryEndpoint().getDetailCollaboratorPending(id),
    );
    if (apiResponse.status == true ) {
      return BaseModel(
        status: true,
        data: (apiResponse.data as List).map((e) => CollaboratorPendingDetailModel.fromJson(e)).toList(),
      );
    } else {
      return BaseModel(
        status: false,
        errorMessage: apiResponse.errorMessage,
      );
    }
  }
}
