import 'package:flutter/material.dart';
import 'package:game_challenger/views/widgets/build_body.dart';

class Challenge extends StatelessWidget {
  const Challenge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Challenger Id"),
            Text("Points")
          ],
        ),
      ),
      body: BuildBody(),
    );
  }
}
