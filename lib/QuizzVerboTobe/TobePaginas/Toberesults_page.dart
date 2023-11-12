import 'package:flutter/material.dart';

import '../TobeClases/Tobequiz.dart';
import 'Tobehome_page.dart';



class TobeResultsPage extends StatelessWidget {
  const TobeResultsPage({Key? key, required this.quiz, required this.idTem, required this.Tem}) : super(key: key);
  final TobeQuiz quiz;
  final String idTem;
  final String Tem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        title: Text(quiz.name),
        backgroundColor: Theme.of(context).primaryColorDark,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin:
              const EdgeInsets.only(left: 3, right: 3, top: 2, bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.indigo.shade50,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Preguntas: ${quiz.questions.length}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    'Correctas: ${quiz.percent}%',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: quiz.questions.length,
                  itemBuilder: (_, index) {
                    return Card(
                      color: quiz.questions[index].correct
                          ? Colors.green.shade200
                          : Colors.red.shade200,
                      child: ListTile(
                        leading: quiz.questions[index].correct
                            ? Icon(Icons.check, color: Colors.green.shade900)
                            : Icon(Icons.close, color: Colors.red.shade900),
                        title: Text(quiz.questions[index].tobequestion),
                        subtitle: Text(quiz.questions[index].selected),
                        trailing: Text(quiz.questions[index].answer),
                      ),

                    );

                  }),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> TobeHomePage(idTem: idTem, Tem: Tem)));
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
      ),
    );
  }
}