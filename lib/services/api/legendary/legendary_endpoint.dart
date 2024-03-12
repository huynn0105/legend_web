import 'package:dio/dio.dart';
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
import 'package:legend_mfast/services/api/legendary/payload/remove_collaborator_payload.dart';
import 'package:legend_mfast/services/api/legendary/payload/send_notification_to_collaborator_payload.dart';
import 'package:legend_mfast/services/base/base_endpoint.dart';
import 'package:legend_mfast/services/base/method_request.dart';

import 'payload/legendary_collaborators_need_care_by_filter_payload.dart';

abstract class LegendaryEndpointProtocol {
  EndpointType getLegendaryHierUserInfo({
    required LegendaryHierUserInfoPayload payload,
  });

  EndpointType getLegendaryRoadChart({
    required LegendaryRoadChartPayload payload,
  });

  EndpointType getLegendaryExperienceChart({
    required LegendaryExperienceChartPayload payload,
  });

  EndpointType getLegendaryIncomeChart({
    required LegendaryIncomeChartPayload payload,
  });

  EndpointType getLegendaryActivityChart({
    required LegendaryActivityChartPayload payload,
  });

  EndpointType getLegendaryCollaboratorChart({
    required LegendaryCollaboratorChartPayload payload,
  });

  EndpointType getAllCollaboratorStatus();

  EndpointType getCollaboratorFilter({
    required LegendaryCollaboratorFilterPayload payload,
  });

  EndpointType getCollaboratorCareFilter();

  EndpointType getCollaboratorsByFilter({
    required LegendaryCollaboratorsByFilterPayload payload,
  });

  EndpointType getCollaboratorsNeedCareByFilter({
    required LegendaryCollaboratorsNeedCareByFilterPayload payload,
  });

  EndpointType getReviews({
    required LegendaryReviewPayload payload,
  });

  EndpointType getReviewFilter({
    required String userID,
  });

  EndpointType getUserReview({
    required String userID,
    required String toUserID,
  });

  EndpointType reviewUser({
    required LegendaryReviewUserPayload payload,
  });

  EndpointType checkChangeSupporter();

  EndpointType leaveSupporter();

  EndpointType getProvinces();

  EndpointType getDistricts({required String provinceID});

  EndpointType getSupporters({required LegendarySupporterByFilterPayload payload});

  EndpointType changeSupporter({required String toUserID, String? note});

  EndpointType checkExistRemoveAction();

  EndpointType removeCollaborator(RemoveCollaboratorPayload payload);

  EndpointType getRSMListCollaborator(GetRsmListCollaboratorPayload payload);

  EndpointType getRSMPushLog();

  EndpointType sendNotificationToCollaborator(SendNotificationToCollaboratorPayload payload);

  EndpointType getMySupporterWaiting();

  EndpointType getCollaboratorPending(CollaboratorsPendingPayload payload);

  EndpointType confirmCollaboratorPending(CollaboratorsPendingActionPayload payload);

  EndpointType getDetailCollaboratorPending(String id);
}

