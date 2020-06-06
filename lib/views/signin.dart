import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matschatapp/services/auth.dart';
import 'package:matschatapp/widget/widget.dart';
import 'package:matschatapp/views/chatroomscreen.dart';
import 'package:matschatapp/helper/helperfunction.dart';
import 'package:matschatapp/services/database.dart';

class SignIn extends StatefulWidget {

  final Function toggle;
  SignIn(this.toggle);


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  AuthMethods authMethods = new AuthMethods();
  final formkey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;


  //1. we validate how we validate in the signup screen
  //2. added email offline
  //3. showing user loadingscreen
  //4. created a function in database to get the useremail instead of username
  //5. signing the user up
  //6. sending the user to next page
  signIn(){
    if(formkey.currentState.validate()){
      //added the email to shared prefrence (saving the email Id locally)
      HelperFunction.saveUserEmaileSharedPrefrence(emailTextEditingController.text);
      setState(() {
        isLoading = true;
      });

      authMethods.signUpWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((val){
       if(val != null){
         dataBaseMethods.getUserByEmail(emailTextEditingController.text).then((val){
           snapshotUserInfo = val;
           HelperFunction.saveUserEmaileSharedPrefrence(snapshotUserInfo.documents[0].data["name"]);
         });

         HelperFunction.saveUserLoggedInSharedPrefrence(true);
         Navigator.pushReplacement(context, MaterialPageRoute(
             builder: (context) => ChatRoom()));
       }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
                  key: formkey,
                  child: Column(children: <Widget>[
                    TextFormField(
                        validator: (val){
                          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+") //RegExp
                              .hasMatch(val) ? null : "Please enter a valid email";
                        },
                        controller: emailTextEditingController,
                        style: txtStyle(),
                        decoration: textFieldInputDecoration("email")
                    ),
                    TextFormField(
                        obscureText: true,
                        validator: (val){
                          return val.length > 6 ? null : "Enter a valid Password(more than 6 characters)";
                        },
                        controller: passwordTextEditingController,
                        style: txtStyle(),
                        decoration: textFieldInputDecoration("password")
                    ),
                  ],),
                ),
                SizedBox(height: 8,),
               Container(
                 alignment: Alignment.centerRight,
                 child: Container(
                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                     child: Text("Forgot Password?", style: txtStyle(),),
                 ),
               ),
                SizedBox(height: 8,),
                GestureDetector(
                  onTap: (){
                    signIn();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding : EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text("Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding : EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text("Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have account? ", style: txtStyleMedium(),),
                    GestureDetector(
                      onTap: (){
                        widget.toggle(); //to access the function in the widget file
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text("Register Now.", style: TextStyle(
                            color: Colors.black38,
                            fontSize: 17,
                            decoration: TextDecoration.underline,
                        ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
              ],
            ),
          ),
        ),
      )
    );
  }
}
