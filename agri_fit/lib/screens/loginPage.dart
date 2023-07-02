// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:agri_fit/Utilities/Impact.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const route = '/login/';
  static const routename = 'LoginPage';

  @override 
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage>{

  final _textControllerUserName = TextEditingController();
  final _textControllerPassword = TextEditingController();

  String editUsername = '';
  String editPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LoginPage.routename),
      ),
      body: Padding(padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textControllerUserName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username'),
            ),
            TextField(
              controller: _textControllerPassword,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text('To the home')),
            ElevatedButton(
                onPressed: () async {
                  final result = await _isImpactUp();
                  final message = result
                      ? 'IMPACT backend is up!'
                      : 'IMPACT backend is down!';
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(message)));
                },
                child: const Text('Ping IMPACT')),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              //må her få til å verifisere bruker
                onPressed: () async {
                  final result = await _getAndStoreTokens();
                  final message =
                      result == 200 ? 'Request successful' : 'Request failed';
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(message)));
                },
                child: const Text('Get tokens')),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  final sp = await SharedPreferences.getInstance();
                  final access = sp.getString('access');
                  final refresh = sp.getString('refresh');
                  final message = access == null
                      ? 'No stored tokens'
                      : 'access: $access; refresh: $refresh';
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(message)));
                },
                child: const Text('Print tokens')),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  final sp = await SharedPreferences.getInstance();
                  final refresh = sp.getString('refresh');
                  final String message;
                  if (refresh == null) {
                    message = 'No stored tokens';
                  } else {
                    final result = await _refreshTokens();
                    message =
                        result == 200 ? 'Request successful' : 'Request failed';
                  } //if-else
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(message)));
                },
                child:const  Text('Refresh tokens')),
            const SizedBox(
              height: 10,
            ),
             ElevatedButton(
                onPressed: () async {
                  final sp = await SharedPreferences.getInstance();
                  await sp.remove('access');
                  await sp.remove('refresh');
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                        const SnackBar(content: Text('Tokens have been deleted')));
                },
                child: const Text('Delete tokens')),
          ],
      ),),
      );
  } //build

  void setUsername() {
    setState(() {
      Impact.username = _textControllerUserName.text;
    });
  }

  void setPassword() {
    setState(() {
      Impact.password = _textControllerPassword.text;
    });
  }

  //This method allows to check if the IMPACT backend is up
  Future<bool> _isImpactUp() async {

    //Create the request
    final url = Impact.baseUrl + Impact.pingEndpoint;

    //Get the response
    print('Calling: $url');
    final response = await http.get(Uri.parse(url));

    //Just return if the status code is OK
    return response.statusCode == 200;
  } //_isImpactUp

  //This method allows to obtain the JWT token pair from IMPACT and store it in SharedPreferences
  Future<int> _getAndStoreTokens() async {

    //Create the request
    final url = Impact.baseUrl + Impact.tokenEndpoint;
    final body = {'username': Impact.username, 'password': Impact.password};

    //Get the response
    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body);

    //If response is OK, decode it and store the tokens. Otherwise do nothing.
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      await sp.setString('access', decodedResponse['access']);
      await sp.setString('refresh', decodedResponse['refresh']);
    } //if

    //Just return the status code
    return response.statusCode;
  } //_getAndStoreTokens

  //This method allows to refrsh the stored JWT in SharedPreferences
  Future<int> _refreshTokens() async {

    //Create the request 
    final url = Impact.baseUrl + Impact.refreshEndpoint;
    final sp = await SharedPreferences.getInstance();
    final refresh = sp.getString('refresh');
    final body = {'refresh': refresh};

    //Get the response
    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body);

    //If the response is OK, set the tokens in SharedPreferences to the new values
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      await sp.setString('access', decodedResponse['access']);
      await sp.setString('refresh', decodedResponse['refresh']);
    } //if

    //Just return the status code
    return response.statusCode;
    
  } //_refreshTokens

} //LoginPage

