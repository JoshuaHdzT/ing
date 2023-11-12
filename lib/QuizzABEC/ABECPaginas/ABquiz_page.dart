import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import '../ABECClases/ABquestion.dart';
import '../ABECClases/ABquiz.dart';
import 'ABhome_page.dart';
import 'ABresults_page.dart';



class AbecedarioQuizPage extends StatefulWidget {
  final String idTem;
  final String Tem;
  const AbecedarioQuizPage({super.key, required this.idTem, required this.Tem,});

  @override
  State<AbecedarioQuizPage> createState() => _QuizPageState(this.idTem, this.Tem);
}

class _QuizPageState extends State<AbecedarioQuizPage> {
  int totalQuestions = 5;
  int totalOptions = 4;
  int questionIndex = 0;
  int progressIndex = 0;
  AbcQuiz quiz = AbcQuiz(name: 'Quiz of Abecedario', questions: []);
String idTem;
String Tem;
  _QuizPageState(this.idTem, this.Tem);

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/abdc.json');
    final List<dynamic> data = await json.decode(response);
    List<int> optionList = List<int>.generate(data.length, (i) => i);
    List<int> questionsAdded = [];

    while (true) {
      optionList.shuffle();
      int answer = optionList[0];
      if (questionsAdded.contains(answer)) continue;
      questionsAdded.add(answer);

      List<String> otherOptions = [];
      for (var option in optionList.sublist(1, totalOptions)) {
        otherOptions.add(data[option]['respu']);
      }

      ABCQuestion question = ABCQuestion.fromJson(data[answer]);
      question.addOptions(otherOptions);
      quiz.questions.add(question);

      if (quiz.questions.length >= totalQuestions) break;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  void _optionSelected(String selected) {
    quiz.questions[questionIndex].selected = selected;
    if (selected == quiz.questions[questionIndex].answer) {
      quiz.questions[questionIndex].correct = true;
      quiz.right += 1;
    }

    progressIndex += 1;
    if (questionIndex < totalQuestions - 1) {
      questionIndex += 1;
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => _buildResultDialog(context));
    }

    setState(() {});
  }

  Widget _buildResultDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Resultados', style: Theme.of(context).textTheme.displaySmall),
      backgroundColor: Theme.of(context).primaryColorDark,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preguntas totales: $totalQuestions',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'Correctas: ${quiz.right}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'Incorrectas: ${(totalQuestions - quiz.right)}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'Porcentaje: ${quiz.percent}%',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: ((context) => AbecedarioResultsPage(
                    quiz: quiz,
                    idTem: idTem,
                    Tem: Tem,
                  ))),
            );
          },
          child: Text(
            'Ver Respuestas',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text(quiz.name),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: LinearProgressIndicator(
                color: Colors.amber.shade900,
                value: progressIndex / totalQuestions,
                minHeight: 20,
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 750),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: quiz.questions.isNotEmpty
                  ? Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: Text(
                        quiz.questions[questionIndex].abcquestion,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: totalOptions,
                        itemBuilder: (_, index) {
                          return Container(
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.indigo.shade100,
                                  width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              leading: Text('${index + 1}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge),
                              title: Text(
                                  quiz.questions[questionIndex]
                                      .options[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge),
                              onTap: () {
                                _optionSelected(quiz
                                    .questions[questionIndex]
                                    .options[index]);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
                  : const CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _optionSelected('Skipped');
            },
            child: Text('Skip', style: Theme.of(context).textTheme.bodyLarge),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> AbecedarioHomePage(idTem: idTem, Tem: Tem)));
            },
            child: const Text('Exit'),
            style: OutlinedButton.styleFrom(
              primary: Colors.black,
              backgroundColor: Theme.of(context).primaryColorLight,
              elevation: 4,
              side: const BorderSide(width: 1),
            ),
          ),
        ],
      ),
    );
  }
}