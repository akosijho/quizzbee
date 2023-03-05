import 'package:dio/dio.dart';
import 'package:game_challenger/core/models/player.dart';
import 'package:game_challenger/core/services/api/api_service.dart';
import 'package:game_challenger/utils/constants.dart';
import 'package:game_challenger/views/widgets/snackbar.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ApiService)
class ApiServiceImpl implements ApiService {
  static BaseOptions options = BaseOptions(baseUrl: BASE_URL);

  Dio dio = Dio(options)
    ..options.headers.addEntries([
      const MapEntry('accept', 'application/json'),
    ]);

  @override
  Future<Player?> register(String name) async {
    final body = {'name': name};
    try {
      final response = await dio.post('participant', data: body);
      if (response.statusCode == 200 && response.data != null) {
        return Player.fromJson(response.data);
      }
    } catch (e) {
      mySnackbar(title: "Errpr", message: "Connection refused");
    }
    return null;
  }
}
