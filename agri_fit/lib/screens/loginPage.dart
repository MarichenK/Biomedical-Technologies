import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const route = '/login/';
  static const routename = 'LoginPage';

  @override _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage>{

  final _textControllerUserName = TextEditingController();
  final _textControllerPassword = TextEditingController();

  String editUsername = '';
  String editPassword = '';

  @override
  Widget build(BuildContext context) {
    print('${LoginPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(LoginPage.routename),
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
              child: const Text('To the home'))
          ],
      ),)
        //child: ElevatedButton(
          //child: Text('To the home'),
          //onPressed: () {
            //This allows to go back to the HomePage
            //Navigator.pop(context);
          //},
        ,
      );
  } //build

} //ProfilePage