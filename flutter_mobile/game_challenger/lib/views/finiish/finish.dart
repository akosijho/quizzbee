import 'package:flutter/material.dart';
import 'package:game_challenger/core/models/player.dart';
import 'package:game_challenger/views/finiish/finish_view_model.dart';
import 'package:game_challenger/views/widgets/build_body.dart';
import 'package:game_challenger/views/widgets/height_gap.dart';
import 'package:stacked/stacked.dart';

class Finish extends StatelessWidget {
  const Finish({required this.player, Key? key}) : super(key: key);

  final Player player;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FinishViewModel>.reactive(
        viewModelBuilder: () => FinishViewModel(player: player),
        onViewModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return WillPopScope(
            onWillPop: () async {
              return Future.value(false);
            },
            child: SafeArea(
                child: Scaffold(
                    appBar: AppBar(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Id: ${player.id}"),
                          Text(model.playerPoints.toString())
                        ],
                      ),
                    ),
                    body: BuildBody(
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Top placers'),
                              const HGap16(),
                              Column(
                                children: [
                                  for (var i in model.tops)
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          width: 320,
                                          child: ListTile(
                                            title: Padding(
                                              padding: const EdgeInsets.only(left:32.0),
                                              child: Text(
                                                i.name ?? '',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            trailing: Text(
                                              i.score!.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        const HGap04(),
                                      ],
                                    )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ))),
          );
        });
  }
}
