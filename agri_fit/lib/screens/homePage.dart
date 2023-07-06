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
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:agri_fit/Database/Steps.dart';
import 'package:intl/intl.dart';

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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 237, 237, 237)),
                child: Row(
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
            )),
          ],
    )));
  } } //ProfilePage

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


   

void test = LineChart(
  LineChartData(
    // read about it in the LineChartData section
  ),
  //swapAnimationDuration: const Duration(milliseconds: 150), // Optional
  //swapAnimationCurve: Curves.linear, // Optional
);
