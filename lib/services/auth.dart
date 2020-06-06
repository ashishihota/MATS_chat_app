import 'package:firebase_auth/firebase_auth.dart';
import 'package:matschatapp/modal/user.dart';

class AuthMethods{
  // _s is used to declare a variable private
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _userFromFirebase(FirebaseUser user){
    return user != null ? User(userId: user.uid) : null;
  }

  //when we req some some from the server, or adding, or calling a query... for that it is take some time, so we use await and async
  Future signInWithEmail(String email, String password) async{
    try{
      //the result from the Firebase auth
      // await because we want to wait until this is complete before going to another task. So we will not
      // until this is done. to make sure we are not getting the null value from the server.
      //AuthResult is a prebuilt function by firebase to store the data about the user
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebase(firebaseUser);

      // we will only use firebase id of the user.
    }
    catch(e){
      print(e.toString());
    }
  }

  //this is to create a new user
  Future signUpWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebase(firebaseUser);
    }
    catch(e){
      print(e.toString());
    }
  }

  //
  Future resetpass(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }
    catch(e){
      print(e.toString());
    }
  }

  // sign out of the app
  Future signOut()async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
    }
  }
}