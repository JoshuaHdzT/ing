import 'package:flutter/material.dart';
import 'package:ing/Pages/Menu_Tema.dart';

import '../../utils/color_utils.dart';
import 'ABquiz_page.dart';
import 'ABreview_quiz_page.dart';


class AbecedarioHomePage extends StatelessWidget {
  final String idTem;
  final String Tem;
  const AbecedarioHomePage({super.key, required this.idTem, required this.Tem,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 50),
                child: Icon(
                  Icons.access_time_filled,
                  size: 100,
                  color: Colors.purple.shade100,
                ),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Colors.blueAccent,
                //color: Theme.of(context).primaryColorLight,
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  children: [
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(top: 10, bottom: 25),
                      child: const Center(
                        child: Text(
                          'QUIZZ DE PRUEBA ABECEDARIO',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.indigo.shade200,
                                Colors.purple.shade300
                              ]),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> AbecedarioQuizPage(idTem: idTem, Tem: Tem)));
                      },
                      child: const Text('Start Quiz'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Theme.of(context).primaryColorLight,
                        elevation: 4,
                        side: const BorderSide(width: 1),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> AbecedarioReviewQuizPage(idTem: idTem, Tem: Tem)));
                      },
                      child: const Text('Review Quizz'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Theme.of(context).primaryColorLight,
                        elevation: 4,
                        side: const BorderSide(width: 1),
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>
                      MenuTema(idTem: idTem, Tem: Tem)));
                },
                child: const Text('Exit'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Theme.of(context).primaryColorLight,
                  elevation: 4,
                  side: const BorderSide(width: 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}