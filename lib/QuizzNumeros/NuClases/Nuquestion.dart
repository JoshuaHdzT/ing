class NuQuestion {
  late String pregunta;
  String nuquestion = "Traducción en ingles del numero  ";
  late String answer;
  List<String> options = [];
  String selected = 'Skipped';
  bool correct = false;

  NuQuestion.fromJson(Map<String, dynamic> json)
      : pregunta = json['pregunta'],
        answer = json['resp'];

  void addOptions(List<String> newOptions) {
    nuquestion += pregunta;
    options.add(answer);
    options.addAll(newOptions);
    options.shuffle();
  }
}