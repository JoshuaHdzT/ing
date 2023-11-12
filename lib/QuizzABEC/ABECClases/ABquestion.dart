class ABCQuestion {
  late String preguntaabc;
  String abcquestion = "Pronunciación en ingles de la letra  ";
  late String answer;
  List<String> options = [];
  String selected = 'Skipped';
  bool correct = false;

  ABCQuestion.fromJson(Map<String, dynamic> json)
      : preguntaabc = json['preguntaabc'],
        answer = json['respu'];

  void addOptions(List<String> newOptions) {
    abcquestion += preguntaabc;
    options.add(answer);
    options.addAll(newOptions);
    options.shuffle();
  }
}