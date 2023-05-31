import 'package:agri_fit/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:agri_fit/screens/EditProfilePage.dart';
import 'package:agri_fit/navigationBar.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  //const ProfilePage({Key? key}) : super(key: key);
  String editName;
  String editAge;
  String editGen;
  String editHeight;
  String editWeight;

  ProfilePage({required this.editName, required this.editAge, required this.editGen, required this.editHeight, required this.editWeight});

  static const route = '/profile/';
  static const routename = 'Profile';

  @override
  Widget build(BuildContext context) {
    print('${ProfilePage.routename} built');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 93, 155, 97),
        title: Text(ProfilePage.routename),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.account_box_rounded, size: 120)
            //Container(color: Colors.blue, width: 100, height: 100,),
            ,Column(mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Text('Name: $editName'),
              Text('Gender: $editGen'),
              Text('Age: $editAge '),
              Text('Height: $editHeight'),
              Text('Weight: $editWeight')
            ],)
          ],
        ),
        Text('BMI'),
        Text('Indicasjon')
        
        ]
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(child: Text('Profile Options')),
            ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: const Text('Edit Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
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
              //Logg ut
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('To Home Page'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                //navigate(context, HomePage.route, isRootNavigator: false);
              },
            )
          ],
        ),
      ),
    );
  } //build

} //ProfilePage