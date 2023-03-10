import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:game_challenger/app/app.locator.dart';
import 'package:game_challenger/app/app.router.dart';
import 'package:game_challenger/app/app_view_model.dart';
import 'package:game_challenger/core/models/challenge.dart';
import 'package:game_challenger/views/widgets/conection_response.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

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

  PusherEvent event =
      PusherEvent(channelName: 'my-channel', eventName: 'my-event');

  Future<void> read(PusherEvent event) async {
    print("event ${event.data}");
    String s = event.data.toString();
    if (s != "{}") {
      var n = s.substring(1, s.length - 1);
      var n1 = n.substring(1, n.length - 1);
      String unescapedString =
          n1.replaceAll('\\\"', '"').replaceAll('\\\\', '');
      var j = jsonDecode(unescapedString);
      challenge = Question(
          id: j['id'],
          question: j['question'],
          status: j['status'],
          answer: j['answer'],
          choice: (j['choice'] as List<dynamic>)
              .map((e) => Option.fromJson(e as Map<String, dynamic>))
              .toList());
      print('j $challenge');
      if (app.currentPlayer != null) {
        if (challenge != null) {
          if (status == 0 && status != null) {
            // _timer.cancel();
            nav.pushReplacementNamed(Routes.wait,
                arguments:
                    WaitngArguments(player: app.currentPlayer!, q: challenge!));
          } else {
            // _timer.cancel();
            nav.pop();
            await app.nav.pushReplacementNamed(Routes.challenge,
                arguments: ChallengeArguments(
                    challenge: challenge!, player: app.currentPlayer!));
            notifyListeners();
          }
        } else {
          print("finished");
          _timer.cancel();
          showDialog(
              context: Get.context!,
              barrierDismissible: false,
              builder: (context) => WillPopScope(
                    onWillPop: () async {
                      // Return false to prevent the dialog from being closed
                      return Future.value(hasStarted);
                    },
                    child: AlertDialog(
                      title: const Text("Contest has conducted",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                          )),
                      content: Lottie.asset('assets/lotties/bee-lounging.json',
                          width: 24),
                    ),
                  ));
        }
      }
    }
  }

  void init() async {
    setBusy(true);
    app.currentPlayer = await app.shared.getUser();
    setBusy(false);
    getStartStatus();
    pusher.init(read);
    await getChallenge();

    // _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
    //   getStartStatus();
    //   notifyListeners();
    // });
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
      if (currentPlayer != null) {
        if (status == 0 && status != null) {
          // _timer.cancel();
          nav.pushReplacementNamed(Routes.wait,
              arguments:
                  WaitngArguments(player: currentPlayer!, q: challenge!));
        } else {
          // _timer.cancel();
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
