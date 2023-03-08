import 'package:dio/dio.dart';
import 'package:game_master/app/app.router.dart';
import 'package:game_master/app/app_view_model.dart';
import 'package:game_master/core/models/challenge.dart';
import 'package:game_master/widgets/conection_response.dart';

class StartViewModel extends AppViewModel {
  Question? challenge;
  bool? proceed;

  void init() async {
    await getChallenge();
  }

  void toNext() async {
    await getChallenge();
    proceed = await api.waiting();
    print("to: $proceed");
    if (proceed != null && proceed == true) {
      if (challenge != null) {
        nav.pushReplacementNamed(Routes.next,
            arguments: NextArguments(q: challenge!));
        notifyListeners();
      } else {
        print("finished");
      }
    }else{
    }
  }

  Future<Question?> getChallenge() async {
    try {
      var temp = await api.getQuestion();
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
