import 'package:dio/dio.dart';
import 'package:game_challenger/app/app.locator.dart';
import 'package:game_challenger/core/models/player.dart';
import 'package:game_challenger/core/services/api/api_service.dart';
import 'package:game_challenger/core/services/shared/shared_preference.dart';
import 'package:game_challenger/utils/constants.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ApiService)
class ApiServiceImpl implements ApiService {
  static BaseOptions options = BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: const Duration(seconds: 30),
      persistentConnection: true);
  final shared = locator<SharedPreference>();

  Dio dio = Dio(options)
    ..options.headers.addEntries([
      const MapEntry('accept', 'application/json'),
    ]);

  @override
  Future<Player?> register(String name) async {
    final body = {'name': name};
    try {
      final response = await dio.post('/participant', data: body);
      if (response.statusCode == 200 && response.data != null) {
        var player = Player(id: response.data.toString(), name: name);
        shared.setUser(player);
        return player;
      }
    }catch (e) {
      rethrow;
    }
    return null;
  }
}
