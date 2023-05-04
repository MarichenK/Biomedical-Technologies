import 'package:flutter/material.dart';
import 'package:agri_fit/screens/profilePage.dart';
import 'package:agri_fit/screens/loginPage.dart';
import 'package:agri_fit/screens/mapPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routename = 'Homepage';

  @override
  Widget build(BuildContext context) {
    print('${HomePage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(HomePage.routename),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('To the profile'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            ElevatedButton(
              child: Text('To the login'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            ElevatedButton(
              child: Text('To the map'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage()));
              },
            ),
          ],
        ),
      ),
    );
  } //build

} //HomePage