class LegendaryEndpoint implements LegendaryEndpointProtocol {
  @override
  EndpointType getLegendaryHierUserInfo({
    required LegendaryHierUserInfoPayload payload,
  }) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/hierarchical/hier_info_user",
      httpMethod: HttpMethod.post,
      parameters: payload.toJson(),
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getLegendaryRoadChart({
    required LegendaryRoadChartPayload payload,
  }) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/hierarchical/detail_table",
      httpMethod: HttpMethod.post,
      parameters: payload.toJson(),
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getLegendaryExperienceChart({
    required LegendaryExperienceChartPayload payload,
  }) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/hierarchical/point_chart",
      httpMethod: HttpMethod.post,
      parameters: payload.toJson(),
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getLegendaryIncomeChart({
    required LegendaryIncomeChartPayload payload,
  }) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/hierarchical/commission_chart",
      httpMethod: HttpMethod.post,
      parameters: payload.toJson(),
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getLegendaryActivityChart({
    required LegendaryActivityChartPayload payload,
  }) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/hierarchical/working_user",
      httpMethod: HttpMethod.post,
      parameters: payload.toJson(),
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getLegendaryCollaboratorChart({
    required LegendaryCollaboratorChartPayload payload,
  }) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/hierarchical/collaborator_chart",
      httpMethod: HttpMethod.post,
      parameters: payload.toJson(),
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getAllCollaboratorStatus() {
    final endpoint = EndpointType(
      path: "/app_api_v1/collaborator_leave/get_collaborator_leave",
      httpMethod: HttpMethod.get,
      parameters: {},
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getCollaboratorFilter({
    required LegendaryCollaboratorFilterPayload payload,
  }) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/hierarchical/collaborator_filter",
      httpMethod: HttpMethod.get,
      parameters: payload.toJson(),
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getCollaboratorCareFilter() {
    final endpoint = EndpointType(
      path: "/app_api_v1/collaborator_leave/get_level",
      httpMethod: HttpMethod.get,
      parameters: {},
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getCollaboratorsByFilter({
    required LegendaryCollaboratorsByFilterPayload payload,
  }) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/hierarchical/collaborator",
      httpMethod: HttpMethod.post,
      parameters: payload.toJson(),
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getCollaboratorsNeedCareByFilter({
    required LegendaryCollaboratorsNeedCareByFilterPayload payload,
  }) {
    final endpoint = EndpointType(
      path: "/app_api_v1/collaborator_leave/get_users",
      httpMethod: HttpMethod.get,
      parameters: payload.toJson(),
      listFormat: ListFormat.multiCompatible,
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getReviews({
    required LegendaryReviewPayload payload,
  }) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/hierarchical/load_page_rating_user",
      httpMethod: HttpMethod.post,
      parameters: payload.toJson(),
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getReviewFilter({required String userID}) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/hierarchical/rating_filter",
      httpMethod: HttpMethod.get,
      parameters: {
        "userID": userID,
      },
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getUserReview({required String userID, required String toUserID}) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/Personal/detail_user_rating",
      httpMethod: HttpMethod.post,
      parameters: {
        "userID": userID,
        "toUserID": toUserID,
      },
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType reviewUser({required LegendaryReviewUserPayload payload}) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/hierarchical/rating",
      httpMethod: HttpMethod.post,
      parameters: payload.toJson(),
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType checkChangeSupporter() {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/Personal/check_user_can_leave",
      httpMethod: HttpMethod.get,
      parameters: {},
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType leaveSupporter() {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/Personal/mentor_change_to_free",
      httpMethod: HttpMethod.post,
      parameters: {},
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getProvinces() {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/general/load_province",
      httpMethod: HttpMethod.get,
      parameters: {},
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getDistricts({required String provinceID}) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/general/load_district",
      httpMethod: HttpMethod.get,
      parameters: {
        "provinceID": provinceID,
      },
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getSupporters({required LegendarySupporterByFilterPayload payload}) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/Personal/mentor_filter",
      httpMethod: HttpMethod.post,
      parameters: payload.toJson(),
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType changeSupporter({required String toUserID, String? note}) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/Personal/mentor_change_process",
      httpMethod: HttpMethod.post,
      parameters: {
        "toUserID": toUserID,
        "note": note,
      },
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType checkExistRemoveAction() {
    final endpoint = EndpointType(
      path: "/app_api_v1/collaborator_leave/check_process_remove_collaborators",
      httpMethod: HttpMethod.get,
      parameters: {},
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType removeCollaborator(RemoveCollaboratorPayload payload) {
    final endpoint = EndpointType(
      path: "/app_api_v1/collaborator_leave/remove_collaborators_not_working",
      httpMethod: HttpMethod.post,
      parameters: payload.toJson(),
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getRSMListCollaborator(GetRsmListCollaboratorPayload payload) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/Personal/list_ctv",
      httpMethod: HttpMethod.get,
      parameters: payload.toJson(),
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getRSMPushLog() {
    final endpoint = EndpointType(
      path: "/app_api_v1/notification/get_notify_log",
      httpMethod: HttpMethod.get,
      parameters: {},
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType sendNotificationToCollaborator(SendNotificationToCollaboratorPayload payload) {
    final endpoint = EndpointType(
      path: "/app_api_v1/notification/push_notify",
      httpMethod: HttpMethod.post,
      parameters: payload.toJson(),
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getMySupporterWaiting() {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/Personal/mentor_reselect",
      httpMethod: HttpMethod.get,
      parameters: {},
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getCollaboratorPending(CollaboratorsPendingPayload payload) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/hierarchical/user_pending",
      httpMethod: HttpMethod.post,
      parameters: payload.toJson(),
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType confirmCollaboratorPending(CollaboratorsPendingActionPayload payload) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/personal/action_rsa_waiting",
      httpMethod: HttpMethod.post,
      parameters: payload.toJson(),
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }

  @override
  EndpointType getDetailCollaboratorPending(String id) {
    final endpoint = EndpointType(
      path: "/mfast_api_v1/personal/list_rsa_waiting",
      httpMethod: HttpMethod.get,
      parameters: {'ID': id},
      header: DefaultHeader.instance.addDefaultHeader(),
    );
    return endpoint;
  }
}
