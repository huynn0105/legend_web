import 'package:auto_route/auto_route.dart';
import 'package:legend_mfast/routes/route_path.dart';
import 'package:legend_mfast/routes/routes.gr.dart';
import 'package:legend_mfast/routes/web_guard.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
  deferredLoading: true,
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: LegendaryRoute.page,
      path: RoutePath.legend,
      children: [
        AutoRoute(page: LegendaryOverviewRoute.page),
        AutoRoute(page: LegendaryCollaboratorRoute.page),
        AutoRoute(page: LegendaryCommunityRoute.page),
      ],
      guards: [WebAuthGuard()]
    ),
    AutoRoute(
      page: NotFoundRoute.page,
      path: RoutePath.notFound,
    ),
    AutoRoute(
      page: LegendaryHierCollaboratorRoute.page,
      children: [
        AutoRoute(page: LegendaryOverviewRoute.page),
        AutoRoute(page: LegendaryCollaboratorRoute.page),
        AutoRoute(page: LegendaryCommunityRoute.page),
      ],
    ),
    AutoRoute(
      page: RSMPushRoute.page,
      children: [
        AutoRoute(page: RSMPushUserRoute.page),
        AutoRoute(page: RSMPushHistoryRoute.page),
      ],
    ),
    AutoRoute(
      page: NewSupporterRoute.page,
    ),
    AutoRoute(
      page: CollaboratorNeedToCareRoute.page,
    ),
    AutoRoute(
      page: CollaboratorPendingConfrimRoute.page,
    ),
  ];
}
