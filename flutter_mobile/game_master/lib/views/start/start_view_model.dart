import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:game_master/app/app.router.dart';
import 'package:game_master/app/app_view_model.dart';
import 'package:game_master/core/models/challenge.dart';
import 'package:game_master/widgets/conection_response.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class StartViewModel extends AppViewModel {
  Question? challenge;
  bool? proceed;

  void init() async {
    pusher.init(read);
    await getChallenge();
  }

  Future<void> read(PusherEvent event) async {
    debugPrint("event ${event.data}");

    if (event.eventName == "my-event") {
      String s = event.data.toString();
      if (s != "{}") {
        var n = s.substring(1, s.length - 1);
        var n1 = n.substring(1, n.length - 1);
        String unescapedString =
            n1.replaceAll('\\\"', '"').replaceAll('\\\\', '');
        var j = jsonDecode(unescapedString);
        challenge = Question(
            id: j['id'],
            question: j['question'],
            status: j['status'],
            answer: j['answer'],
            choice: (j['choice'] as List<dynamic>)
                .map((e) => Option.fromJson(e as Map<String, dynamic>))
                .toList());
        notifyListeners();
        debugPrint("challenge $challenge");
      }
    }
    if (event.eventName == 'waiting-event') {
      debugPrint("event ${event.data}");
      String data = event.data.toString();
      if (data == "{\"waiting_room\":0}") {
        proceed = true;
        await nav.pushReplacementNamed(Routes.next,
            arguments: NextArguments(q: challenge!));
      } else {
        proceed = false;
      }
      print('proceed $proceed');
      notifyListeners();
    }
  }

  void toNext() async {
    try {
      await api.waiting();
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
  }

  Future<Question?> getChallenge() async {
    try {
      var temp = await api.getQuestion();
      if (temp != null && temp!.isNotEmpty) {
        print(temp);
        return challenge = temp![0];
      }
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
    return null;
  }
}
