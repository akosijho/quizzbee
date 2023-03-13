 import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../app/app.router.dart';
import '../../app/app_view_model.dart';
import '../../core/models/challenge.dart';
import '../../widgets/conection_response.dart';

class NextOneViewModel extends AppViewModel{
  Question currentChallenge;
  Question? challenge;

  NextOneViewModel({required this.currentChallenge});

  void init() async {
    pusher.init(read);
  }

  Future<void> read(PusherEvent event) async {
    if(event.eventName == 'my-event'){
      print("event ${event.data}");
      if (event.data.toString() != "\"[]\"") {
        String s = event.data.toString();
        var n = s.substring(1, s.length - 1);
        var n1 = n.substring(1, n.length - 1);
        String unescapedString =
        n1.replaceAll('\\\"', '"').replaceAll('\\\\', '');
        var j = jsonDecode(unescapedString);
        challenge = Question(
            id: j['id'],
            question: j['question'],
            tag: j['tag'],
            status: j['status'],
            answer: j['answer'],
            choice: (j['choice'] as List<dynamic>)
                .map((e) => Option.fromJson(e as Map<String, dynamic>))
                .toList());
        print('j $challenge');
        if (challenge != currentChallenge) {
          // timer!.cancel();
          await nav.pushReplacementNamed(Routes.next,
              arguments: NextArguments(q: challenge!));
          notifyListeners();
        }
      }else{
        await nav.pushReplacementNamed(Routes.finish);
      }
    }
  }

  void toNext(String id) async {
    try {
      await api.next(id);
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
  }
}
