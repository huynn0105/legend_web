import 'package:auto_route/auto_route.dart';
import 'package:legend_mfast/app_data.dart';
import 'package:legend_mfast/routes/routes.dart';

import '../common/utils/text_util.dart';
import '../di/get_it.dart';
import 'routes.gr.dart';

class WebAuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    String? accessToken = Uri.base.queryParameters["accessToken"];
    if (TextUtils.isEmpty(accessToken) || TextUtils.isEmpty(AppData.instance.userID)) {
      getItInstance.get<AppRouter>().replace(const NotFoundRoute());
    } else {
      resolver.next(true);
    }
  }
}
