import 'package:flutter/material.dart';
import 'package:agri_fit/screens/homePage.dart';

void main() {
  runApp(const MainApp());
} //main

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //This specifies the app entrypoint.
      home: HomePage(),
    );
  } //build
}//MyApp