
import 'Nuquestion.dart';

class NuQuiz {
  String name;
  List<NuQuestion> questions;
  int right = 0;

  NuQuiz({required this.name, required this.questions});

  double get percent => (right / questions.length) * 100;
}