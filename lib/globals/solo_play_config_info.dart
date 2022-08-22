class Pair<T, U> {
  T name;
  U text;

  Pair(this.name, this.text);
}

final Map<String, String> difficultyMap = {
  'Easy': 'easy',
  'Medium': 'medium',
  'Hard': 'hard'
};

final Map<String, String> categoryMap = {
  'Arts & Literature': 'arts_and_literature',
  'Film & TV': 'film_and_tv',
  'Food & Drink': 'food_and_drink',
  'General Knowledge': 'general_knowledge',
  'Geography': 'geography',
  'History': 'history',
  'Music': 'music',
  'Science': 'science',
  'Society & Culture': 'society_and_culture',
  'Sport & Leisure': 'sport_and_leisure',
};

final List<int> numberOfQuestionsList = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50];
