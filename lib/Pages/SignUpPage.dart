// ignore: avoid_web_libraries_in_flutter


import 'package:flutter/material.dart';
import 'package:new_project/Models/UserModel.dart';
//import 'package:new_project/Pages/CompleteProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_project/Pages/HomePage.dart';
import 'package:new_project/Services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({ Key? key }) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void checkValues(){

    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if(email == "" || password == "" || username == ""){
      print("Fill all fields");
    }else{
      print("Sign up sucessfully");
    }  
  }

  void signUp( String email , String password) async{

    // ignore: non_constant_identifier_names
    UserCredential? Credential;

    try{
      Credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(ex){
      // ignore: avoid_print
      print(ex.code.toString());
    }

    if(Credential != null) {
      String uid = Credential.user!.uid;
      UserModel newUser = UserModel(
        uid: uid,
        email: email,
        username: "",
        profilepic: "",
      );
      await FirebaseFirestore.instance.collection("users").doc(uid).set(newUser.toMap()).then((value) => print("new user created"));
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [

                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: "Username"
                    ),
                  ),

                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email Address"
                    ),
                  ),

                  TextField(
                    controller: passwordController ,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password"
                    ),
                  ),

                  SizedBox(height: 30,),
                  
                  ElevatedButton(
                    onPressed: () async{
                      await AuthService().signUp(usernameController.text, emailController.text, passwordController.text);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    }, 
                    child: Text("Sign Up"),),

                ],
              ),
            ),
          ),
        ),     
      ),
    );
  }
}