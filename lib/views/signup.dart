import 'package:flutter/material.dart';
import 'package:matschatapp/services/auth.dart';
import 'package:matschatapp/services/database.dart';
import 'package:matschatapp/views/chatroomscreen.dart';
import 'package:matschatapp/widget/widget.dart';
import 'package:matschatapp/helper/helperfunction.dart';

class SignUp extends StatefulWidget {

  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


  bool isLoading = false;
  final formkey = GlobalKey<FormState>();

  AuthMethods authMethods = new AuthMethods();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();

  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();


  //1. validate
  //2. show the loading screen
  //3. signIn/ SignUp
  //4. send the user to chat-room

  signMeUp(){
    // doing the loading in the loading screen
    if(formkey.currentState.validate()){
        Map<String, String> userInfoMap = {
          "name" : userNameTextEditingController.text,
          "email" : emailTextEditingController.text,
        };

        HelperFunction.saveUserEmaileSharedPrefrence(emailTextEditingController.text);
        HelperFunction.saveUserNameSharedPrefrence(userNameTextEditingController.text);

        setState(() {
          isLoading = true;
        });

        // Once the validation is done, it generates the key-value pair of name and email and stores them in our database
        // It takes the email and password and automatically matches them with their respective fields
        authMethods.signUpWithEmailAndPassword(emailTextEditingController.text,
            passwordTextEditingController.text,).then((val){

              //function to upload the data to the firebase. Making a key-value pair
              dataBaseMethods.uploadUserInfo(userInfoMap);

              //Use Navigator.push to next page or screen
              // push -> go back to previous screen
              // pushReplacement -> won't allow the user to go back to previous screen
              HelperFunction.saveUserLoggedInSharedPrefrence(true);
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => ChatRoom()
              ));
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarMain(context),
        body: isLoading ? Container(
          child : Center(child: CircularProgressIndicator())        // the circular loading screeen
        ) : SingleChildScrollView(                // To make the height fit the screen and scroll if the contents are too large
          child: Container(
            height: MediaQuery.of(context).size.height - 50,
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Form(   //To provide a key to validate all the credentials
                    key: formkey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          validator: (val){
                            //we can show the user if the value is wrong as an error message
                            return val.isEmpty || val.length < 5 ? "Enter a valid Username(more than 4 characters)" : null;
                          },
                            controller: userNameTextEditingController,
                            style: txtStyle(),
                            decoration: textFieldInputDecoration("username"),
                        ),
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
                        )
                      ],
                    ),
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
                      signMeUp();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding : EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text("Sign Up",
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
                    child: Text("Sign Up with Google",
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
                      Text("Already have an account? ", style: txtStyleMedium(),),
                      GestureDetector(
                        onTap: (){
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text("Sign In.", style: TextStyle(
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
