import 'package:dio/dio.dart';
import 'package:game_challenger/views/widgets/snackbar.dart';

void connectionResponse(DioError e) {
  if (e.type == DioErrorType.connectionTimeout) {
    mySnackbar(
        title: "Connection timed out", message: "It took longer than expected");
  }

  if (e.type == DioErrorType.connectionError) {
    mySnackbar(title: "No Internet", message: "Connection refused");
  }

  if (e.type == DioErrorType.badResponse) {
    mySnackbar(title: "Bad Response", message: "This is not what I asked");
  }
}
