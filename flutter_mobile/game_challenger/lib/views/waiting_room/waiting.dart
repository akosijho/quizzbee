import 'package:flutter/material.dart';
import 'package:game_challenger/core/models/challenge.dart';
import 'package:game_challenger/core/models/player.dart';
import 'package:game_challenger/views/waiting_room/waiting_view_model.dart';
import 'package:game_challenger/views/widgets/build_body.dart';
import 'package:game_challenger/views/widgets/height_gap.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

class Waitng extends StatelessWidget {
  const Waitng({
    required this.player,
    required this.q,
    Key? key}) : super(key: key);

  final Player player;
  final Question q;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WaitingViewModel>.reactive(
        viewModelBuilder: () => WaitingViewModel(q: q, p: player),
        onViewModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return SafeArea(
              child: Scaffold(
            body: BuildBody(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Waiting for the game master to start the round",
                      style: TextStyle(
                        fontSize: 12,
                      )),
                  const HGap08(),
                  Lottie.asset('assets/lotties/bee-lounging.json',)
                ],
              )),
            ),
          ));
        });
  }
}
