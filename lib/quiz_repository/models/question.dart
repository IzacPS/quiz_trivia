class AnswerType {
  String description;
  bool isTheCorrect;

  AnswerType({required this.description, this.isTheCorrect = false});
  @override
  String toString() {
    return description;
  }
}

class Question {
  String description;
  List<AnswerType> answers;
  late int correctAnswer;

  Question(
      {required this.description,
      required this.answers,
      this.correctAnswer = -1});

  @override
  String toString() {
    return 'question $description\n$answers';
  }
}
