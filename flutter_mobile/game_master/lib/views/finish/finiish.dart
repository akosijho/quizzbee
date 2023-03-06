import 'package:flutter/material.dart';
import 'package:game_master/widgets/build_body.dart';
import 'package:game_master/widgets/height_gap.dart';

class Finish extends StatelessWidget {
  const Finish({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return Future.value(false);
      },
      child: SafeArea(
          child: Scaffold(
            body: BuildBody(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "game master console",
                      textAlign: TextAlign.center,
                      style: Theme
                          .of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 32, color: Colors.white),
                    ),
                    const HGap16(),
                    Container(
                      width: double.infinity,
                      height: 64,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color(0xff31cb00).withOpacity(0.9),
                          border: Border.all(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        "Contest has been conducted",
                        style: Theme
                            .of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                            color: Colors.white,
                            fontSize: 24
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          )),
    );
  }
}