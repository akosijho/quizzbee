import 'package:flutter/material.dart';
import 'package:game_master/views/start/start_view_model.dart';
import 'package:game_master/widgets/build_body.dart';
import 'package:game_master/widgets/height_gap.dart';
import 'package:stacked/stacked.dart';

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartViewModel>.reactive(
        viewModelBuilder: () => StartViewModel(),
        onViewModelReady: (model) => model.init(),
        builder: (context, model, chil) {
          return SafeArea(
              child: Scaffold(
            body: BuildBody(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "game master console",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 32, color: Colors.white),
                    ),
                    const HGap16(),
                    Container(
                      width: 180,
                      height: 64,
                      decoration: BoxDecoration(
                          color: const Color(0xff31cb00).withOpacity(0.9),
                          border: Border.all(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                        onPressed: () {
                          model.toNext();
                        },
                        child: Text(
                          "open",
                          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 24
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
        });
  }
}
