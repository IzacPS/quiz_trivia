import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/quiz_api/models/question.dart';

/// Exception thrown when getWeather fails.
class QuestionRequestFailure implements Exception {}

/// Exception thrown when weather for provided location is not found.
class QuestionNotFoundFailure implements Exception {}

class QuizApiClient {
  static const _baseUrl = 'the-trivia-api.com';
  final http.Client _httpClient;

  QuizApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<List<Question>> getQuestions(
      String categories, String difficulty, int limit) async {
    final questionsRequest = Uri.https(
      _baseUrl,
      '/api/questions',
      <String, String>{
        'categories': categories,
        'difficulty': difficulty,
        'limit': limit.toString()
      },
    );

    final questionsResponse = await _httpClient.get(questionsRequest);

    if (questionsResponse.statusCode != 200) {
      throw QuestionRequestFailure();
    }

    final questionsJson = jsonDecode(
      questionsResponse.body,
    ) as List;

    if (questionsJson.isEmpty) {
      throw QuestionNotFoundFailure();
    }

    return questionsJson
        .map((e) => Question.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
