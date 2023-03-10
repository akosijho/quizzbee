import 'package:game_challenger/app/app.locator.dart';
import 'package:game_challenger/core/models/player.dart';
import 'package:game_challenger/core/services/api/api_service.dart';
import 'package:game_challenger/core/services/navigation/navigation_service.dart';
import 'package:game_challenger/core/services/pusher/pusher.dart';
import 'package:game_challenger/core/services/shared/shared_preference.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

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