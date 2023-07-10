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


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const route = '/home/';
  static const routename = 'Home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<double> weeklySteps = [
  6000,
  8000,
  15000,
  16000,
];

  @override
  Widget build(BuildContext context) {
      return Scaffold(

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

                // request button 
                IconButton(
                  iconSize: 50,
                  color: Colors.grey,
                  icon: const Icon(Icons.refresh,),
                  splashRadius: 32,
                  splashColor: const Color.fromARGB(255, 237, 237, 237),
                  onPressed: () async {
                    final result = await _authorize();
                    final message = 
                      result == 200? 'Request successful' : 'Request failed';
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(content: Text(message)));
                  },
                )
              ],
            ),

            // listview with data
            // barGraph with weekly steps
            Expanded(
              child: ListView(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Weekly steps',
                        textScaleFactor: 2.2,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
            
                  const SizedBox(height: 26),
            
                  SizedBox(
                    height: 330,
                    child: Container( 
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[50]),
                    child:
                    StepsGraph(
                      weeklySteps: weeklySteps,
                      ),
                  )),
            
                  const SizedBox(height: 36),
            
                  // daily steps and calories burnt
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
                          color: const Color.fromARGB(255, 27, 179, 141)),
                        
                        child: 
                            Center(child: Column (
                              children: [
                                SizedBox(height: 40,),
                                Text('Steps:'),
                                SizedBox(height: 10,),
                                 
                                  FutureBuilder<List<Steps>?>(
                                    future: _requestStepsToday(), 
                                    builder: (BuildContext context, AsyncSnapshot<List<Steps>?> snapshot) {
                                    //print(snapshot);
                                    if (snapshot.hasData) {
                                      return Text(snapshot.data!.map((e) => e.step).reduce((a, b) => a + b).toString());
                                    } else {
                                      return Text("Cannot collect"); }
                                    },),
                                    FutureBuilder<List<StepsWeek>?>(
                                    future: _requestStepsWeek1(), 
                                    builder: (BuildContext context, AsyncSnapshot<List<StepsWeek>?> snapshot) {
                                    print(snapshot);
                                    if (snapshot.hasData) {
                                      return Text(snapshot.data!.map((e) => e.step).reduce((a, b) => a + b).toString());
                                    } else {
                                      return Text("Cannot collect"); }
                                    },)    
                          ],)
                        ),
                      ),
                  
                      Container( 
                        height: 140,
                        width: 190,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 237, 237, 237)),
                        child:Center(child: Column(
                          children: [
                            const SizedBox(height: 40,),
                            const Text('Calories'),
                            const SizedBox(height: 10,),
                      FutureBuilder<List<Callories>?>(
                        future: _requestCalsToday(),
                        builder: (BuildContext context, AsyncSnapshot<List<Callories>?> snapshot) {
                          print(snapshot);
                          if (snapshot.hasData) {
                            return Text(snapshot.data!.map((e) => e.cals).reduce((a, b) => a + b).toString());
                          } else {
                            return Text("Cannot collect");
                          }
                  },
              ),]),
                              ),
                  )
                    ],
                  ),
                ]),
            ),
          ]))
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
    final String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 4)));
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

  Future<List<StepsWeek>?> _requestStepsWeek1() async{
    List<StepsWeek>? result;

    String? access;

    final sp = await SharedPreferences.getInstance();
    access = sp.getString('access');

    //easier to see where the eventual error is
    if (access == null) {
      return [
        StepsWeek(startTime: DateTime.now(), endTime: DateTime.now(), step: 0),
      ];
    }

    if (JwtDecoder.isExpired(access)){
      await _refreshTokens();
      access = sp.getString('access');
    }

    final String startDate = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 8)));
    final String endDate = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 4)));
    final url = Impact.baseUrl + Impact.stepsEndpoint + Impact.patientUsername + '/daterange/start_date/$startDate/end_date/$endDate/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    print('Calling: $url');
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      result = [];
      print(decodedResponse['data'].length);
      print(decodedResponse[0]['date'][0]);
      //spør Roro
      //antall dataset: 5
      //innenfor hvert sett er det mange datoer og verdier
      print('Hello Clara');
      for (var i = 0; i < decodedResponse['data'].length; i++){ //i fra 0 til 4
        String sDate = decodedResponse[0]['date'];
        String eDate = decodedResponse[-1]['date'];
        print(sDate);
        for (var j = 0; j < decodedResponse['data'][i].length; j++){
          //String sDate = decodedResponse['data'][i]['date'];
          //String eDate = decodedResponse['data'][i]['date'];
          //print(decodedResponse['data']['date']);
          Map<String, dynamic> json = decodedResponse['data'][i][j]['data'];
          result.add(StepsWeek.fromJson(sDate, eDate, json));
        }
      }
      //data:
        //date
        //data
          //values
    } else {
      result = null;
    }

    return result;

  }

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
    final String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 6)));
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

