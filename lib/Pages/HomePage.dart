import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project/Pages/ChatPage.dart';
import 'package:new_project/Services/auth_service.dart';
import 'package:new_project/Services/db_service.dart';
import 'package:new_project/Services/users.dart';

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("${AuthService().user.email}"),
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(onPressed: () async{
            await AuthService().signOut();
          },
          icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<cUser>>(
        stream: DBService().getDiscussionUser,
        builder: (_, snapshot){
          if(snapshot.hasData){
            final users = snapshot.data;
            return ListView.builder(
              itemCount: users!.length,
              itemBuilder: (context , index){
              final user = users[index];  
                var listTile = ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ChatPage(user: user);
                      }));
                  },
                leading: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueGrey,
                    ),
                    child: Icon(Icons.person),
                  ),
                 
                title: Text(CheckUsername()),
                subtitle: Text(user.email!),
              );
                return listTile;
              
            });
          }
          else{
            return Center(
              child: CircularProgressIndicator()
            );
          }
        }
      )
    );
  }
}

CheckUsername(){
  var Username = cUser().username;
  if(Username == null){
    return Username;
  }else{
    return Username;
  }
}