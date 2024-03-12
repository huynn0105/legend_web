// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;
import 'package:legend_mfast/common/enum/collaborator/collaborator_status.dart'
    as _i16;
import 'package:legend_mfast/features/legendary/pages/collaborator_need_to_care/collaborator_need_to_care_page.dart'
    deferred as _i1;
import 'package:legend_mfast/features/legendary/pages/collaborator_pending/collaborator_pending_page.dart'
    deferred as _i3;
import 'package:legend_mfast/features/legendary/pages/collaborator_pending_confirm/collaborator_pending_confirm_page.dart'
    deferred as _i2;
import 'package:legend_mfast/features/legendary/pages/legendary/children/collaborator/legendary_collaborator_page.dart'
    deferred as _i4;
import 'package:legend_mfast/features/legendary/pages/legendary/children/community/legendary_community_page.dart'
    deferred as _i5;
import 'package:legend_mfast/features/legendary/pages/legendary/children/overview/legendary_overview_page.dart'
    deferred as _i7;
import 'package:legend_mfast/features/legendary/pages/legendary/legendary_hier_collaborator_page.dart'
    deferred as _i6;
import 'package:legend_mfast/features/legendary/pages/legendary/legendary_page.dart'
    deferred as _i8;
import 'package:legend_mfast/features/legendary/pages/new_supporter/new_supporter_page.dart'
    deferred as _i9;
import 'package:legend_mfast/features/legendary/pages/rsm_push/children/rsm_push_history_page.dart'
    deferred as _i11;
import 'package:legend_mfast/features/legendary/pages/rsm_push/children/rsm_push_user_page.dart'
    deferred as _i13;
import 'package:legend_mfast/features/legendary/pages/rsm_push/rsm_push_page.dart'
    deferred as _i12;
import 'package:legend_mfast/features/not_found/not_found_page.dart'
    deferred as _i10;
import 'package:legend_mfast/models/collaborator/collaborator_my_supporter_waiting_model.dart'
    as _i18;
import 'package:scroll_to_index/scroll_to_index.dart' as _i17;

