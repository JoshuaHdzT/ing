import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _form = GlobalKey<FormState>();
  final txtUserController = TextEditingController();
  final txtPasswordController = TextEditingController();

  Future<void> _login() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body:SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: const EdgeInsets.symmetric(vertical: 15),
                    child: ClipOval(
                     child: Image(
                         image : AssetImage('assets/images/logo.jpeg'),
                        //Image.network(
                        //   "https://cdn-icons-png.flaticon.com/512/6335/6335600.png",
                        width: 250,
                       height: 200,
                       fit: BoxFit.fill,),
                    ),
                    ),

                  SizedBox(height: 20,),
                  Text("Hola", style: TextStyle(fontSize: 28,),
                  ),
                  SizedBox(height: 5,),
                  Text("Listo para Aprender", style: TextStyle(fontSize: 20,),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      controller: txtUserController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          hintText: 'Usuario'
                      ),

                      validator: (value) {
                        if (value == "") {
                          return "Este campo es obligatorio";
                        }
                        return null;
                      }, //validator
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                        controller: txtPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          hintText: 'Contraseña',
                          fillColor: Colors.blue[50],
                        ),
                        validator: (value) {
                          if (value == "") {
                            return "Este campo es obligatorio";
                          }
                          print("haver2");
                          return null;
                        }),
                  ),
                  SizedBox(height: 20,),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextButton(
                      onPressed: () async {
                        var isValid = _form.currentState?.validate();
                        if (isValid == null || !isValid) {
                          return;
                        }
                        try {
                          UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                              email: txtUserController.text, password: txtPasswordController.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        } //try
                        catch (e) {
                          print("ocurrio un error" + e.toString());
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            title: 'Intente de Nuevo',
                            text: 'Usuario o Contraseña incorrecto',
                          );
                        }
                      },
                      child:Container(
                        width: 350,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,

                          borderRadius: BorderRadius.circular(18)
                        ),
                        child: const Text("Inicia sesión",
                          textAlign: TextAlign.center,
                            style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                      ),

                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
