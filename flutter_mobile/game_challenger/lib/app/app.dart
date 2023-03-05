import 'package:game_challenger/app/app_view_model.dart';
import 'package:game_challenger/core/services/navigation/navigation_service.dart';
import 'package:game_challenger/core/services/navigation/navigation_service_impl.dart';
import 'package:game_challenger/views/challenge/challenge.dart';
import 'package:game_challenger/views/registration/register.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(routes: [
  CustomRoute(
      page: Challenge,
      name: "challenge",
      transitionsBuilder: TransitionsBuilders.zoomIn,),
  CustomRoute(
      page: Register,
      name: "register",
      transitionsBuilder: TransitionsBuilders.slideLeft,
      initial: true),
], dependencies: [
  LazySingleton(classType: AppViewModel, asType: AppViewModel),
  LazySingleton(classType: NavigationServiceImpl, asType: NavigationService),
])
class App {}
