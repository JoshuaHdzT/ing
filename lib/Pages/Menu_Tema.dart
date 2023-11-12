import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ing/Pages/HomePage.dart';
import 'package:ing/Pages/Videos.dart';
import 'package:ing/Quizz/Paginas/home_page.dart';
import 'package:ing/QuizzNumeros/NuPaginas/Nuhome_page.dart';
import 'package:ing/QuizzVerboTobe/TobePaginas/Tobehome_page.dart';

import '../QuizzABEC/ABECPaginas/ABhome_page.dart';
import '../utils/color_utils.dart';
import 'nv.dart';

class MenuTema extends StatefulWidget {
  final String idTem;
  final String Tem;

  const MenuTema({super.key, required this.idTem, required this.Tem, });

  @override
  State<MenuTema> createState() => _MenuTemaState(this.idTem, this.Tem);
}

class _MenuTemaState extends State<MenuTema> {
  String idTem;
  String Tem;

  CollectionReference temas = FirebaseFirestore.instance.collection('Temas');
  _MenuTemaState(this.idTem, this.Tem, );

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Aprendiendo " + Tem),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Column(
                  children: [
                    Expanded(
                      child: Image(
                        image: AssetImage('assets/images/logo.jpeg'),
                      ),
                    )
                  ],
                )),
            ListTile(
              leading: Icon(Icons.list),
              title: Text("Temas"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.play_circle),
              title: Text("Ver videos"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Videos(
                      idTem: idTem,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.quiz),
              title: Text("Memorama"),
              onTap: () {
                if (idTem.isNotEmpty) {
                  temas.doc(idTem).get().then((value) {
                    Navigator.pushNamed(context, 'game', arguments: {
                      'level': value['Nombre'].toString(),
                      'id': idTem,

                    });
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.man),
              title: Text("Hangman"),
              onTap: () {
                if (idTem.isNotEmpty) {
                  temas.doc(idTem).get().then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => nv(
                          Tem: idTem,
                          nTem: value['Nombre'].toString(),
                        ),
                      ),
                    );
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.question_mark),
              title: Text("Quiz"),
              onTap: () {
                if (idTem.isNotEmpty) {
                  temas.doc(idTem).get().then((value) {
    if (value['Nombre'] == 'Colores') {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          ColoreQuizHome
        (idTem: idTem, Tem: value['Nombre'].toString(),),),
      );
    }
    if (value['Nombre'] == 'Números') {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          NumerosHomePage
        (idTem: idTem, Tem: value['Nombre'].toString(),),),
      );
    }
    if (value['Nombre'] == 'Abecedario') {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          AbecedarioHomePage
        (idTem: idTem, Tem: value['Nombre'].toString(),),),
      );
    }
    if (value['Nombre'] == 'Verbo to be') {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          TobeHomePage
        (idTem: idTem, Tem: value['Nombre'].toString(),),),
      );
    }
                  });
                }
              },
            ),
          ],
        ),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                //leading: Icon(Icons.play_circle, color: Colors.white),
                leading: CircleAvatar(backgroundImage: AssetImage('assets/images/videos.jpg'),),
                title: Text('Ver Videos', style: TextStyle(color: Colors.white),),
                subtitle: Text('ir a actividad',style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.play_circle, color: Colors.white),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Videos(
                        idTem: idTem,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                //leading: Icon(Icons.quiz, color: Colors.white),
                leading: CircleAvatar(backgroundImage: AssetImage('assets/images/box.png'),),
                title: Text('Memorama', style: TextStyle(color: Colors.white),),
                subtitle: Text('ir a actividad',style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.quiz, color: Colors.white),
                onTap: () {
                  if (idTem.isNotEmpty) {
                    temas.doc(idTem).get().then((value) {
                      Navigator.pushNamed(context, 'game', arguments: {
                        'level': value['Nombre'].toString(),
                        'id': idTem,

                      });
                    });
                  }
                },
              ),
              ListTile(
                //leading: Icon(Icons.man, color: Colors.white),
                leading: CircleAvatar(backgroundImage: AssetImage('assets/images/hang.png'),),
                title: Text('Hangman', style: TextStyle(color: Colors.white),),
                subtitle: Text('ir a actividad',style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.man, color: Colors.white),
                onTap: () {
                  if (idTem.isNotEmpty) {
                    temas.doc(idTem).get().then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => nv(
                            Tem: idTem,
                            nTem: value['Nombre'].toString(),
                          ),
                        ),
                      );
                    });
                  }
                },
              ),
              ListTile(
                //leading: Icon(Icons.question_mark, color: Colors.white),
                leading: CircleAvatar(backgroundImage: AssetImage('assets/images/descarga.jpg'),),
                title: Text('Quiz', style: TextStyle(color: Colors.white),),
                subtitle: Text('ir a actividad',style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.question_mark, color: Colors.white),
                onTap: () {
                  if (idTem.isNotEmpty) {
                    temas.doc(idTem).get().then((value) {
                      if (value['Nombre'] == 'Colores') {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            ColoreQuizHome
                              (idTem: idTem, Tem: value['Nombre'].toString(),),),
                        );
                      }
                      if (value['Nombre'] == 'Números') {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            NumerosHomePage
                              (idTem: idTem, Tem: value['Nombre'].toString(),),),
                        );
                      }
                      if (value['Nombre'] == 'Abecedario') {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            AbecedarioHomePage
                              (idTem: idTem, Tem: value['Nombre'].toString(),),),
                        );
                      }
                      if (value['Nombre'] == 'Verbo to be') {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            TobeHomePage
                              (idTem: idTem, Tem: value['Nombre'].toString(),),),
                        );
                      }
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
    return const Placeholder();
  }
}
