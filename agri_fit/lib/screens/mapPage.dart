import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  static const route = '/map/';
  static const routename = 'Map';

  @override
  Widget build(BuildContext context) {
    print('${MapPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 93, 155, 97),
        title: Text(MapPage.routename),
      ),
    );
  } //build

} //ProfilePage