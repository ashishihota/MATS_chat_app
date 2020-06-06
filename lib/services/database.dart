import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods{

  getUserByUserName(String username)async{
    // we are going to the database and making a query to the database where name is equal to the name that is provided
    return await Firestore.instance.collection("users").where("name", isEqualTo: username).getDocuments();
  }

  getUserByEmail(String email)async{
    // we are going to the database and making a query to the database where name is equal to the name that is provided
    return await Firestore.instance.collection("users").where("email", isEqualTo: email).getDocuments();
  }
  
  uploadUserInfo(userMap){
    Firestore.instance.collection("users").add(userMap);

  }

  //create a chatroom in the database
  createChatRoom(String chatRoomId, chatRoomMap){
    Firestore.instance.collection("ChatRoom").document(chatRoomId).setData(chatRoomMap).catchError((e){
      print(e.to_string());
    });
  }
}
