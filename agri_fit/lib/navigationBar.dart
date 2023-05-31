import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 15.0),
            
            child: GNav(
              gap: 9,
              color: Colors.grey,
              activeColor: Colors.black,
              tabBackgroundColor: Colors.grey.shade200,
              padding: EdgeInsets.all(16),
              iconSize: 32,
              
              
              tabs: const [
                GButton(icon: Icons.home, text: 'Home'),
                GButton(icon: Icons.map, text: 'Map'),
                GButton(icon: Icons.person, text: 'Profile')
              ],
      
            selectedIndex: _selectedIndex,
            onTabChange: _navigateBottomBar,
      
            ),
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: _buildBody)
    );
  }
}

  /*
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
*/