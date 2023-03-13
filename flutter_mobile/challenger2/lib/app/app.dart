import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../core/services/api/api_service.dart';
import '../core/services/api/api_service_impl.dart';
import '../core/services/navigation/navigation_service.dart';
import '../core/services/navigation/navigation_service_impl.dart';
import '../core/services/pusher/pusher.dart';
import '../core/services/shared/shared_preference.dart';
import '../core/services/shared/shared_preference_impl.dart';
import '../views/challenge/challenge.dart';
import '../views/finiish/finish.dart';
import '../views/new_challenge/challenge.dart';
import '../views/registration/register.dart';
import '../views/waiting_room/waiting.dart';
import 'app_view_model.dart';

@StackedApp(routes: [
  CustomRoute(
      page: Challenge,
      name: "challenge",
      transitionsBuilder: TransitionsBuilders.slideLeft,
      durationInMilliseconds: 250),

  CustomRoute(
    page: NewChallenge,
    name: "new_challenge",
    transitionsBuilder: TransitionsBuilders.slideLeft,
      durationInMilliseconds: 250),

  CustomRoute(
    page: Waitng,
    name: "wait",
    transitionsBuilder: TransitionsBuilders.slideLeft,
      durationInMilliseconds: 250),
  CustomRoute(
      page: Finish,
      name: "finish",
      transitionsBuilder: TransitionsBuilders.slideLeft,
      durationInMilliseconds: 250),
  CustomRoute(
      page: Register,
      name: "register",
      transitionsBuilder: TransitionsBuilders.zoomIn,
      durationInMilliseconds: 250,
      initial: true),
], dependencies: [
  LazySingleton(classType: AppViewModel, asType: AppViewModel),
  LazySingleton(classType: NavigationServiceImpl, asType: NavigationService),
  LazySingleton(classType: ApiServiceImpl, asType: ApiService),
  LazySingleton(classType: SharedPreferenceImpl, asType: SharedPreference),
  LazySingleton(classType: Pusher, asType: Pusher),
])
class App {}
