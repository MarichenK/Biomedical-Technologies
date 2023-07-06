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
      /*appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        //title: Text(HomePage.routename),
        title: const Text('AgriFit', textScaleFactor: 1.5,),
        foregroundColor: Color.fromARGB(255, 27, 179, 141),
      ),*/
      // Hide appbar
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: AppBar(
            backgroundColor: Colors.grey[50],
            elevation: 0,
          ),
        ),

      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Summary',
                      textScaleFactor: 3,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 27, 179, 141))),
                ),

                IconButton(
                  iconSize: 50,
                  color: Colors.grey,
                  icon: const Icon(Icons.refresh,),
                  splashRadius: 32,
                  splashColor: Color.fromARGB(255, 237, 237, 237),
                  onPressed: () {},
                )
              ],
            ),

            Expanded(
              child: ListView(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Monthly steps',
                        textScaleFactor: 2.2,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
            
                  const SizedBox(height: 16),
            
                  SizedBox(
                    height: 320,
                    child: Container( 
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[50]),
                    child:
                    StepsGraph(
                      monthlySteps: monthlySteps,
                      ),
                  )),
            
                  const SizedBox(height: 36),
            
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Activity today',
                        textScaleFactor: 2.2,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
            
                  const SizedBox(height: 11),
                    
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container( 
                        height: 140,
                        width: 190,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 27, 179, 141)),
                        
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Center(child: Text('12304',
                              textScaleFactor: 2.5,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)
                                ),
                                ),
                            Text('Steps'),
                          ],
                        ),
                      ),
                  
                      Container( 
                        height: 140,
                        width: 190,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 237, 237, 237)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Center(child: Text('2000',
                              textScaleFactor: 2.5,
                              style: TextStyle(fontWeight: FontWeight.bold),),),
                            Text('Calories'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
            ),
          ],
        ),
      ),
    );
  } } //HomePage