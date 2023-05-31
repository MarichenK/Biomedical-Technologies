import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const route = '/home/';
  static const routename = 'Home';

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        //title: Text(HomePage.routename),
        title: Text('AgriFit', textScaleFactor: 1.5,),
        foregroundColor: Color.fromARGB(255, 93, 155, 97),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
              height: 340,
              color: Color.fromARGB(255, 237, 237, 237),
              child: Center(child: Text('Goal'),),
            )),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
              height: 140,
              color: Color.fromARGB(255, 237, 237, 237),
              child: Center(child: Text('Steps'),),
            )),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
              height: 140,
              color: Color.fromARGB(255, 237, 237, 237),
              child: Center(child: Text('Calories'),),
            )),
        ]),
    );
  } //build

} //ProfilePage