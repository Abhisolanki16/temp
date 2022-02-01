

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({ Key? key }) : super(key: key);

  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Profile"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              
              CupertinoButton(
                onPressed: () {},
                  child: CircleAvatar(
                  radius: 60,
                  child: Icon(Icons.person,size: 60,),
                ),
              ),

              SizedBox(
                height: 30,
              ),

              TextField(
                decoration: InputDecoration(
                  labelText: "username",
                ),
              ),

              SizedBox(height: 30,),

              ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    }, 
                    child: Text("Submit"),),
            ],
          ),
        ),
      ),
    );
  }
}