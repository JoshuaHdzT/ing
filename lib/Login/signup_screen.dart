import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ing/Login/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:secappen/HomePage/homePage.dart';

import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _form = GlobalKey<FormState>();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _groupTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  final firebase = FirebaseFirestore.instance;

  registroUser() async {
    try {
      await firebase.collection('Users').doc().set({
        "Nombre": _nameTextController.text,
        "Grupo": _groupTextController.text,
        "Username": _emailTextController.text,
        "Password": _passwordTextController.text,
      });
    } catch (e) {
      print('ERROrR' + e.toString());
    }
  }

  showSucsses(context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      showCloseIcon: true,
      title: "Felicidades",
      desc: "El registro esta completo",
      btnOkOnPress: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => SignInScreen()));
      },
    )..show();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
          child: Form(
            key: _form,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _nameTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'User',
                        hintText: 'Digite su usuario',
                        fillColor: Colors.white
                      ),
                      validator: (value){
                        if(value == ""){
                          return "Este campo es obligatorio";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _groupTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Group',
                        hintText: 'Digite su grupo',
                        fillColor: Colors.white,
                      ),
                      validator: (value){
                        if(value == ""){
                          return "Este campo es obligatorio";}
                        return null;
                      },),),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _emailTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Email',
                        hintText: 'Digite su Email',
                        fillColor: Colors.white,
                      ),
                      validator: (value){
                        if(value == ""){
                          return "Este campo es obligatorio";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _passwordTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Password',
                        hintText: 'Digite su password',
                        fillColor: Colors.white,),
                      validator: (value){
                        if(value == ""){
                          return "Este campo es obligatorio";}
                        return null;
                      },),),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 50, right: 10),
                    child: Center(
                      child: AnimatedButton(
                        text: 'Registrar',
                        color: Colors.lightBlueAccent,
                        pressEvent: () {
                          var isValid = _form.currentState?.validate();
                          if (isValid == null || !isValid) {
                            return;}
                          print('Ingresando');
                          registroUser();
                          _nameTextController.clear();
                          _groupTextController.clear();
                          _emailTextController.clear();
                          _passwordTextController.clear();
                          showSucsses(context);
                        },
                      ),
                    ),
                  ),

                  /**
                      reusableTextField("Enter your name", Icons.person_2_outlined, false, _nameTextController),
                      const SizedBox(
                      height: 20,
                      ),
                      reusableTextField("Enter your group", Icons.account_balance_sharp, false, _groupTextController),
                      const SizedBox(
                      height: 20,
                      ),
                      reusableTextField("Enter Username", Icons.person_2_outlined, false, _emailTextController),
                      const SizedBox(
                      height: 20,
                      ),
                      reusableTextField("Enter Password", Icons.lock_clock_outlined, false, _passwordTextController),
                      const SizedBox(
                      height: 20,
                      ),
                      signInSignUpButton(context, false, (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));

                      }),

                   **/
                ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}
