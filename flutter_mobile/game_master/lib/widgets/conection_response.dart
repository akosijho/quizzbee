import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:game_master/widgets/snackbar.dart';

void connectionResponse(DioError e) {
  if (e.type == DioErrorType.connectionTimeout) {
    mySnackbar(
        title: "Connection timed out", message: "It took longer than expected");
  }

  if (e.type == DioErrorType.connectionError) {
    mySnackbar(title: "No Internet", message: "Connection refused");
  }

  if (e.type == DioErrorType.badResponse) {
     Container();
  }
}
