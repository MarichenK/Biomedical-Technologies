// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
        title: const Text('AgriFit', textScaleFactor: 1.5,),
        foregroundColor: const Color.fromARGB(255, 93, 155, 97),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 17, right: 17),
            child: Container(
              height: 340,
              color: const Color.fromARGB(255, 237, 237, 237),
              child: const Center(child: Text('Goal'),),
            )),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 17, right: 17),
            child: Container(
              height: 140,
              color: const Color.fromARGB(255, 237, 237, 237),
              child: const Center(child: Text('Steps'),),
            )),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 17, right: 17),
            child: Container(
              height: 140,
              color: const Color.fromARGB(255, 237, 237, 237),
              child: const Center(child: Text('Calories'),),
            )),
        ]),
    );
  } //build

} //ProfilePage


void test = LineChart(
  LineChartData(
    // read about it in the LineChartData section
  ),
  swapAnimationDuration: const Duration(milliseconds: 150), // Optional
  swapAnimationCurve: Curves.linear, // Optional
);
