import 'package:firebase_core/firebase_core.dart';
import 'package:ing/Pages/HomePage.dart';
//import 'package:ing/Pages/Login.dart';
import 'package:flutter/material.dart';
//import 'package:ing/Pages/Home_Pagee.dart';
import 'package:ing/Pages/game/game.dart';
//import 'package:ing/Pages/nv.dart';
import 'package:ing/Login/signin_screen.dart';

//import 'Pages/Menu_Tema.dart';
//import 'Pages/Videos.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(


        primarySwatch: Colors.blue,
      ),
       // home: const LoginPage(),
          home: const SignInScreen(),
      routes: {
       // 'menu': (context) => MenuTema(idTem: '', Tem: '', id: '',),
        'home': (context) => HomePage(),
        'game': (context) => Game(),

      },
    );
  }
}

