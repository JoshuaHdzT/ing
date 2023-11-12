import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ABECClases/ABquestion.dart';
import '../ABECClases/ABquiz.dart';
import 'ABhome_page.dart';



class AbecedarioReviewQuizPage extends StatefulWidget {
  final String idTem;
  final String Tem;
  const AbecedarioReviewQuizPage({super.key, required this.idTem, required this.Tem,});

  @override
  State<AbecedarioReviewQuizPage> createState() => _ReviewQuizPageState(this.idTem, this.Tem);
}

class _ReviewQuizPageState extends State<AbecedarioReviewQuizPage> {
  AbcQuiz quiz = AbcQuiz(name: 'Quiz de Abecedario', questions: []);
String idTem;
String Tem;
  _ReviewQuizPageState(this.idTem, this.Tem);

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/abdc.json');
    final List<dynamic> data = await json.decode(response);
    for (var item in data) {
      ABCQuestion question = ABCQuestion.fromJson(item);
      question.abcquestion += question.preguntaabc;
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
                        title: Text(quiz.questions[index].abcquestion),
                        trailing: Text(quiz.questions[index].answer),
                      ),
                    );
                  }),
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
        )
            : const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ));
  }
}