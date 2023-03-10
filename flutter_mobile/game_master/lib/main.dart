import 'package:flutter/material.dart';
import 'package:game_master/app/app.locator.dart';
import 'package:game_master/app/app.router.dart';
import 'package:game_master/app/app_themes.dart';
import 'package:game_master/app/app_view_model.dart';
import 'package:game_master/core/services/navigation/navigation_service.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final app = locator<AppViewModel>();
    return GetMaterialApp(
      title: 'Quizbee - Challenger',
      theme: AppThemes.light,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      debugShowCheckedModeBanner: false,
      onInit: () async {

      }, onDispose: (){
      app.pusher.pusher.disconnect();
    },
    );
  }
}
