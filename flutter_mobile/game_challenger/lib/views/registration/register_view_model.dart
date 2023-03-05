import 'package:flutter/material.dart';
import 'package:game_challenger/app/app.router.dart';
import 'package:game_challenger/app/app_view_model.dart';

class RegisterViewModel extends AppViewModel{
  var formKey = GlobalKey<FormState>();
  var isLoading = false;

  void submit() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    // formKey.currentState!.save();
    // print("sucess");
    nav.pushReplacementNamed(Routes.challenge);
  }
}