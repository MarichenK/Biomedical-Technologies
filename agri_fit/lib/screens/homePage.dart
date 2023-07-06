// ignore_for_file: file_names


import 'dart:convert';
import 'dart:io';

import 'package:agri_fit/Utilities/graph/steps_data.dart';
import 'package:agri_fit/Utilities/graph/steps_graph.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agri_fit/screens/authenticationIMPACT.dart';
import 'package:agri_fit/Utilities/Impact.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:agri_fit/Database/Steps.dart';
import 'package:intl/intl.dart';


void test = LineChart(
  LineChartData(
    // read about it in the LineChartData section
  ),
  //swapAnimationDuration: const Duration(milliseconds: 150), // Optional
  //swapAnimationCurve: Curves.linear, // Optional
);



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

                          children: [
                            Center(child: Row(
                              children: [
                                Center(child: 
                                  FutureBuilder<List<Steps>?>(
                                    future: _requestStepsToday(), 
                                    builder: (BuildContext context, AsyncSnapshot<List<Steps>?> snapshot) {
                                    print(snapshot);
                                    if (snapshot.hasData) {
                                      return Text(snapshot.data!.map((e) => e.step).reduce((a, b) => a + b).toString());
                                    } else {
                                      return Text("NO"); }
                                    },)
                                ),
                    
                    ElevatedButton(onPressed: () async {
                  final result = await _authorize();
                  final message =
                      result == 200 ? 'Request successful' : 'Request failed';
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(message)));
                },
                child: Text('Authorize the app')),
                  ],
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

                          children: [
                            Center(child: Row(
                  children: [
                    Center(child: 
                      FutureBuilder<List<Callories>?>(
                        future: _requestCalsToday(),
                        builder: (BuildContext context, AsyncSnapshot<List<Callories>?> snapshot) {
                          print(snapshot);
                          if (snapshot.hasData) {
                            return Text(snapshot.data!.map((e) => e.cals).reduce((a, b) => a + b).toString());
                          } else {
                            return Text("NO");
                          }
                  },
              ))]),
                              ),

                         

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
  } 

  Future<List<Steps>?> _requestStepsToday() async {
    //Initialize the result
    List<Steps>? result;

    //Get the stored access token (Note that this code does not work if the tokens are null)
    String? access;

    final sp = await SharedPreferences.getInstance();
    access = sp.getString('access');


    if (access == null) {
      return [
        Steps(dateTime: DateTime.now(), step: 0),
      ];
    }

    //If access token is expired, refresh it
    if(JwtDecoder.isExpired(access)){
      await _refreshTokens();
      access = sp.getString('access');
    }//if

    //Create the (representative) request
    final String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 1)));
    final url = Impact.baseUrl + Impact.stepsEndpoint + Impact.patientUsername + '/day/$currentDate/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    //Get the response
    print('Calling: $url');
    final response = await http.get(Uri.parse(url), headers: headers);

    //if OK parse the response, otherwise return null
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      result = [];
      for (var i = 0; i < decodedResponse['data']['data'].length; i++) {
        String date = decodedResponse['data']['date'];
        Map<String, dynamic> json = decodedResponse['data']['data'][i];
        result.add(Steps.fromJson(date, json));
      }//for
    } //if
    else{
      result = null;
    }//else

    //Return the result
    return result;

  } //_requestData

  Future<int> _refreshTokens() async {

    //Create the request
    final url = Impact.baseUrl + Impact.refreshEndpoint;
    final sp = await SharedPreferences.getInstance();
    final refresh = sp.getString('refresh');
    final body = {'refresh': refresh};

    //Get the respone
    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body);

    //If 200 set the tokens
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      sp.setString('access', decodedResponse['access']);
      sp.setString('refresh', decodedResponse['refresh']);
    } //if

    //Return just the status code
    return response.statusCode;

  }

  Future<int?> _authorize() async {
    final url = Impact.baseUrl + Impact.tokenEndpoint;
    final body = {'username': Impact.username, 'password': Impact.password};

    //Get the response
    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body);

    //If 200, set the token
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      sp.setString('access', decodedResponse['access']);
      sp.setString('refresh', decodedResponse['refresh']);
    }

    //return the status code
    return response.statusCode;
  }

  Future<List<Callories>?> _requestCalsToday() async {
    //Initialize the result
    List<Callories>? result;

    //Get the stored access token (Note that this code does not work if the tokens are null)
    String? access;

    final sp = await SharedPreferences.getInstance();
    access = sp.getString('access');


    if (access == null) {
      return [
        Callories(dateTime: DateTime.now(), cals: 0),
      ];
    }

    //If access token is expired, refresh it
    if(JwtDecoder.isExpired(access)){
      await _refreshTokens();
      access = sp.getString('access');
    }//if

    //Create the (representative) request
    final String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 1)));
    final url = Impact.baseUrl + Impact.caloriesEndpoint + Impact.patientUsername + '/day/$currentDate/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    //Get the response
    print('Calling: $url');
    final response = await http.get(Uri.parse(url), headers: headers);

    //if OK parse the response, otherwise return null
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      result = [];
      for (var i = 0; i < decodedResponse['data']['data'].length; i++) {
        String date = decodedResponse['data']['date'];
        Map<String, dynamic> json = decodedResponse['data']['data'][i];
        result.add(Callories.fromJson(date, json));
      }//for
    } //if
    else{
      result = null;
    }//else

    //Return the result
    return result;

  } //_requestData

  
  } //HomePage

