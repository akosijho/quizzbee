import 'dart:async';

import 'package:dio/dio.dart';
import 'package:game_challenger/app/app.router.dart';
import 'package:game_challenger/app/app_view_model.dart';
import 'package:game_challenger/core/models/challenge.dart';
import 'package:game_challenger/core/models/player.dart';
import 'package:game_challenger/utils/choice_checker.dart';
import 'package:game_challenger/views/widgets/conection_response.dart';

class NewChallengeViewModel extends AppViewModel {
  bool isLocked = false;
  final Question challenge;
  Question? next;
  final Player player;
  int? index;
  int playerPoints = 0;

  bool correct = false;

  Map<String, dynamic>? myOptions;

  NewChallengeViewModel({required this.challenge, required this.player});

  Timer? _timer;

  void init() async {
    challenge.choice!.shuffle();
    getPoints();
    // while(true){
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) async {
      await getChallenge();
      if (challenge.status != next!.status) {
        print(next);
        await nav.pushReplacementNamed(Routes.challenge,
            arguments: ChallengeArguments(challenge: next!, player: player));
        notifyListeners();
      }
      notifyListeners();
    });
    // }
    notifyListeners();
  }

  void locked(Option o, int choiceIndex) async {
    index = choiceIndex;
    if (isLocked == false) {
      if (challenge.answer == choiceChecker(challenge.choice!.indexOf(o))) {
        correct = true;
        isLocked = true;
        try {
          await api.checkAnswer(
              choiceChecker(challenge.choice!.indexOf(o)), player.id!);
          playerPoints = (await api.playerPoints(player.id!)) ?? 0;
          notifyListeners();
        } on DioError catch (e) {
          connectionResponse(e);
          rethrow;
        }
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

  Future<void> getChallenge() async {
    // setBusy(true);
    try {
      var temp = await api.getQuestion();
      if (temp != null) {
        next = temp[0];
        _timer!.cancel();
        notifyListeners();
      } else {
        print('finished');
      }
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
    // setBusy(false);
  }

  void getPoints() async {
    try {
      playerPoints = (await api.playerPoints(player.id!)) ?? 0;
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
    notifyListeners();
  }
}