abstract class $AppRouter extends _i14.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    CollaboratorNeedToCareRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<CollaboratorNeedToCareRouteArgs>(
          orElse: () => CollaboratorNeedToCareRouteArgs(
              initIndex: queryParams.optInt('initIndex')));
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.DeferredWidget(
          _i1.loadLibrary,
          () => _i14.WrappedRoute(
              child: _i1.CollaboratorNeedToCarePage(
            key: args.key,
            collaboratorStatus: args.collaboratorStatus,
            initIndex: args.initIndex,
          )),
        ),
      );
    },
    CollaboratorPendingConfrimRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<CollaboratorPendingConfrimRouteArgs>(
          orElse: () => CollaboratorPendingConfrimRouteArgs(
              id: queryParams.optString('ID')));
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.DeferredWidget(
          _i2.loadLibrary,
          () => _i14.WrappedRoute(
              child: _i2.CollaboratorPendingConfrimPage(
            key: args.key,
            id: args.id,
            onRemoveItem: args.onRemoveItem,
          )),
        ),
      );
    },
    CollaboratorPendingRoute.name: (routeData) {
      final args = routeData.argsAs<CollaboratorPendingRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.DeferredWidget(
          _i3.loadLibrary,
          () => _i14.WrappedRoute(
              child: _i3.CollaboratorPendingPage(
            key: args.key,
            userPending: args.userPending,
            onUserPendingChange: args.onUserPendingChange,
          )),
        ),
      );
    },
    LegendaryCollaboratorRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.DeferredWidget(
          _i4.loadLibrary,
          () => _i4.LegendaryCollaboratorPage(),
        ),
      );
    },
    LegendaryCommunityRoute.name: (routeData) {
      final args = routeData.argsAs<LegendaryCommunityRouteArgs>(
          orElse: () => const LegendaryCommunityRouteArgs());
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.DeferredWidget(
          _i5.loadLibrary,
          () => _i14.WrappedRoute(
              child: _i5.LegendaryCommunityPage(
            key: args.key,
            userID: args.userID,
          )),
        ),
      );
    },
    LegendaryHierCollaboratorRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<LegendaryHierCollaboratorRouteArgs>(
          orElse: () => LegendaryHierCollaboratorRouteArgs(
              userID: queryParams.optString('userID')));
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.DeferredWidget(
          _i6.loadLibrary,
          () => _i6.LegendaryHierCollaboratorPage(
            key: args.key,
            userID: args.userID,
          ),
        ),
      );
    },
    LegendaryOverviewRoute.name: (routeData) {
      final args = routeData.argsAs<LegendaryOverviewRouteArgs>(
          orElse: () => const LegendaryOverviewRouteArgs());
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.DeferredWidget(
          _i7.loadLibrary,
          () => _i14.WrappedRoute(
              child: _i7.LegendaryOverviewPage(
            key: args.key,
            userID: args.userID,
            autoScrollController: args.autoScrollController,
            legendaryExperienceKey: args.legendaryExperienceKey,
            legendaryIncomeKey: args.legendaryIncomeKey,
            legendaryCollaboratorKey: args.legendaryCollaboratorKey,
          )),
        ),
      );
    },
    LegendaryRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<LegendaryRouteArgs>(
          orElse: () =>
              LegendaryRouteArgs(userID: queryParams.optString('userID')));
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.DeferredWidget(
          _i8.loadLibrary,
          () => _i8.LegendaryPage(
            key: args.key,
            userID: args.userID,
          ),
        ),
      );
    },
    NewSupporterRoute.name: (routeData) {
      final args = routeData.argsAs<NewSupporterRouteArgs>(
          orElse: () => const NewSupporterRouteArgs());
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.DeferredWidget(
          _i9.loadLibrary,
          () => _i14.WrappedRoute(
              child: _i9.NewSupporterPage(
            key: args.key,
            mySupporterWaiting: args.mySupporterWaiting,
          )),
        ),
      );
    },
    NotFoundRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.DeferredWidget(
          _i10.loadLibrary,
          () => _i10.NotFoundPage(),
        ),
      );
    },
    RSMPushHistoryRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.DeferredWidget(
          _i11.loadLibrary,
          () => _i11.RSMPushHistoryPage(),
        ),
      );
    },
    RSMPushRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.DeferredWidget(
          _i12.loadLibrary,
          () => _i14.WrappedRoute(child: _i12.RSMPushPage()),
        ),
      );
    },
    RSMPushUserRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.DeferredWidget(
          _i13.loadLibrary,
          () => _i13.RSMPushUserPage(),
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.CollaboratorNeedToCarePage]
class CollaboratorNeedToCareRoute
    extends _i14.PageRouteInfo<CollaboratorNeedToCareRouteArgs> {
  CollaboratorNeedToCareRoute({
    _i15.Key? key,
    _i16.CollaboratorStatus? collaboratorStatus,
    int? initIndex,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          CollaboratorNeedToCareRoute.name,
          args: CollaboratorNeedToCareRouteArgs(
            key: key,
            collaboratorStatus: collaboratorStatus,
            initIndex: initIndex,
          ),
          rawQueryParams: {'initIndex': initIndex},
          initialChildren: children,
        );

  static const String name = 'CollaboratorNeedToCareRoute';

  static const _i14.PageInfo<CollaboratorNeedToCareRouteArgs> page =
      _i14.PageInfo<CollaboratorNeedToCareRouteArgs>(name);
}

class CollaboratorNeedToCareRouteArgs {
  const CollaboratorNeedToCareRouteArgs({
    this.key,
    this.collaboratorStatus,
    this.initIndex,
  });

  final _i15.Key? key;

  final _i16.CollaboratorStatus? collaboratorStatus;

  final int? initIndex;

  @override
  String toString() {
    return 'CollaboratorNeedToCareRouteArgs{key: $key, collaboratorStatus: $collaboratorStatus, initIndex: $initIndex}';
  }
}

/// generated route for
/// [_i2.CollaboratorPendingConfrimPage]
class CollaboratorPendingConfrimRoute
    extends _i14.PageRouteInfo<CollaboratorPendingConfrimRouteArgs> {
  CollaboratorPendingConfrimRoute({
    _i15.Key? key,
    String? id,
    dynamic Function(String?)? onRemoveItem,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          CollaboratorPendingConfrimRoute.name,
          args: CollaboratorPendingConfrimRouteArgs(
            key: key,
            id: id,
            onRemoveItem: onRemoveItem,
          ),
          rawQueryParams: {'ID': id},
          initialChildren: children,
        );

  static const String name = 'CollaboratorPendingConfrimRoute';

  static const _i14.PageInfo<CollaboratorPendingConfrimRouteArgs> page =
      _i14.PageInfo<CollaboratorPendingConfrimRouteArgs>(name);
}

class CollaboratorPendingConfrimRouteArgs {
  const CollaboratorPendingConfrimRouteArgs({
    this.key,
    this.id,
    this.onRemoveItem,
  });

  final _i15.Key? key;

  final String? id;

  final dynamic Function(String?)? onRemoveItem;

  @override
  String toString() {
    return 'CollaboratorPendingConfrimRouteArgs{key: $key, id: $id, onRemoveItem: $onRemoveItem}';
  }
}

/// generated route for
/// [_i3.CollaboratorPendingPage]
class CollaboratorPendingRoute
    extends _i14.PageRouteInfo<CollaboratorPendingRouteArgs> {
  CollaboratorPendingRoute({
    _i15.Key? key,
    required int userPending,
    required dynamic Function(int) onUserPendingChange,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          CollaboratorPendingRoute.name,
          args: CollaboratorPendingRouteArgs(
            key: key,
            userPending: userPending,
            onUserPendingChange: onUserPendingChange,
          ),
          initialChildren: children,
        );

  static const String name = 'CollaboratorPendingRoute';

  static const _i14.PageInfo<CollaboratorPendingRouteArgs> page =
      _i14.PageInfo<CollaboratorPendingRouteArgs>(name);
}

class CollaboratorPendingRouteArgs {
  const CollaboratorPendingRouteArgs({
    this.key,
    required this.userPending,
    required this.onUserPendingChange,
  });

  final _i15.Key? key;

  final int userPending;

  final dynamic Function(int) onUserPendingChange;

  @override
  String toString() {
    return 'CollaboratorPendingRouteArgs{key: $key, userPending: $userPending, onUserPendingChange: $onUserPendingChange}';
  }
}

/// generated route for
/// [_i4.LegendaryCollaboratorPage]
class LegendaryCollaboratorRoute extends _i14.PageRouteInfo<void> {
  const LegendaryCollaboratorRoute({List<_i14.PageRouteInfo>? children})
      : super(
          LegendaryCollaboratorRoute.name,
          initialChildren: children,
        );

  static const String name = 'LegendaryCollaboratorRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LegendaryCommunityPage]
class LegendaryCommunityRoute
    extends _i14.PageRouteInfo<LegendaryCommunityRouteArgs> {
  LegendaryCommunityRoute({
    _i15.Key? key,
    String? userID,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          LegendaryCommunityRoute.name,
          args: LegendaryCommunityRouteArgs(
            key: key,
            userID: userID,
          ),
          initialChildren: children,
        );

  static const String name = 'LegendaryCommunityRoute';

  static const _i14.PageInfo<LegendaryCommunityRouteArgs> page =
      _i14.PageInfo<LegendaryCommunityRouteArgs>(name);
}

class LegendaryCommunityRouteArgs {
  const LegendaryCommunityRouteArgs({
    this.key,
    this.userID,
  });

  final _i15.Key? key;

  final String? userID;

  @override
  String toString() {
    return 'LegendaryCommunityRouteArgs{key: $key, userID: $userID}';
  }
}

/// generated route for
/// [_i6.LegendaryHierCollaboratorPage]
class LegendaryHierCollaboratorRoute
    extends _i14.PageRouteInfo<LegendaryHierCollaboratorRouteArgs> {
  LegendaryHierCollaboratorRoute({
    _i15.Key? key,
    String? userID,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          LegendaryHierCollaboratorRoute.name,
          args: LegendaryHierCollaboratorRouteArgs(
            key: key,
            userID: userID,
          ),
          rawQueryParams: {'userID': userID},
          initialChildren: children,
        );

  static const String name = 'LegendaryHierCollaboratorRoute';

  static const _i14.PageInfo<LegendaryHierCollaboratorRouteArgs> page =
      _i14.PageInfo<LegendaryHierCollaboratorRouteArgs>(name);
}

class LegendaryHierCollaboratorRouteArgs {
  const LegendaryHierCollaboratorRouteArgs({
    this.key,
    this.userID,
  });

  final _i15.Key? key;

  final String? userID;

  @override
  String toString() {
    return 'LegendaryHierCollaboratorRouteArgs{key: $key, userID: $userID}';
  }
}

/// generated route for
/// [_i7.LegendaryOverviewPage]
class LegendaryOverviewRoute
    extends _i14.PageRouteInfo<LegendaryOverviewRouteArgs> {
  LegendaryOverviewRoute({
    _i15.Key? key,
    String? userID,
    _i17.AutoScrollController? autoScrollController,
    _i15.GlobalKey<_i15.State<_i15.StatefulWidget>>? legendaryExperienceKey,
    _i15.GlobalKey<_i15.State<_i15.StatefulWidget>>? legendaryIncomeKey,
    _i15.GlobalKey<_i15.State<_i15.StatefulWidget>>? legendaryCollaboratorKey,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          LegendaryOverviewRoute.name,
          args: LegendaryOverviewRouteArgs(
            key: key,
            userID: userID,
            autoScrollController: autoScrollController,
            legendaryExperienceKey: legendaryExperienceKey,
            legendaryIncomeKey: legendaryIncomeKey,
            legendaryCollaboratorKey: legendaryCollaboratorKey,
          ),
          initialChildren: children,
        );

  static const String name = 'LegendaryOverviewRoute';

  static const _i14.PageInfo<LegendaryOverviewRouteArgs> page =
      _i14.PageInfo<LegendaryOverviewRouteArgs>(name);
}

class LegendaryOverviewRouteArgs {
  const LegendaryOverviewRouteArgs({
    this.key,
    this.userID,
    this.autoScrollController,
    this.legendaryExperienceKey,
    this.legendaryIncomeKey,
    this.legendaryCollaboratorKey,
  });

  final _i15.Key? key;

  final String? userID;

  final _i17.AutoScrollController? autoScrollController;

  final _i15.GlobalKey<_i15.State<_i15.StatefulWidget>>? legendaryExperienceKey;

  final _i15.GlobalKey<_i15.State<_i15.StatefulWidget>>? legendaryIncomeKey;

  final _i15.GlobalKey<_i15.State<_i15.StatefulWidget>>?
      legendaryCollaboratorKey;

  @override
  String toString() {
    return 'LegendaryOverviewRouteArgs{key: $key, userID: $userID, autoScrollController: $autoScrollController, legendaryExperienceKey: $legendaryExperienceKey, legendaryIncomeKey: $legendaryIncomeKey, legendaryCollaboratorKey: $legendaryCollaboratorKey}';
  }
}

/// generated route for
/// [_i8.LegendaryPage]
class LegendaryRoute extends _i14.PageRouteInfo<LegendaryRouteArgs> {
  LegendaryRoute({
    _i15.Key? key,
    String? userID,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          LegendaryRoute.name,
          args: LegendaryRouteArgs(
            key: key,
            userID: userID,
          ),
          rawQueryParams: {'userID': userID},
          initialChildren: children,
        );

  static const String name = 'LegendaryRoute';

  static const _i14.PageInfo<LegendaryRouteArgs> page =
      _i14.PageInfo<LegendaryRouteArgs>(name);
}

class LegendaryRouteArgs {
  const LegendaryRouteArgs({
    this.key,
    this.userID,
  });

  final _i15.Key? key;

  final String? userID;

  @override
  String toString() {
    return 'LegendaryRouteArgs{key: $key, userID: $userID}';
  }
}

/// generated route for
/// [_i9.NewSupporterPage]
class NewSupporterRoute extends _i14.PageRouteInfo<NewSupporterRouteArgs> {
  NewSupporterRoute({
    _i15.Key? key,
    _i18.MySupporterWaitingModel? mySupporterWaiting,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          NewSupporterRoute.name,
          args: NewSupporterRouteArgs(
            key: key,
            mySupporterWaiting: mySupporterWaiting,
          ),
          initialChildren: children,
        );

  static const String name = 'NewSupporterRoute';

  static const _i14.PageInfo<NewSupporterRouteArgs> page =
      _i14.PageInfo<NewSupporterRouteArgs>(name);
}

class NewSupporterRouteArgs {
  const NewSupporterRouteArgs({
    this.key,
    this.mySupporterWaiting,
  });

  final _i15.Key? key;

  final _i18.MySupporterWaitingModel? mySupporterWaiting;

  @override
  String toString() {
    return 'NewSupporterRouteArgs{key: $key, mySupporterWaiting: $mySupporterWaiting}';
  }
}

/// generated route for
/// [_i10.NotFoundPage]
class NotFoundRoute extends _i14.PageRouteInfo<void> {
  const NotFoundRoute({List<_i14.PageRouteInfo>? children})
      : super(
          NotFoundRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotFoundRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i11.RSMPushHistoryPage]
class RSMPushHistoryRoute extends _i14.PageRouteInfo<void> {
  const RSMPushHistoryRoute({List<_i14.PageRouteInfo>? children})
      : super(
          RSMPushHistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'RSMPushHistoryRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i12.RSMPushPage]
class RSMPushRoute extends _i14.PageRouteInfo<void> {
  const RSMPushRoute({List<_i14.PageRouteInfo>? children})
      : super(
          RSMPushRoute.name,
          initialChildren: children,
        );

  static const String name = 'RSMPushRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i13.RSMPushUserPage]
class RSMPushUserRoute extends _i14.PageRouteInfo<void> {
  const RSMPushUserRoute({List<_i14.PageRouteInfo>? children})
      : super(
          RSMPushUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'RSMPushUserRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}
