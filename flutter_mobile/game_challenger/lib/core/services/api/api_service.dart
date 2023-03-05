import 'package:game_challenger/core/models/player.dart';

abstract class ApiService{

  //register challenger
  Future<Player?> register(String name);
}