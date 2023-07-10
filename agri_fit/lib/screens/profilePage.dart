//import 'package:agri_fit/screens/homePage.dart';
// ignore_for_file: file_names

import 'package:agri_fit/screens/loginPage.dart';

import 'package:agri_fit/screens/authenticationIMPACT.dart';
import 'package:flutter/material.dart';
import 'package:agri_fit/screens/editProfilePage.dart';
import 'package:agri_fit/Utilities/bmiCalculator.dart';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import '../Database/DatabaseRepository.dart';
import '../Database/database.dart';
//import 'package:agri_fit/navigationBar.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  static const route = '/profile/';
  static const routename = 'Profile';

  @override
  State<ProfilePage> createState() => ProfilePageState();
} //ProfilePage

class ProfilePageState extends State<ProfilePage> {
  //const ProfilePage({Key? key}) : super(key: key);

  late final DatabaseRepository repository;
  double calculatedBMI = 0;
  String editName = '';
  String editAge = '';
  String editGen = '';
  String editHeight = '';
  String editWeight = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    $FloorAppDatabase.databaseBuilder("app_database").build().then((value) async {
      repository = DatabaseRepository(database: value);
      final sp = await SharedPreferences.getInstance();
      final username = sp.getString("username");

      if (username == null) return;
      final todo = await repository.findTodoById(username);
      if (todo == null) return;

      setState(() {
        editAge = todo.age.toString();
        editGen = todo.gender.toString();
        editHeight = todo.height.toString();
        editWeight = todo.weight.toString();

        if (todo.weight != null && todo.height != null) {
          calculatedBMI = todo.weight! / pow(todo.height!, 2);
        }
      });

    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('AgriFit', textScaleFactor: 2.4,),
        foregroundColor: Colors.black,
      ),
      
      body: Container(decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 250, 250, 250),
                Color.fromARGB(255, 27, 179, 141),
              ]
            )
          ),
        
        // box with profile info
        child: Column(
          children: [
            const SizedBox(height: 150),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Container(
                height: 540,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color.fromARGB(255, 250, 250, 250)),
                
                // profile info
                child: Column(
                  children: [
                    const SizedBox(height: 36),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.account_circle_rounded, size: 180),
                      Column(
                      children: [
                        Text(
                          editName,
                          textScaleFactor: 2.2,
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                
                        Text('${editGen}, ${editAge} years', textScaleFactor: 1.2,),
                    
                        const SizedBox(height: 26),
                
                        Text('Height: ${editHeight} cm', textScaleFactor: 1.2,),
                        Text('Weight: ${editWeight} kg', textScaleFactor: 1.2,)
                      ],)
                    ],
                  ),
                    
                  const SizedBox(height: 46),
                  
                  // display BMI value
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 50),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('BMI',
                              textScaleFactor: 2,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    
                      const SizedBox(width: 30),
                    
                      Center(child: Text(calculatedBMI.toStringAsFixed(2),
                              textScaleFactor: 2.5,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color:Color.fromARGB(255, 27, 179, 141))
                          ),
                        ),
                    ],
                  ),
                    
                  const SizedBox(height: 26),
                  
                  // display BMI status
                  const Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Health status',
                          textScaleFactor: 2,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                    
                  const SizedBox(height: 12),
                  
                  Container( 
                    height: 90,
                    width: 290,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 27, 179, 141)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text(checkBMI(calculatedBMI),
                          textScaleFactor: 2.5,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white)
                            ),
                            ),
                      ],
                    ),
                  ),
                    
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        shadowColor: Colors.white.withOpacity(0),

        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(child: Text('Profile Options')),
            ListTile(
              leading: const Icon(Icons.account_circle_rounded),
              title: const Text('Edit Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage()));
              },
            ),
            const ListTile(
              leading: Icon(Icons.delete_forever),
              title: Text('Delete Account'),
              //Slett bruker
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('Log Out'), 
              onTap: () async {
                final sp = await SharedPreferences.getInstance();
                sp.remove("username");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            ListTile(
              title: Text('IMPACT'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AuthImpact()));
              },
            )
          ],
        ),
      ),
    );
  } //build

  void _toLoginPage(BuildContext context) async{
    final sp = await SharedPreferences.getInstance();
    sp.remove('username');
  }
}