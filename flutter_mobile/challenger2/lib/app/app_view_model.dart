import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../core/models/player.dart';
import '../core/services/api/api_service.dart';
import '../core/services/navigation/navigation_service.dart';
import '../core/services/pusher/pusher.dart';
import '../core/services/shared/shared_preference.dart';
import 'app.locator.dart';

@LazySingleton(as: AppViewModel)
class AppViewModel extends BaseViewModel{
  final nav = locator<NavigationService>();
  final api = locator<ApiService>();
  final shared = locator<SharedPreference>();
  final pusher = locator<Pusher>();

  Player? currentPlayer;

  // Question? challenge;

  // Future<void> initChallenge() async {
  //   setBusy(true);
  //   try {
  //     var temp = await api.getQuestion();
  //     if (temp != null) {
  //       challenge = temp[0];
  //     }
  //   } on DioError catch (e) {
  //     connectionResponse(e);
  //     rethrow;
  //   }
  //   setBusy(false);
  // }
}