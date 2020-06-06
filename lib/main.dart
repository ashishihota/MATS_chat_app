import 'package:flutter/material.dart';
import 'helper/authenticate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.yellow.shade600,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Authenticator(),
    );
}
}
