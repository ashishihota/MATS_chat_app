import 'package:flutter/material.dart';

Widget AppBarMain(BuildContext context){
  return AppBar(
    title: Image.asset("assets/images/mats.png",
      height: 50,
    ),
  );
}


InputDecoration textFieldInputDecoration(String hint){
  return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.black,
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black)
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      )
  );
}

TextStyle txtStyle(){
  return TextStyle(
      color: Colors.black,
      fontSize: 16
  );
}


TextStyle txtStyleMedium(){
  return TextStyle(
      color: Colors.black38,
      fontSize: 17
  );
}

