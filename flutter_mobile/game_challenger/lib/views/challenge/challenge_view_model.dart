import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:game_challenger/app/app.router.dart';
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
  int? finish;
  bool correct = false;

  Map<String, dynamic>? myOptions;

  ChallengeViewModel({required this.challenge, required this.player});

  Timer? timer;

  void init() async {
    // challenge.choice!.shuffle();
    getPoints();
    timer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
      getChallenge();
      getFinish();
    });
    notifyListeners();
  }

  void locked(Option o, int choiceIndex) async {
    index = choiceIndex;
    if (isLocked == false) {
      if (challenge.answer == choiceChecker(challenge.choice!.indexOf(o))) {
        correct = true;
        isLocked = true;
        notifyListeners();
        // final result = await compute(pointUpload, "John");
        pointUpload(o);
      } else {
        isLocked = true;
        notifyListeners();
        return;
      }
    } else {
      return;
    }
  }

  void pointUpload(Option o) {
    try {
      api
          .checkAnswer(choiceChecker(challenge.choice!.indexOf(o)),
              player.id!.toString())
          .then((value) async {
        playerPoints = (await api.playerPoints(player.id!.toString())) ?? 0;
        notifyListeners();
      });
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
    notifyListeners();
  }

  void getFinish() async {
    try {
      final temp = await api.finish();
      if (temp != null) {
        finish = temp;
        if (finish == 1) {
          timer!.cancel();
          nav.pushReplacementNamed(Routes.finish,
              arguments: FinishArguments(player: player));

          notifyListeners();
        }
        notifyListeners();
      }
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
    notifyListeners();
  }

  void getChallenge() async {
    // setBusy(true);
    try {
      var temp = await api.getQuestion();
      if (temp != null && temp.isNotEmpty) {
        next = temp[0];
        print(next);
        if (challenge != next) {
          timer!.cancel();
          nav.pushReplacementNamed(Routes.new_challenge,
              arguments:
                  NewChallengeArguments(challenge: next!, player: player));

          notifyListeners();
        }
      } else {
        // _timer!.cancel();cancel
        print('finished');
      }
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
  }

  void getPoints() async {
    try {
      playerPoints = (await api.playerPoints(player.id!.toString())) ?? 0;
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
    notifyListeners();
  }
}
