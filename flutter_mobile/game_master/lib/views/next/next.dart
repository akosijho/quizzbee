import 'package:flutter/material.dart';
import 'package:game_master/core/models/challenge.dart';
import 'package:game_master/views/next/components/choice_builder.dart';
import 'package:game_master/views/next/next_view_model.dart';
import 'package:game_master/widgets/build_body.dart';
import 'package:stacked/stacked.dart';

class Next extends StatelessWidget {
  const Next({required this.q, Key? key}) : super(key: key);

  final Question q;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NextViewModel>.reactive(
        viewModelBuilder: () => NextViewModel(currentChallenge: q),
        onViewModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return SafeArea(
              child: BuildBody(
                  child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  q.question!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(
                  height: 24,
                ),
                for (var i in q.choice!)
                  Column(
                    children: [
                      ChoiceBuilder(
                        choice: i,
                        answer: q.answer!,
                        q: q,
                      ),
                      const SizedBox(
                        height: 4,
                      )
                    ],
                  ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  width: 180,
                  height: 64,
                  decoration: BoxDecoration(
                      color: const Color(0xff31cb00).withOpacity(0.9),
                      border: Border.all(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextButton(
                    onPressed: () {
                      model.toNext(q.id.toString());
                    },
                    child: Text(
                      "next",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: Colors.white, fontSize: 24),
                    ),
                  ),
                )
              ],
            ),
          )));
        });
  }
}
