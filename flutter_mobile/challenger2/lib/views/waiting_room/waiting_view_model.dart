import 'dart:async';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../app/app.router.dart';
import '../../app/app_view_model.dart';
import '../../core/models/challenge.dart';
import '../../core/models/player.dart';

class WaitingViewModel extends AppViewModel{

  WaitingViewModel({required this.p, required this.q});

  final Player p;
  final Question q;

  Timer? _timer;

  int status = 0;

  void init(){
    // pusher.init(read);
  }

  void read(PusherEvent event){
    if(event.eventName == 'waiting-event'){
      print("event ${event.data}");
      status = event.data == "{\"waiting_room\":0}" ? 1 : 0;
      getStartStatus();
    }
  }

getStartStatus() async {
    // status = await api.start();
    if(status == 1){
      // // _timer!.cancel();
      await nav.pushReplacementNamed(Routes.challenge,
          arguments: ChallengeArguments(
              challenge: q, player: p));
    }
    notifyListeners();
    print("sat $status");
  }
}