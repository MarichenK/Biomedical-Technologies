import 'package:flutter/material.dart';
import 'package:agri_fit/screens/EditProfilePage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const route = '/profile/';
  static const routename = 'ProfilePage';

  @override
  Widget build(BuildContext context) {
    print('${ProfilePage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(ProfilePage.routename),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('To the home'),
          onPressed: () {
            //This allows to go back to the HomePage
            Navigator.pop(context);
          },
        ),
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
            ListTile(
              leading: Icon(Icons.delete_forever),
              title: const Text('Delete Account'),
              //Slett bruker
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: const Text('Log Out'), 
              //Logg ut
            )
          ],
        ),
      ),
    );
  } //build

} //ProfilePage