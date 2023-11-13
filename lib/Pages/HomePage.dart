import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:ing/Pages/FiresTore/TemasNombre.dart';
//import 'package:ing/Pages/Login.dart';
import 'package:ing/Pages/Menu_Tema.dart';

import '../utils/color_utils.dart';
//import 'Videos.dart';

//stf

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> names = ["Colores", "Numeros", "Pronombres"];
  List<String> imgs = [
    "https://www.consumer.es/app/uploads/fly-images/262266/Mezclar-colores-1200x550-cc.jpg",
    "https://www.letrasnumeros.com/storage/2022/06/numeros-letras.png",
    "https://img.freepik.com/vector-gratis/pack-avatares-diferentes-personas_23-2148455572.jpg"
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Temas de Aprendizaje"),
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
          children: [Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: StreamBuilder(
                stream:
                FirebaseFirestore.instance.collection('Temas').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();}
                  List<DocumentSnapshot> docs = snapshot.data!.docs;
                  return GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300, childAspectRatio: 0.7,
                          crossAxisSpacing: 10, mainAxisSpacing: 20),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot tema = docs[index];
                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: ClipOval(
                                child: Image(image: NetworkImage(tema['img'].toString()),
                                  width: 120, height: 120, fit: BoxFit.fill,
                                ),),
                            ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15, right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text(tema['Nombre'],
                                    style: TextStyle(color: Colors.white,
                                        fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 0),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => MenuTema(idTem: tema.id, Tem: tema['Nombre'],
                                            ),),);},
                                        child: Container(
                                          width: 100, padding: EdgeInsets.all(9),
                                          decoration: BoxDecoration(
                                              color: Colors.greenAccent,
                                              borderRadius: BorderRadius.circular(18)),
                                          child: const Text("Ver", textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 18, color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
              ),
            ),
          ),
          ],
        ),
      ),
    );
    //return const Placeholder();
  }
}
