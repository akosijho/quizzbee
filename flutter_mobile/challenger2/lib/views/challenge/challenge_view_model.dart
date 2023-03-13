import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../app/app.router.dart';
import '../../app/app_view_model.dart';
import '../../core/models/challenge.dart';
import '../../core/models/player.dart';
import '../../utils/choice_checker.dart';
import '../widgets/conection_response.dart';

class ChallengeViewModel extends AppViewModel {
  bool isLocked = false;
  final Question challenge;
  Question? next;
  final Player player;
  int? index;
  int playerPoints = 0;
  int? finish;
  bool correct = false;
  TextEditingController answer = TextEditingController();
  Map<String, dynamic>? myOptions;

  ChallengeViewModel({required this.challenge, required this.player});

  Timer? timer;

  PusherEvent event =
      PusherEvent(channelName: 'my-channel', eventName: 'my-event');

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

  Future<void> read(PusherEvent event) async {
    if (event.eventName == 'finish-event') {
      print("event ${event.data}");
      String s = event.data.toString();
      finish = s == "{\"finish\":0}" ? 1 : 0;
      print("finish $finish");
      getFinish();
    }

    if (event.eventName == 'my-event') {
      print("event ${event.data}");
      if (event.data.toString() != "\"[]\"" &&
          event.data.toString() != "{}" &&
          event.data.toString().isNotEmpty == true &&
          event.data != null) {
        String s = event.data.toString();
        var n = s.substring(1, s.length - 1);
        var n1 = n.substring(1, n.length - 1);
        String unescapedString =
            n1.replaceAll('\\\"', '"').replaceAll('\\\\', '');
        var j = jsonDecode(unescapedString);
        next = Question(
            id: j['id'],
            question: j['question'],
            status: j['status'],
            tag: j['tag'],
            answer: j['answer'],
            choice: (j['choice'] as List<dynamic>)
                .map((e) => Option.fromJson(e as Map<String, dynamic>))
                .toList());
        print('j $next');
        if (challenge != next) {
          // timer!.cancel();
          nav.pushReplacementNamed(Routes.new_challenge,
              arguments:
                  NewChallengeArguments(challenge: next!, player: player));

          notifyListeners();
        }
      }
    }
  }

  void locked(Option o, int choiceIndex) async {
    index = choiceIndex;
    if (isLocked == false) {
      isLocked = true;
      notifyListeners();
      if (challenge.answer == choiceChecker(challenge.choice!.indexOf(o))) {
        correct = true;
        isLocked = true;
        notifyListeners();
        // final result = await compute(pointUpload, "John");
        pointUpload(choiceChecker(challenge.choice!.indexOf(o)));
      } else {
        return;
      }
    } else {
      return;
    }
  }

  void checkIdentification() {
    if (isLocked == false) {
      isLocked = true;
      notifyListeners();
      if (challenge.answer!
          .toLowerCase()
          .contains(answer.value.text.toLowerCase()) ||
          answer.value.text
              .toLowerCase()
              .contains(challenge.answer!.toLowerCase())) {
        correct = true;
        notifyListeners();
        // final result = await compute(pointUpload, "John");
        pointUpload(answer.value.text);
      } else {
        return;
      }
    }
  }

  void pointUpload(String s) {
    try {
      api.checkAnswer(s, player.id!.toString()).then((value) async {
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
    // try {
    // final temp = await api.finish();
    if (finish == 1) {
      // timer!.cancel();
      await nav.pushReplacementNamed(Routes.finish,
          arguments: FinishArguments(player: player));

      notifyListeners();
    }
    // } on DioError catch (e) {
    //   connectionResponse(e);
    //   rethrow;
    // }
    notifyListeners();
  }

  void getChallenge() async {
    // setBusy(true);
    try {
      var temp = await api.getQuestion();
      if (temp != null && temp.isNotEmpty) {
        next = temp[0];
        // print(next);
        // if (challenge != next) {
        //   timer!.cancel();
        //   nav.pushReplacementNamed(Routes.new_challenge,
        //       arguments:
        //           NewChallengeArguments(challenge: next!, player: player));
        //
        //   notifyListeners();
        // }
      }
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
  }

  void getPoints() async {
    try {
      playerPoints = (await api.playerPoints(player.id!.toString())) ?? 0;
      notifyListeners();
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
    notifyListeners();
  }
}
