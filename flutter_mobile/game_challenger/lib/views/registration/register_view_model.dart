import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:game_challenger/app/app.locator.dart';
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

  final app = locator<AppViewModel>();
  int? playerPoints;

  int? status;

  TextEditingController name = TextEditingController();
  final _registrationController = StreamController<void>();

  Stream<void> get stream => _registrationController.stream;

  bool isStarted = false;

  bool hasStarted = false;

  late Timer _timer;

  void init() async {
    await getChallenge();

    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      getStartStatus();
      notifyListeners();
    });
    setBusy(true);
    app.currentPlayer = await app.shared.getUser();
    if (app.currentPlayer != null) {
      if (challenge != null) {
        if (status == 0) {
          _timer.cancel();
          nav.pushReplacementNamed(Routes.wait,
              arguments:
                  WaitngArguments(player: app.currentPlayer!, q: challenge!));
        } else {
          _timer.cancel();
          nav.pop();
          await app.nav.pushReplacementNamed(Routes.challenge,
              arguments: ChallengeArguments(
                  challenge: challenge!, player: app.currentPlayer!));
          notifyListeners();
        }
      } else {
        print("finished");
      }
    }
    setBusy(false);
  }

  getStartStatus() async {
    status = await api.start();
    notifyListeners();
    print("sat $status");
  }

  void addData() {
    _registrationController.sink.add(null);
  }

  Future<void> close() => _registrationController.close();

  Future<void> makeApiCall() async {}

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
      if(currentPlayer != null) {
        if (status == 0) {
          _timer.cancel();
          nav.pushReplacementNamed(Routes.wait,
              arguments:
              WaitngArguments(player: currentPlayer!, q: challenge!));
        } else {
          _timer.cancel();
          nav.pop();
          notifyListeners();
          await nav.pushReplacementNamed(Routes.challenge,
              arguments: ChallengeArguments(
                  challenge: challenge!, player: currentPlayer!));
        }
      }
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
    setBusy(false);
  }

  void wait() {
    if (status == 0) {
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context) => WillPopScope(
                onWillPop: () async {
                  // Return false to prevent the dialog from being closed
                  return Future.value(hasStarted);
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
              ));
    } else {
      hasStarted = true;
      app.nav.pop();
      notifyListeners();
    }
  }

  Future<Question?> getChallenge() async {
    try {
      temp = await api.getQuestion();
      if (temp != null && temp!.isNotEmpty) {
        print(temp);
        return challenge = temp![0];
      }
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
    return null;
  }
}
