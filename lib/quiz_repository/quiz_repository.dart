import 'package:quiz_app/ad/ad_helper.dart';
import 'package:quiz_app/quiz_api/quiz_api.dart';
import 'package:quiz_app/quiz_repository/models/question.dart';

class QuizFailure implements Exception {}

class ShuffledAnswersResult {
  final List<AnswerType> answers;
  final int correctAnswerPos;
  ShuffledAnswersResult(
      {required this.answers, required this.correctAnswerPos});
}

class QuizRepository {
  final QuizApiClient _quizApiClient;
  late List<Question> questions;

  QuizRepository({QuizApiClient? quizApiClient})
      : _quizApiClient = quizApiClient ?? QuizApiClient();

  Future<void> getQuestions(
      String category, String difficulty, int limit) async {
    final listOfQuestions =
        await _quizApiClient.getQuestions(category, difficulty, limit);

    questions = listOfQuestions.map((e) {
      ShuffledAnswersResult res =
          getAnswersShuffled(e.incorrectAnswers, e.correctAnswer);
      return Question(
          description: e.question,
          answers: res.answers,
          correctAnswer: res.correctAnswerPos);
    }).toList();

    int qtdAds = (questions.length / 3).floor();
    for (var element in AdHelper.bannerList) {
      element.dispose();
    }
    AdHelper.bannerList.clear();
    for (var i = 0; i <= qtdAds; i++) {
      var banner = BannerAdInfo();
      banner.load();
      AdHelper.bannerList.add(banner);
    }
  }

  ShuffledAnswersResult getAnswersShuffled(
    List<String> incorrectAnswers,
    String correctAnswers,
  ) {
    var l = incorrectAnswers.map((e) => AnswerType(description: e)).toList();
    l.add(AnswerType(description: correctAnswers, isTheCorrect: true));
    l.shuffle();
    var index = l.indexWhere((element) => element.isTheCorrect);
    return ShuffledAnswersResult(answers: l, correctAnswerPos: index);
  }
}
