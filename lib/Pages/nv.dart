import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ing/Pages/ui/colors.dart';
import 'package:ing/Pages/ui/widget/figure_image.dart';
import 'package:ing/Pages/ui/widget/letter.dart';
import 'package:ing/Pages/utils/game.dart';

import '../utils/color_utils.dart';
import 'Menu_Tema.dart';



class nv extends StatefulWidget {
  final String Tem;
  final String nTem;
  const nv({super.key, required this.Tem, required this.nTem});

  @override
  State<nv> createState() => _nvState(this.Tem, this.nTem);
}

class _nvState extends State<nv> {
  String nTem;
  String Tem;
  String word = 'uno'.toUpperCase();
  late List<String> card_list = [];
  late List<String> descrip = [];


  int p=2;
  _nvState(this.Tem, this.nTem){
    if(Game.selectedChar==null){
    }else{
      Game.selectedChar.clear();
      Game.a=0;
      Game.tries=0;
    }
    if (nTem == 'Colores') {
      card_list = ['red',
        'blue', 'white',
        'black', 'grey',
        'pink'];
      descrip = ['Es el color Rojo',
        'Es el color Azul', 'Es el color Blanco',
        'Es el color Negro', 'Es el color Gris',
        'Es el color Rosa'];
    }else  if (nTem == 'Números') {
      card_list = ['one',
        'two',
        'four',
        'five',
        'six',
        'eight',];
      descrip = ['Es el numero 1',
      'Es el numero 2',
      'Es el numero 4',
      'Es el numero 5',
      'Es el numero 6',
      'Es el numero 8'];
    }else{
      card_list =['Ok'];
      descrip =['Próximamente'];
      //_showDialog(context, 'Aviso','proximamente');
      Game.tries=7;

    }
    p=Random().nextInt(card_list.length);

    word = card_list[p].toString().toUpperCase();
    if (Tem=='colores'){

    }
    print(word);
  }

  //Create a list that contains the Alphabet, or you can just copy and paste it
  List<String> alphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hangman"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.blue,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                children: [
                  //let's make the figure widget
                  //let's add the images to the asset folder
                  //Okey now we will create a Game class
                  //Now the figure will be built according to the number of tries
                  figureImage(Game.tries >= 0, "assets/images/hang.png"),
                  figureImage(Game.tries >= 1, "assets/images/head.png"),
                  figureImage(Game.tries >= 2, "assets/images/body.png"),
                  figureImage(Game.tries >= 3, "assets/images/ra.png"),
                  figureImage(Game.tries >= 4, "assets/images/la.png"),
                  figureImage(Game.tries >= 5, "assets/images/rl.png"),
                  figureImage(Game.tries >= 6, "assets/images/ll.png"),
                  //poner que al >=7 perdiste alerta
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: 15),
              child: Text(
                descrip[p],
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            //Now we will build the Hidden word widget
            //now let's go back to the Game class and add
            // a new variable to store the selected character
            /* and check if it's on the word */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: word
                  .split('')
                  .map((e) => letter(e.toUpperCase(),
                  !Game.selectedChar.contains(e.toUpperCase())))
                  .toList(),


            ),

            //Now let's build the Game keyboard
            SizedBox(
              width: double.infinity,
              height: 250.0,
              child: GridView.count(
                crossAxisCount: 7,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                padding: EdgeInsets.all(8.0),
                children: alphabets.map((e) {
                  return RawMaterialButton(
                    onPressed: Game.selectedChar.contains(e)
                        ? null // we first check that we didn't selected the button before
                        : () {
                      setState(() {
                        Game.selectedChar.add(e);
                        print(Game.selectedChar);
                        if (!word.split('').contains(e.toUpperCase())) {
                          Game.tries++;
                        }else{Game.a++;}
                        if(Game.a== word.split('').length){
                          //word= '';
                          Game.a=0;
                          Game.tries=0;
                          Game.selectedChar.clear();
                          card_list.clear();
                          alphabets.clear();
                          //descrip.clear();
                          word= '';
                          _showDialog(context, 'Ganaste','');
                        }
                        if (Game.tries >= 7) {
                          Game.selectedChar.clear();
                          card_list.clear();
                          alphabets.clear();
                          //descrip.clear();
                          word= '';
                          Game.a=0;
                          Game.tries=0;
                          _showDialog(context, 'Perdiste','');
                        }
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      e,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    fillColor: Game.selectedChar.contains(e)
                        ? Colors.black87
                        : Colors.blue,
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String title, String info) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(info),
            actions: <Widget>[
              TextButton(
                child: const Text('Ir a inicio'),
                onPressed: () {
                  // Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MenuTema(idTem: Tem, Tem: nTem,
          ),),);
                  },
              )
            ],
          );
        });
  }

}

