import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_project/Services/db_service.dart';
import 'package:new_project/Services/users.dart';

class AuthService{
  
  final auth = FirebaseAuth.instance;
  
  Future<bool> signIn(String email,String password) async{
  
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch(e){
      return false;
    }
  }

  signUp(String username,String email,String password) async{
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      await DBService().saveUser(cUser(uid: user.uid,email: user.email,username: username));
      return true;
    }on FirebaseAuthException catch(e){
      return false;
    }
  }
  

  User get user => FirebaseAuth.instance.currentUser!;

  

  Stream<User?> get onChangedUser => auth.authStateChanges();

  signOut() async{
    await auth.signOut();
   
  }



}
