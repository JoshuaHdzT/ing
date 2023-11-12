import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ing/Login/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
//import 'package:secappen/HomePage/homePage.dart';
//import 'package:secappen/Login/signup_screen.dart';

import '../reusable_widgets/reusable_widget.dart';

import '../Pages/homePage.dart';
import '../utils/color_utils.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}



class _SignInScreenState extends State<SignInScreen> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();


  validarDatos() async{
    try{
      CollectionReference ref=FirebaseFirestore.instance.collection('Users');
      QuerySnapshot usuario=await ref.get();

      if(usuario.docs.length !=0){
    for(var cursor in usuario.docs){
      if(cursor.get('Username')==_emailTextController.text){
        //print('Usuario encontrado');
        if(cursor.get('Password')==_passwordTextController.text){
          print('Acceso correcto');
          if(cursor != null){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );

          }else{
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Intente de Nuevo',
              text: 'Usuario o Contraseña incorrecto',
            );
          }
        }else{
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Intente de Nuevo',
            text: 'Contraseña incorrecto',
          );
        }
      }
    }
      }

    }catch(e){
      print('ERROR'+e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.1, 20, 0),
            child: Column(
              children: <Widget>[
                //logoWidget("assets/images/logo.png"),
                Padding(padding: const EdgeInsets.symmetric(vertical: 15),
                  child: ClipOval(
                    child: Image(
                      image : AssetImage('assets/images/logo.jpeg'),
                      //Image.network(
                      //   "https://cdn-icons-png.flaticon.com/512/6335/6335600.png",
                      width: 250,
                      height: 240,
                      fit: BoxFit.fill,),
                  ),
                ),

                SizedBox(height: 20,),
                Text("Hola", style: TextStyle(fontSize: 28,color: Colors.white),
                ),
                SizedBox(height: 5,),
                Text("Listo para Aprender",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),

                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: _emailTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'User',
                      hintText: 'Digite su usuario',
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(20),

                  child: TextField(

                    style: TextStyle(color: Colors.white),
                    controller: _passwordTextController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Password',
                      hintText: 'Digite su contraseña',

                    ),
                  ),
                ),


      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("No tienes cuenta?",
              style: TextStyle(color: Colors.white70)),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
            child: const Text(
              " Crea una",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),



                Padding(
                  padding: EdgeInsets.only(left: 20,top: 50, right: 10),
                child: Center(
                  child: AnimatedButton(

                    pressEvent: (){
                      print('Ingresando');
                      validarDatos();
                    },

                     text:'Ingresar',
                    color: Colors.lightBlueAccent,
                  ),
                ),
                ),





                /**
                SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter Username", Icons.person_2_outlined, false, _emailTextController),
                SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter Password", Icons.lock_clock_outlined, true, _passwordTextController),
                SizedBox(
                  height: 30,
                ),
                signInSignUpButton(context, true, (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                } ),

                signUpOption()
                **/
              ],
            ),
          ),
        ),
      ),
    );
  }
/**
  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("No tienes cuenta?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sing Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
    **/


  }



