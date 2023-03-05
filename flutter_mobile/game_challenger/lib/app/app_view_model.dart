import 'package:dio/dio.dart';
import 'package:game_challenger/app/app.locator.dart';
import 'package:game_challenger/core/models/challenge.dart';
import 'package:game_challenger/core/models/player.dart';
import 'package:game_challenger/core/services/api/api_service.dart';
import 'package:game_challenger/core/services/navigation/navigation_service.dart';
import 'package:game_challenger/core/services/shared/shared_preference.dart';
import 'package:game_challenger/views/widgets/conection_response.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

@LazySingleton(as: AppViewModel)
class AppViewModel extends BaseViewModel{
  final nav = locator<NavigationService>();
  final api = locator<ApiService>();
  final shared = locator<SharedPreference>();

  Player? currentPlayer;

  Question? challenge;

  void getChallenge() async {
    setBusy(true);
    try {
      var temp = await api.getQuestion();
      if (temp != null) {
        challenge = temp[0];
      }
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
    setBusy(false);
  }
}