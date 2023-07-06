//import 'package:agri_fit/screens/homePage.dart';
// ignore_for_file: file_names

import 'package:agri_fit/screens/loginPage.dart';
import 'package:agri_fit/Utilities/Impact.dart';
import 'package:agri_fit/screens/authenticationIMPACT.dart';
import 'package:flutter/material.dart';
import 'package:agri_fit/screens/editProfilePage.dart';
import 'package:agri_fit/Utilities/bmiCalculator.dart';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
//import 'package:agri_fit/navigationBar.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  //const ProfilePage({Key? key}) : super(key: key);
  String editName;
  String editAge;
  String editGen;
  String editHeight;
  String editWeight;

  dynamic calculatedBMI;

  ProfilePage({required this.editName, required this.editAge, required this.editGen, required this.editHeight, required this.editWeight});

  static const route = '/profile/';
  static const routename = 'Profile';

  @override

  Widget build(BuildContext context) {
    double height = 1.70;
    double weight = 70;

    calculatedBMI = weight/pow(height,2);
    //calculatedBMI = double.parse(editWeight)/pow(double.parse(editHeight),2);

    return Scaffold(
      extendBodyBehindAppBar: true,
      /*appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: const Text(
          'AgriFit', 
          textScaleFactor: 2.4, 
          style: TextStyle(fontWeight: FontWeight.bold)),
        foregroundColor: const Color.fromARGB(255, 27, 179, 141),
      ),*/
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
                
                        Text('$editGen, $editAge years', textScaleFactor: 1.2,),
                    
                        const SizedBox(height: 26),
                
                        Text('Height: $editHeight cm', textScaleFactor: 1.2,),
                        Text('Weight: $editWeight kg', textScaleFactor: 1.2,)
                      ],)
                    ],
                  ),
                    
                  const SizedBox(height: 46),
                    
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
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
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

} //ProfilePage