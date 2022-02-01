import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_project/Pages/ChatPage.dart';
import 'package:new_project/Pages/HomePage.dart';
import 'package:new_project/Pages/LoginPage.dart';

import 'Services/auth_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      // home:StreamBuilder(
      //   stream: AuthService().onChangedUser,
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     return snapshot.data == null ? LoginPage() :  HomePage();        
      //   },
      // ),
    );
  }
}