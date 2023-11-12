

import 'Tobequestion.dart';

class TobeQuiz {
  String name;
  List<TobeQuestion> questions;
  int right = 0;

  TobeQuiz({required this.name, required this.questions});

  double get percent => (right / questions.length) * 100;
}