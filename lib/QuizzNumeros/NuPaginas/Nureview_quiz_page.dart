import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../NuClases/Nuquestion.dart';
import '../NuClases/Nuquiz.dart';
import 'Nuhome_page.dart';


class NumerosReviewQuizPage extends StatefulWidget {
  final String idTem;
  final String Tem;
  const NumerosReviewQuizPage({super.key, required this.idTem, required this.Tem, });

  @override
  State<NumerosReviewQuizPage> createState() => _ReviewQuizPageState(this.idTem, this.Tem);
}

class _ReviewQuizPageState extends State<NumerosReviewQuizPage> {
  NuQuiz quiz = NuQuiz(name: 'Quiz de Numbers', questions: []);

  String  idTem;
  String Tem;

  _ReviewQuizPageState( this.idTem, this.Tem);

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/numeros.json');
    final List<dynamic> data = await json.decode(response);
    for (var item in data) {
      NuQuestion question = NuQuestion.fromJson(item);
      question.nuquestion += question.pregunta;
      quiz.questions.add(question);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          elevation: 0,
        ),
        body: quiz.questions.isNotEmpty
            ? Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(
                  left: 8, right: 8, top: 2, bottom: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                border:
                Border.all(color: Colors.indigo.shade50, width: 1),
              ),
              child: Center(
                child: Text(
                  "Preguntas: ${quiz.questions.length}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: quiz.questions.length,
                  itemBuilder: (_, index) {
                    return Card(
                      color: Theme.of(context).primaryColorLight,
                      child: ListTile(
                        leading: Text("${index + 1}"),
                        title: Text(quiz.questions[index].nuquestion),
                        trailing: Text(quiz.questions[index].answer),
                      ),
                    );
                  }),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> NumerosHomePage(idTem: idTem, Tem: Tem)));
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
        )
            : const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ));
  }
}