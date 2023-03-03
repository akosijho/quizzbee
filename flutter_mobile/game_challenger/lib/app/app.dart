import 'package:game_challenger/app/app_view_model.dart';
import 'package:game_challenger/views/challenge/challenge.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(routes: [
  CustomRoute(page: Challenge, name: "challenge", transitionsBuilder: TransitionsBuilders.zoomIn),
],
dependencies: [
  LazySingleton(classType: AppViewModel, asType: AppViewModel)
])
class App{}