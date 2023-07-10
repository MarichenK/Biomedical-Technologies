// ignore_for_file: file_names



import 'package:agri_fit/Database/DatabaseRepository.dart';
import 'package:agri_fit/Database/database.dart';
import 'package:agri_fit/navigationBar.dart';
import 'package:agri_fit/screens/editProfilePage.dart';
import 'package:agri_fit/screens/homePage.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_login/flutter_login.dart';
import 'package:agri_fit/Database/Todo.dart';


class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  static const route = '/newLogin/';
  static const routename = 'NewLoginPage';

  @override
  State<LoginPage> createState() => _NewLoginState();
}

class _NewLoginState extends State<LoginPage>{
  late final DatabaseRepository repository;
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  

  @override
  void initState() {
    super.initState();

      //check if user is logged in already
      _checkLogin();

      print("Hållo");

    $FloorAppDatabase.databaseBuilder("app_database").build().then((value) {
      repository = DatabaseRepository(database: value);

    });
  }

  void _checkLogin() async {
    //Get Shared_Preference instance and check value of username ++
    final sp = await SharedPreferences.getInstance();
    if(sp.getString('username') != null){
      _toHomePage(context);
    }
  }

  Future<String> _loginUser(LoginData data) async{
    //need to check if user is in database
    var user = await repository.findTodoById(data.name);

    if(user != null && user.password == data.password) {
      final sp = await SharedPreferences.getInstance();
      sp.setString("username", user.username);
      return '';
    } else {
      return 'Wrong credentials';
    }

  }

  Future<String> _signUpUser(SignupData data) async {
    if (data.name == null) {
      return "No username! 😱";
    }

    var user = await repository.findTodoById(data.name!);

    if (user != null) {
      return "User already exists! 😱";
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(username: data.name, password: data.password))
    );

    final sp = await SharedPreferences.getInstance();
    final todo = Todo(
      sp.getString("pp_username") ?? "",
      sp.getString("pp_password") ?? "",
      sp.getInt("pp_height") ?? 0,
      sp.getInt("pp_age") ?? 0,
      sp.getInt("pp_weight") ?? 0,
      sp.getString("pp_gen") ?? "",
    );

    await repository.insertTodo(todo);

    sp.setString("username", data.name!);
    sp.setString("password", data.password!);

    return "Success!";
  }

  Future<String> _recoverPassword(String email) async {
    return 'Recover password needs to be implemented';
  }
 
  @override
  Widget build(BuildContext context){
    return FlutterLogin(
      title: 'AgriFit',
      userType: LoginUserType.name,
      onLogin: _loginUser,
      onSignup: _signUpUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () async{
        Navigator.push(context, MaterialPageRoute(builder: (context) => const NavBar()));
      },
      messages: LoginMessages(
        userHint: 'Username',
        recoverPasswordDescription: 'Password recovery instructions will be sent to the email associated with this account',
      ),

      theme: LoginTheme(
        pageColorDark: const Color.fromARGB(255, 27, 179, 141),
        pageColorLight: Colors.grey[50],
        primaryColor: const Color.fromARGB(255, 27, 179, 141),

        cardTheme: CardTheme(
          elevation: 0,
          margin: const EdgeInsets.only(top: 12),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
        ),

        buttonTheme: const LoginButtonTheme(
          elevation: 0,
        ),

        inputTheme: InputDecorationTheme(
          fillColor: Colors.grey.shade200,
          filled: true,
        ),

        

      ),
    );
  }

  void _toHomePage(BuildContext context){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }
}