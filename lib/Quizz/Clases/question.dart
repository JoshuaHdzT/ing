class Question {
  late String country;
  String question = "¿Cuál es la traducción en inglés del color ";
  late String answer;
  List<String> options = [];
  String selected = 'Skipped';
  bool correct = false;

  Question.fromJson(Map<String, dynamic> json)
      : country = json['country'],
        answer = json['capital'];

  void addOptions(List<String> newOptions) {
    question += country;
    options.add(answer);
    options.addAll(newOptions);
    options.shuffle();
  }
}