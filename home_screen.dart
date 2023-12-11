import 'package:flutter/material.dart';
import 'package:movie_app/navBar/dashboard.dart';
import 'package:movie_app/navBar/more_screen.dart';
import 'package:movie_app/navBar/watch_screen.dart';
import 'package:movie_app/navBar/media_libraryScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    DashboardScreen(),
    WatchScreen(),
    MediaLibraryScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'DashBoard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_half),
            label: 'Watch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            label: 'Media Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
