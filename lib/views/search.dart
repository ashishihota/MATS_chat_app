import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matschatapp/services/database.dart';
import 'package:matschatapp/widget/widget.dart';
import 'package:matschatapp/helper/constants.dart';
import 'package:matschatapp/views/conversationscreen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  TextEditingController searchTextEditingController = new TextEditingController();

  QuerySnapshot searchSnapshot;

  initiateSearch(){
    dataBaseMethods.getUserByUserName(searchTextEditingController.text).then((val){
      setState(() {                                                     //It recreates the whole screen with the updated data
        searchSnapshot = val;
      });
    });
  }


  // The list of username searched
  Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
        itemCount: searchSnapshot.documents.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return searchTile(
            userEmail: searchSnapshot.documents[index].data["name"],
            userName: searchSnapshot.documents[index].data["email"],
          );
        }) : Container();
  }

  /// create chatroom and start conversation
  /// TODO : i have done everything till video 2.
  createChatRoomAndStartConversation({String userName}){
    String chatRoomId = getChatRoomId(userName, Constants.myName);
    List<String> users = [userName, Constants.myName];

    Map<String, dynamic> chatRoomMap = {
      "users" : users,
      "chatroomid" : chatRoomId
    };
    DataBaseMethods().createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => ConversationScreen(),
    ));
  }
  Widget searchTile({ String userName, String userEmail}){
    return Container(
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(userEmail, style: txtStyle(),),
              Text(userName, style: txtStyle(),),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createChatRoomAndStartConversation(userName: userName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Text("Message", style: txtStyleMedium(),),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      style: TextStyle(
                        color: Colors.yellow,
                      ),
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: Colors.orangeAccent,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                     initiateSearch();
                    },
                    child: Container(
                       height: 40,
                        width: 40,
                        padding: EdgeInsets.all(10),
                        child: Image.asset("assets/search.png")
                    ),
                  )
                ],
              ),
            ),
            searchList(),
          ],
        ),
      ),
    );
  }
}

//a function to generate a unique chat room id
getChatRoomId(String a, String b){
  if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }else{
    return "$a\_$b";
  }
}