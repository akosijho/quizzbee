import 'package:dio/dio.dart';
import 'package:game_challenger/app/app_view_model.dart';
import 'package:game_challenger/core/models/player.dart';
import 'package:game_challenger/views/widgets/conection_response.dart';

class FinishViewModel extends AppViewModel {
  List<Player> tops = [];
  final Player player;

  FinishViewModel({required this.player});

  int? playerPoints = 0;

  void init() async {
    getPoints(player.id!.toString());
    getTops();
  }

  void getTops() async {
    try {
      var list = await api.getTops();
      if (list != null && list.isNotEmpty) {
        tops.addAll(list!);
        notifyListeners();
      }
      notifyListeners();
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
  }

  void getPoints(String playerId) async {
    try {
      playerPoints = (await api.playerPoints(player.id!.toString())) ?? 0;
      notifyListeners();
    } on DioError catch (e) {
      connectionResponse(e);
      rethrow;
    }
  }
}
