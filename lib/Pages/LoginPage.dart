// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:new_project/Pages/HomePage.dart';
import 'package:new_project/Pages/SignUpPage.dart';
import 'package:new_project/Services/auth_service.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                    decoration: InputDecoration(
                      labelText: "Email Address"
                    ),
                  ),

                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password"
                    ),
                  ),

                  SizedBox(height: 30,),
                  
                  ElevatedButton(
                    onPressed: ()async{
                      await AuthService().signIn(emailController.text, passwordController.text);
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return HomePage();
                      }));
                    }, 
                    child: Text("Log in"),),

                  SizedBox(height: 30,),

                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return SignUpPage();
                      }));
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