// ignore_for_file: file_names

import 'package:agri_fit/Utilities/graph/steps_data.dart';
import 'package:agri_fit/Utilities/graph/steps_graph.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const route = '/home/';
  static const routename = 'Home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<double> monthlySteps = [
  6000.0,
  8000.0,
  15000.0,
  16000.0,
  17000.0,
  15000.0,
  18000.0,
  14000.0,
  14000.0,
  15000.0,
  10000.0,
  8000.0
];

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
      body: Padding(
        padding: const EdgeInsets.only(left: 17, right: 17),
        child: ListView(
          children: [
            const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Monthly average steps',
                      textScaleFactor: 1.8,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(top: 1),
              child: SizedBox(
                height: 300,
                child: StepsGraph(
                  monthlySteps: monthlySteps,
                  ),
              )),
            const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Steps',
                      textScaleFactor: 1.8,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container( 
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 237, 237, 237)),
                child: Row(
                  children: const [
                    Center(child: Text('12304',
                      textScaleFactor: 2,
                      style: TextStyle(fontWeight: FontWeight.bold)),),
                    Center(child: Text('Steps'),),
                  ],
                ),
              )),
            const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Calories burnt',
                      textScaleFactor: 1.8,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container( 
                height: 100,
                child: const Center(child: Text('Calories'),),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 237, 237, 237)),
              )),
          ]),
      ),
    );
  } } //ProfilePage


void test = LineChart(
  LineChartData(
    // read about it in the LineChartData section
  ),
  swapAnimationDuration: const Duration(milliseconds: 150), // Optional
  swapAnimationCurve: Curves.linear, // Optional
);
