import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:game_challenger/app/app.router.dart';
import 'package:game_challenger/app/app_view_model.dart';
import 'package:game_challenger/core/models/challenge.dart';
import 'package:game_challenger/core/models/player.dart';
import 'package:game_challenger/utils/choice_checker.dart';
import 'package:game_challenger/views/widgets/conection_response.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class NewChallengeViewModel extends AppViewModel {
  bool isLocked = false;
  final Question challenge;
  Question? next;
  final Player player;
  int? index;
  int playerPoints = 0;
  int? finish;
  bool correct = false;

  Map<String, dynamic>? myOptions;

  NewChallengeViewModel({required this.challenge, required this.player});

  Timer? timer;

  Future<void> read(PusherEvent event) async {
    if(event.eventName == 'finish-event'){
      print("event ${event.data}");
      String s = event.data.toString();
      finish = s == "{\"finish\":1}" ? 1 : 0;
      print("finish $finish");
      getFinish();
    }

    if(event.eventName == 'my-event'){

      String s = event.data.toString();
      if (s != "[]") {
        var n = s.substring(1, s.length - 1);
        var n1 = n.substring(1, n.length - 1);
        String unescapedString =
        n1.replaceAll('\\\"', '"').replaceAll('\\\\', '');
        var j = jsonDecode(unescapedString);
        next = Question(
            id: j['id'],
            question: j['question'],
            status: j['status'],
            answer: j['answer'],
            choice: (j['choice'] as List<dynamic>)
                .map((e) => Option.fromJson(e as Map<String, dynamic>))
                .toList());
        print('j $next');
        if (challenge != next) {
          // timer!.cancel();
          nav.pushReplacementNamed(Routes.challenge,
              arguments: ChallengeArguments(challenge: next!, player: player));

          notifyListeners();
        }
      }
    }
  }

  void init() async {
    pusher.init(read);
    getChallenge();
    getPoints();
    // timer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
    //   getChallenge();
    //   getFinish();
    // });
    notifyListeners();
  }

  void locked(Option o, int choiceIndex) async {
    index = choiceIndex;
    if (isLocked == false) {
      if (challenge.answer == choiceChecker(challenge.choice!.indexOf(o))) {
        correct = true;
        isLocked = true;
        notifyListeners();
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

  void pointUpload(Option o) async {
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

  Future<void> getChallenge() async {
    // setBusy(true);
    try {
      var temp = await api.getQuestion();
      if (temp != null && temp.isNotEmpty) {
        next = temp[0];
        // print(next);
        // if (challenge != next!) {
        //   timer!.cancel();
        //   nav.pushReplacementNamed(Routes.challenge,
        //       arguments: ChallengeArguments(challenge: next!, player: player));
        //
        //   notifyListeners();
        // }
      } else {
        // _timer!.cancel();
        print('finished');
      }
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
  }

  void getFinish() async {
    // try {
      // final temp = await api.finish();
      // if (temp != null) {
      //   finish = temp;
        if (finish == 1) {
          // timer!.cancel();
          await nav.pushReplacementNamed(Routes.finish,
              arguments: FinishArguments(player: player));

          notifyListeners();
        }
      //   notifyListeners();
      // }
  //   } on DioError catch (e) {
  //     connectionResponse(e);
  //     rethrow;
  //   }
  //   notifyListeners();
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
