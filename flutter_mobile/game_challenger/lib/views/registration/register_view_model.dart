import 'package:flutter/material.dart';
import 'package:game_challenger/app/app.router.dart';
import 'package:game_challenger/app/app_view_model.dart';

class RegisterViewModel extends AppViewModel {
  var formKey = GlobalKey<FormState>();
  var isLoading = false;

  void submit() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    // formKey.currentState!.save();
    // print("sucess");
    // await showDialog(
    //     context: Get.context!,
    //     barrierDismissible: false,
    //     builder: (context) => WillPopScope(
    //           onWillPop: () async {
    //             // Return false to prevent the dialog from being closed
    //             return Future.value(false);
    //           },
    //           child: AlertDialog(
    //             title:
    //                 const Text("Waiting for the game master to start the round",
    //                     style: TextStyle(
    //                       fontSize: 12,
    //                     )),
    //             content:
    //                 Lottie.asset('assets/lotties/bee-lounging.json', width: 24),
    //           ),
    //         )).then((value) => null);

    nav.pushReplacementNamed(Routes.challenge);
  }
}
