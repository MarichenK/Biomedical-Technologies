import 'package:flutter/material.dart';
//import 'package:agri_fit/screens/profilePage.dart';

class EditProfilePage extends StatelessWidget{
  const EditProfilePage({Key? key}) : super(key: key);

  static const route = '/editprofile/';
  static const routename = 'EditProfilePage';

  @override
  Widget build(BuildContext context){
    print('${EditProfilePage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {Navigator.pop(context);}, 
              child: const Text('Finish Editing'))
          ],),),
    );
  }

}