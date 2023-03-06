import 'dart:io';

import 'package:dio/dio.dart';
import 'package:game_challenger/app/app.locator.dart';
import 'package:game_challenger/core/models/challenge.dart';
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
    ])
  ..interceptors.add(RetryInterceptor(
    dio: Dio(options),
    maxRetries: 3,
    retryOnException: (e) => e is SocketException || e is HttpException || e is DioError && e.response?.statusCode == 429,
  ));



  @override
  Future<Player?> register(String name) async {
    final body = {'name': name};
    try {
      final response = await dio.post('/participant', data: body);
      if (response.statusCode == 200 && response.data != null) {
        var player = Player(id: response.data['id'].toString(), name: name);
        print(player);
        shared.setUser(player);
        return player;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  @override
  Future<int?> playerPoints(String id) async {
    try {
      final response = await dio.get('/participant/$id');
      if (response.statusCode == 200 && response.data != null) {
        return (response.data as Map<String, dynamic>)['score'];
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  @override
  Future<List<Question>?> getQuestion() async {
    try {
      final response = await dio.get('/question');
      if (response.statusCode == 200 &&
          response.data != null ) {
        // Challenge result;
        return (response.data as List<dynamic>).map((e) {
          return Question(
              id: e['id'],
              question: e['question'],
              status: e['status'],
              answer: e['answer'],
              choice: (e['choice'] as List<dynamic>)
                  .map((e) => Option(
                      id: e['id'],
                      questionId: e['question_id'],
                      choices: e['choices']))
                  .toList());
        }).toList();
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  @override
  Future<void> checkAnswer(String answer, String id) async {
    final body = {"answer": answer, "id": id};
    try {
      await dio.post('/check', data: body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> nextStream(String id) async {
    final body = {"id": id};
    try {
      final response = await dio.post('/next', data: body);
      if (response.statusCode == 200 && response.data != null) {
        return response.data.toString();
      }
    } catch (e) {
      rethrow;
    }
  }
}

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final bool Function(dynamic error) retryOnException;

  RetryInterceptor({required this.dio, this.maxRetries = 3, required this.retryOnException});

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (retryOnException(err)) {
      int retries = 0;
      while (retries < maxRetries) {
        try {
          // Calculate a delay using exponential backoff
          final delay = Duration(seconds: (1 ^ retries) * 1);

          // Wait before retrying the request
          await Future.delayed(delay);

          // Make the request again
          final options = err.requestOptions;
          final response = await dio.request(options.path);
          return response;
        } catch (e) {
          retries++;
          print('Retry failed ($retries): $e');
        }
      }
    }
    return super.onError(err, handler);
  }
}
