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
  static BaseOptions options =
      BaseOptions(baseUrl: BASE_URL, persistentConnection: true);
  final shared = locator<SharedPreference>();

  Dio dio = Dio(options)
    ..options.headers.addEntries([
      const MapEntry('accept', 'application/json'),
    ])
    ..interceptors.add(RetryInterceptor(
      dio: Dio(options),
      maxRetries: 3,
      retryOnException: (e) =>
          e is SocketException ||
          e is HttpException ||
          e is DioError && e.response?.statusCode == 429,
    ));

  @override
  Future<Player?> register(String name) async {
    final body = {'name': name};
    try {
      final response = await dio.post('/participant', data: body);
      if (response.statusCode == 200 && response.data != null) {
        var player = Player(id: response.data['id'], name: name);
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
      final response = await retryOn429(() => dio.get('/participant/$id'));
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
      final response = await retryOn429(() => dio.get('/question'));
      if (response.statusCode == 200 && response.data != null) {
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
  Future<int?> start() async {
    try {
      final response = await retryOn429(() => dio.get(
            '/getresponse',
          ));
      if (response.statusCode == 200 && response.data != null) {
        return response.data;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  @override
  Future<int?> finish() async {
    try {
      final response = await retryOn429(() => dio.get(
            '/finish',
          ));
      if (response.statusCode == 200 && response.data != null) {
        return response.data;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  @override
  Future<List<Player>?> getTops() async {
    try {
      final response = await retryOn429(() => dio.get('/top'));
      if (response.statusCode == 200 && response.data != null) {
        return (response.data as List<dynamic>)
            .map((e) => Player.fromJson(e))
            .toList();
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<Response<T>> retryOn429<T>(
      Future<Response<T>> Function() request) async {
    Response<T>? response;
    for (var i = 0; i < 3; i++) {
      try {
        response = await request();
        if (response.statusCode != 429) {
          return response;
        }
        // Delay the next request by the time specified in the "Retry-After" header
        final retryAfter = response.headers.value('Retry-After');
        await Future.delayed(Duration(seconds: int.parse(retryAfter!)));
      } catch (e) {
        rethrow;
      }
    }
    throw DioError(
      requestOptions: response!.requestOptions,
      response: response,
      error: 'Too many retries',
    );
  }
}

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final bool Function(dynamic error) retryOnException;

  RetryInterceptor(
      {required this.dio, this.maxRetries = 3, required this.retryOnException});

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (retryOnException(err)) {
      int retries = 0;
      while (retries < maxRetries) {
        try {
          // Calculate a delay using exponential backoff
          final delay = Duration(milliseconds: (1 ^ retries) * 1);

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
