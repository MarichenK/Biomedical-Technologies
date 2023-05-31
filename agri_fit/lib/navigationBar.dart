import 'package:flutter/material.dart';
import 'package:agri_fit/screens/homePage.dart';
import 'package:agri_fit/screens/profilePage.dart';
import 'package:agri_fit/screens/mapPage.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<NavBar> {
  
  int _selectedIndex = 0;
  
  void _navigateBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  
  final _buildBody = <Widget>[
    HomePage(),
    MapPage(),
    ProfilePage(editName: '', editAge: '', editGen: '', editHeight: '', editWeight: '',),
  ];

  /*
  List<Widget> get _pages => [
    HomePage(),
    MapPage(),
    ProfilePage(editName: '', editAge: '', editGen: '', editHeight: '', editWeight: '',),
  ];
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        iconSize: 32,
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        //onTap: navigate(context, FeedDetail.),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ]),
      //body: _pages[_selectedIndex],
      body: IndexedStack(index: _selectedIndex, children: _buildBody)
    );
  }
}