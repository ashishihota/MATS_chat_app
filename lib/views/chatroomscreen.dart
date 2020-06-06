import 'package:flutter/material.dart';
import 'package:matschatapp/services/auth.dart';
import 'package:matschatapp/helper/authenticate.dart';
import 'package:matschatapp/views/search.dart';
import 'package:matschatapp/views/chatroomscreen.dart';
import 'package:matschatapp/helper/constants.dart';
import 'package:matschatapp/helper/helperfunction.dart';
import 'package:matschatapp/services/database.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethods authMethods = new AuthMethods();

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo()async{
    Constants.myName = await HelperFunction.getUserNameSharedPrefrence();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/mats.png",
          height: 50,
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => Authenticator(),
              ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => SearchScreen(),
          ));
        },
      ),
    );
  }
}
