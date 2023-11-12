

import 'ABquestion.dart';

class AbcQuiz {
  String name;
  List<ABCQuestion> questions;
  int right = 0;

  AbcQuiz({required this.name, required this.questions});

  double get percent => (right / questions.length) * 100;
}