import 'package:flutter/material.dart';
import 'package:game_challenger2/utils/remove_double_space.dart';
import 'package:game_challenger2/views/challenge/components/option_builder.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/challenge.dart';
import '../../core/models/player.dart';
import '../widgets/build_body.dart';
import '../widgets/height_gap.dart';
import 'challenge_view_model.dart';

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
        // onDispose: (model) => model.timer!.cancel(),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                                if (challenge.tag == 'abcd')
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
                                if (challenge.tag == 'identification')
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      SizedBox(
                                        height: 56,
                                        child: TextFormField(
                                          inputFormatters: [
                                            RemoveDoubleSpaceFormatter()
                                          ],
                                          enabled: model.isLocked == false
                                              ? true
                                              : false,
                                          controller: model.answer,
                                          decoration: InputDecoration(
                                              hintText: "Enter your answer",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8))),
                                        ),
                                      ),
                                      const HGap08(),
                                      Container(
                                        width: 120,
                                        decoration: BoxDecoration(
                                            color: model.isLocked == false
                                                ? const Color(0xff31cb00)
                                                : Colors.white30,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: TextButton(
                                            onPressed: model.isLocked
                                                ? null
                                                : () {
                                                    print(
                                                        model.answer.value.text);
                                                    model.checkIdentification();
                                                  },
                                            child: Center(
                                              child: Text(
                                                "Submit",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayLarge!
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      if (model.isLocked == true)
                                        model.correct
                                            ? const Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Icon(
                                                  Icons.check_circle,
                                                  size: 24,
                                                  color: Colors.white,
                                                ))
                                            : Column(
                                                children: [
                                                  const Align(
                                                      alignment:
                                                          Alignment.bottomCenter,
                                                      child: Icon(
                                                        Icons.close_rounded,
                                                        size: 24,
                                                        color: Colors.red,
                                                      )),
                                                  const HGap08(),
                                                  Text(
                                                    "The answer is \"${challenge.answer}\"",
                                                    textAlign: TextAlign.center,
                                                    overflow: TextOverflow.clip,
                                                    style: const TextStyle(
                                                        fontSize: 10),
                                                  )
                                                ],
                                              )
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
            ),
          );
        });
  }
}
