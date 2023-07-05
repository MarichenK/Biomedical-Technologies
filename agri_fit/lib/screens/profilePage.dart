//import 'package:agri_fit/screens/homePage.dart';
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:agri_fit/screens/edit_profile_page.dart';
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
    double weight = 55;

    calculatedBMI = weight/pow(height,2);
    //calculatedBMI = double.parse(editWeight)/pow(double.parse(editHeight),2);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        //title: Text(ProfilePage.routename),
        title: Text('$editName', textScaleFactor: 1.5,),
        foregroundColor: const Color.fromARGB(255, 93, 155, 97),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(Icons.account_box_rounded, size: 120),
            //Container(color: Colors.blue, width: 100, height: 100,),
            Column(mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Text('Name: $editName'),
              Text('Gender: $editGen'),
              Text('Age: $editAge '),
              Text('Height: $editHeight'),
              Text('Weight: $editWeight')
            ],)
          ],
        ),
        Text('BMI: ${checkBMI(calculatedBMI)}'),
        Text('$calculatedBMI'),
        const Text('Indication')
        
        ]
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
            const ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('Log Out'), 
              onTap: () => _toLoginPage(context),
              //Logg ut
            ),
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