import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:agri_fit/screens/homePage.dart';
import 'package:agri_fit/screens/profilePage.dart';
import 'package:agri_fit/screens/EditProfilePage.dart';
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

  Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
  };

  //IMPORTANT: must incorporate "IndexedStack"
  buildNavigator() {
    return Navigator(
      key: navigatorKeys[_selectedIndex],
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (_) => _buildBody.elementAt(_selectedIndex));
      },
    );
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
            horizontal: 28.0,
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
      body: buildNavigator(),
      //body: IndexedStack(index: _selectedIndex, children: _buildBody)
    );
  }
}