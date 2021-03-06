import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_project/Services/Message.dart';
import 'package:new_project/Services/MessageComponent.dart';
import 'package:new_project/Services/auth_service.dart';
import 'package:new_project/Services/db_service.dart';
import 'package:new_project/Services/users.dart';

class ChatPage extends StatelessWidget {
 ChatPage({ Key? key,this.user}) : super(key: key);
 final cUser? user;
 var msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.username!),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Message>>(
                stream: DBService().getMessage(user!.uid!),
                builder: (context, s1) {
                  if(s1.hasData){
                    return StreamBuilder<List<Message>>(
                      stream: DBService().getMessage(user!.uid!,false),
                      builder: (context,s2){
                        if(s2.hasData){
                          var messages = [...s1.data!,...s2.data!];
                          messages.sort((i, j)=>i.createdAt!.compareTo(j.createdAt!));
                          messages = messages.reversed.toList();
                          return ListView.builder(
                            reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (context,index){
                              final msg = messages[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: MessageComponent(msg: msg));
                            },
                          );
                        }else{
                          return Center(child: CircularProgressIndicator());
                        }
                      }
                    );
                  }else{
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: msgController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async{
                    var msg = Message(
                      content: msgController.text,
                      createdAt: Timestamp.now(),
                      recieverId: user!.uid,
                      senderUid: AuthService().user.uid
                    );
                    msgController.clear();
                    await DBService().sendMessage(msg);
                  
                  },
                   icon: Icon(Icons.send)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}