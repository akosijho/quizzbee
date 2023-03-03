import 'package:flutter/material.dart';

class BuildBody extends StatelessWidget {
  const BuildBody({this.child, super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.blueAccent],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [0.4, 0.7],
          tileMode: TileMode.repeated,
        ),
      ),
      child: child,
    );
  }
}
