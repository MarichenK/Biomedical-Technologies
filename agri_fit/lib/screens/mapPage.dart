import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  static const route = '/map/';
  static const routename = 'MapPage';

  @override
  Widget build(BuildContext context) {
    print('${MapPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(MapPage.routename),
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
    );
  } //build

} //ProfilePage