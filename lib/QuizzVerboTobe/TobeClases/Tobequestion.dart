class TobeQuestion {
  late String tobepregunta;
  String tobequestion = "";
  late String answer;
  List<String> options = [];
  String selected = 'Skipped';
  bool correct = false;

  TobeQuestion.fromJson(Map<String, dynamic> json)
      : tobepregunta = json['tobepregunta'],
        answer = json['respues'];

  void addOptions(List<String> newOptions) {
    tobequestion += tobepregunta;
    options.add(answer);
    options.addAll(newOptions);
    options.shuffle();
  }
}