import 'package:flutter/material.dart';
import 'package:game_challenger/core/models/player.dart';
import 'package:game_challenger/views/challenge/challenge_view_model.dart';
import 'package:game_challenger/views/challenge/components/option_builder.dart';
import 'package:game_challenger/views/widgets/build_body.dart';
import 'package:game_challenger/views/widgets/height_gap.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'package:game_challenger/core/models/challenge.dart';

class Challenge extends StatelessWidget {
  const Challenge({required this.challenge, required this.player, super.key});

  final Question challenge;

  final Player player;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChallengeViewModel>.reactive(
        viewModelBuilder: () =>
            ChallengeViewModel(challenge: challenge, player: player),
        onViewModelReady: (model) => model.init(),
        onDispose: (model) => model.timer!.cancel(),
        builder: (context, model, child) {
          return SafeArea(
            bottom: true,
            child: WillPopScope(
              onWillPop: () async {
                // Return false to prevent the dialog from being closed
                return Future.value(false);
              },
              child: Scaffold(
                appBar: AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Id: ${model.player.id}"),
                      Text(model.playerPoints.toString())
                    ],
                  ),
                ),
                body: BuildBody(
                  child: Column(
                    children: [
                      // const Align(
                      //   alignment: Alignment.topLeft,
                      //   child: Text("Place: 1"),
                      // ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                model.challenge.question!,
                                overflow: TextOverflow.clip,
                              ),
                              const SizedBox(
                                height: 38,
                              ),
                              for (var i in model.challenge.choice!)
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    OptionBuilder(
                                      choice: i,
                                    ),
                                    const HGap08(),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                      model.isLocked
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: 42,
                                height: 42,
                                child: Lottie.asset(
                                    'assets/lotties/bee-lounging.json'),
                              ))
                          : const SizedBox.shrink(),
                      model.isLocked
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "*Waiting for the game master to start the next round*",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
