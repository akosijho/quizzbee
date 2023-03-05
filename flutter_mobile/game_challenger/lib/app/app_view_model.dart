import 'package:game_challenger/app/app.locator.dart';
import 'package:game_challenger/core/services/navigation/navigation_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@LazySingleton(as: AppViewModel)
class AppViewModel extends BaseViewModel{
  final nav = locator<NavigationService>();
}