import 'package:game_challenger/core/models/challenge.dart';
import 'package:game_challenger/core/models/player.dart';

abstract class ApiService{

  //register challenger
  Future<Player?> register(String name);

  //  get player points
  Future<int?> playerPoints(String id);

  //getquestion
  Future<List<Question>?> getQuestion();

  //  answer checking
  Future<void> checkAnswer(String answer, String id);

//  start room
  Future<int?> start();

  Future<int?> finish();

  Future<List<Player>?> getTops();
}