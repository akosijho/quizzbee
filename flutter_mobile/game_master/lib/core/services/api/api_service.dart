import 'package:game_master/core/models/challenge.dart';
import 'package:game_master/core/models/player.dart';

abstract class ApiService{

  //register challenger
  Future<Player?> register(String name);

  //  get player points
  Future<int?> playerPoints(String id);

  //getquestion
  Future<List<Question>?> getQuestion();

  //next question
  Future<void> next(String id);

  //  answer checking
  Future<void> checkAnswer(String answer, String id);

//  start room
  Future<int?> start();

  //waiting_roomn
  Future<bool?> waiting();
}