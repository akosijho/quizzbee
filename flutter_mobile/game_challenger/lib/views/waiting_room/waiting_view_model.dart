import 'dart:async';

import 'package:game_challenger/app/app.router.dart';
import 'package:game_challenger/app/app_view_model.dart';
import 'package:game_challenger/core/models/challenge.dart';
import 'package:game_challenger/core/models/player.dart';

class WaitingViewModel extends AppViewModel{

  WaitingViewModel({required this.p, required this.q});

  final Player p;
  final Question q;

  Timer? _timer;

  int? status;

  void init()async{
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      getStartStatus();
      notifyListeners();
    });
  }

getStartStatus() async {
    status = await api.start();
    if(status == 1){
      _timer!.cancel();
      await nav.pushReplacementNamed(Routes.challenge,
          arguments: ChallengeArguments(
              challenge: q, player: p));
    }
    notifyListeners();
    print("sat $status");
  }
}