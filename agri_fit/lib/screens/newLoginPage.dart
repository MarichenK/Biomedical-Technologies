// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:agri_fit/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:agri_fit/Utilities/Impact.dart';
import 'package:agri_fit/Database/Steps.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_login/flutter_login.dart';

class NewLoginPage extends StatefulWidget{
  const NewLoginPage({Key? key}) : super(key: key);

  static const route = '/newLogin/';
  static const routename = 'NewLoginPage';

  @override
  State<NewLoginPage> createState() => _NewLoginState();
}

class _NewLoginState extends State<NewLoginPage>{
  
  final _textControllerStudentID = TextEditingController();
  final _textControllerName = TextEditingController();

  @override
  void initState() {
    super.initState();
    //check if user is logged in already
    _checkLogin();
  }

  void _checkLogin() async {
    //Get Shared_Preference instance and check value of username ++
    final sp = await SharedPreferences.getInstance();
    if(sp.getString('username') != null){
      _toHomePage(context);
    }
  }

  Future<String> _loginUser(LoginData data) async{
    if(data.name == 'nug@expert.com' && data.password == '5TrNgP5Wd') {
      final sp = await SharedPreferences.getInstance();

      return '';
    } else {
      return 'Wrong credentials';
    }
  }

  Future<String> _signUpUser(SignupData data) async {
    return 'To be implemented';
  }

  Future<String> _recoverPassword(String email) async {
    return 'Recover password needs to be implemented';
  }
 
  @override
  Widget build(BuildContext context){
    return FlutterLogin(
      title: 'Welcome, log in',
      onLogin: _loginUser,
      onSignup: _signUpUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () async{
        _toHomePage(context);
      },
    );
  }

  void _toHomePage(BuildContext context){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }
}