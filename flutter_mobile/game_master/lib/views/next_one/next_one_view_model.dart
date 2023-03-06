 import 'package:dio/dio.dart';
import 'package:game_master/app/app.router.dart';
import 'package:game_master/app/app_view_model.dart';
import 'package:game_master/core/models/challenge.dart';
import 'package:game_master/widgets/conection_response.dart';

class NextOneViewModel extends AppViewModel{
  Question? challenge;

  void init() async {
    await getChallenge();
  }

  void toNext(String id) async {
    try {
      await api.next(id);
      await getChallenge();
      await nav.pushReplacementNamed(Routes.next,
          arguments: NextArguments(q: challenge!));
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
  }

  Future<Question?> getChallenge() async {
    try {
      var temp = await api.getQuestion();
      if (temp != null && temp!.isNotEmpty) {
        print(temp);
        return challenge = temp![0];
      }else{
        await nav.pushReplacementNamed(Routes.finish);
      }
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
    return null;
  }
}
