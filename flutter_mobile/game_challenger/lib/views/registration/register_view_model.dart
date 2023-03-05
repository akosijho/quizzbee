import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:game_challenger/app/app.router.dart';
import 'package:game_challenger/app/app_view_model.dart';
import 'package:game_challenger/core/models/challenge.dart';
import 'package:game_challenger/views/widgets/conection_response.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RegisterViewModel extends AppViewModel {
  var formKey = GlobalKey<FormState>();
  var isLoading = false;
  List<Question>? temp;
  Question? challenge;

  int? playerPoints;

  TextEditingController name = TextEditingController();

  void init() async {
    getChallenge();
  }

  bool isStarted = false;

  void submit() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    // formKey.currentState!.save();
    // print("success");
  }

  void register(String name) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    setBusy(true);
    try {
      currentPlayer = await api.register(name);
      // wait();
      await nav.pushReplacementNamed(Routes.challenge,
          arguments: ChallengeArguments(
              challenge: challenge!, player: currentPlayer!));
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
    setBusy(false);
  }

  void wait() async {
    if (isStarted == false) {
      await showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context) => WillPopScope(
                onWillPop: () async {
                  // Return false to prevent the dialog from being closed
                  return Future.value(false);
                },
                child: AlertDialog(
                  title: const Text(
                      "Waiting for the game master to start the round",
                      style: TextStyle(
                        fontSize: 12,
                      )),
                  content: Lottie.asset('assets/lotties/bee-lounging.json',
                      width: 24),
                ),
              )).then((value) => null);
    } else {
      await nav.pushReplacementNamed(Routes.challenge);
    }
  }

  void getChallenge() async {
    setBusy(true);
    try {
      temp = await api.getQuestion();
      if (temp != null) {
        challenge = temp![0];
      }
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
    setBusy(false);
  }
}
