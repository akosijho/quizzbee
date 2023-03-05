import 'package:flutter/material.dart';
import 'package:game_challenger/views/challenge/challenge_view_model.dart';
import 'package:game_challenger/views/challenge/components/option_builder.dart';
import 'package:game_challenger/views/widgets/build_body.dart';
import 'package:game_challenger/views/widgets/height_gap.dart';
import 'package:stacked/stacked.dart';

class Challenge extends StatelessWidget {
  const Challenge({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChallengeViewModel>.reactive(
        viewModelBuilder: () => ChallengeViewModel(),
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              extendBody: true,
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [Text("Challenger Id"), Text("Points")],
                ),
              ),
              body: BuildBody(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text("Place: 1"),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "This is a question",
                              overflow: TextOverflow.clip,
                            ),
                            const SizedBox(
                              height: 38,
                            ),
                            for (int i = 1; i < 5; i++)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.max,
                                children: const [
                                  OptionBuilder(),
                                  HGap08(),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
