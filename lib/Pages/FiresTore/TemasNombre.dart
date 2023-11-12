

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getTemaNom() async {
  List Tnom =[];
  CollectionReference collectionTnom = db.collection('Temas');

  QuerySnapshot queryTnom = await collectionTnom.get();

  queryTnom.docs.forEach((element) {
    Tnom.add(element.data());
  });

  return Tnom;
}