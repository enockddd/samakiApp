import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/PostCreationScreen.dart';
import '../screens/ProfileScreenCurrentUserClass.dart';
import '../screens/search/searchScreen.dart';
import '../screens/tabs/HomeClass.dart';
import '../screens/tabs/videoHomeclass.dart';

class SamakiHomeScreen extends StatefulWidget {
  @override
  _SamakiHomeScreenState createState() => _SamakiHomeScreenState();
}

class _SamakiHomeScreenState extends State<SamakiHomeScreen> {
  int _selectedIndex = 0;
  String? image;
  String? _username;
  String? _userId;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      image = prefs.getString('image');
      _username = prefs.getString('username');
      _userId = prefs.getString('userId');
      _email = prefs.getString('email');
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = [
      HomeFeed(image: image, username: _username,email: _email),
      searchClass(),
      PostCreationScreen(),
      Text('Activity/Notifications'),
      ProfileScreenCurrentUser(userId:_userId,image: image,username: _username,email: _email),
    ];

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Samaki'),
          backgroundColor: Colors.deepPurple,
          bottom: _selectedIndex == 0
              ? TabBar(
                  tabs: [
                    Tab(text: 'All'),
                    Tab(text: 'News'),
                    Tab(text: 'Images'),
                    Tab(text: 'Videos'),
                  ],
                )
              : null,
        ),
        body: _selectedIndex == 0
            ? TabBarView(
                children: [
                  HomeFeed(image: image, username: _username),
                  HomeFeed(image: image, username: _username),
                  HomeFeed(image: image, username: _username),
                  VideoHomeFeed(image: image, username: _username),
                ],
              )
            : _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Post'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Activity'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
