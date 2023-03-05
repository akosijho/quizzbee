import 'package:dio/dio.dart';
import 'package:game_challenger/app/app_view_model.dart';
import 'package:game_challenger/core/models/challenge.dart';
import 'package:game_challenger/core/models/player.dart';
import 'package:game_challenger/utils/choice_checker.dart';
import 'package:game_challenger/views/widgets/conection_response.dart';

class ChallengeViewModel extends AppViewModel {
  bool isLocked = false;
  final Question challenge;
  Question? next;
  final Player player;
  int? index;
  int playerPoints = 0;

  bool correct = false;

  Map<String, dynamic>? myOptions;

  ChallengeViewModel({required this.challenge, required this.player});

  void init() async {
    challenge.choice!.shuffle();
    getPoints();
    getChallenge();
    notifyListeners();
  }

  void locked(Option o, int choiceIndex) {
    index = choiceIndex;
    print(index);
    if (isLocked == false) {
      if (challenge.answer == choiceChecker(challenge.choice!.indexOf(o))) {
        correct = true;
        isLocked = true;

        notifyListeners();
      } else {
        correct = false;
        isLocked = true;
        notifyListeners();
        return;
      }
    } else {
      return;
    }
  }

  void getChallenge() async {
    setBusy(true);
    try {
      var temp = await api.getQuestion();
      if (temp != null) {
        next = temp[0];
      }
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
    setBusy(false);
  }

  void getPoints() async {
    try {
      playerPoints = (await api.playerPoints(currentPlayer!.id!)) ?? 0;
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
    notifyListeners();
  }
}
