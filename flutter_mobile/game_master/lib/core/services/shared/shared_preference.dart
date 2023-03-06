import 'package:game_master/core/models/player.dart';

abstract class SharedPreference {
//register user to local cache
Future<void> setUser(Player player);
//get current user at app start
Future<Player?> getUser();
}