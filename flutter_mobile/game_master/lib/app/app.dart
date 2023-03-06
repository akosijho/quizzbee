import 'package:game_master/app/app_view_model.dart';
import 'package:game_master/core/services/api/api_service.dart';
import 'package:game_master/core/services/api/api_service_impl.dart';
import 'package:game_master/core/services/navigation/navigation_service.dart';
import 'package:game_master/core/services/navigation/navigation_service_impl.dart';
import 'package:game_master/core/services/shared/shared_preference.dart';
import 'package:game_master/core/services/shared/shared_preference_impl.dart';
import 'package:game_master/views/finish/finiish.dart';
import 'package:game_master/views/next/next.dart';
import 'package:game_master/views/next_one/next_one.dart';
import 'package:game_master/views/start/start.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

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
])
class App {}
