import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../core/services/api/api_service.dart';
import '../core/services/api/api_service_impl.dart';
import '../core/services/navigation/navigation_service.dart';
import '../core/services/navigation/navigation_service_impl.dart';
import '../core/services/pusher/pusher.dart';
import '../core/services/shared/shared_preference.dart';
import '../core/services/shared/shared_preference_impl.dart';
import '../views/finish/finiish.dart';
import '../views/next/next.dart';
import '../views/next_one/next_one.dart';
import '../views/start/start.dart';
import 'app_view_model.dart';

@StackedApp(routes: [
  CustomRoute(
      page: Start,
      name: "start",
      transitionsBuilder: TransitionsBuilders.slideLeft,
      initial: true),
  CustomRoute(
      page: Next,
      name: "next",
      transitionsBuilder: TransitionsBuilders.slideLeft,
      ),
  CustomRoute(
    page: NextOne,
    name: "next_one",
    transitionsBuilder: TransitionsBuilders.slideLeft,
  ),
  CustomRoute(
    page: Finish,
    name: "finish",
    transitionsBuilder: TransitionsBuilders.slideLeft,
  ),
], dependencies: [
  LazySingleton(classType: AppViewModel, asType: AppViewModel),
  LazySingleton(classType: NavigationServiceImpl, asType: NavigationService),
  LazySingleton(classType: ApiServiceImpl, asType: ApiService),
  LazySingleton(classType: SharedPreferenceImpl, asType: SharedPreference),
  LazySingleton(classType: Pusher, asType: Pusher),
])
class App {}
