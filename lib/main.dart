import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news/screens/following_screen.dart';
import 'package:flutter_news/screens/headline_screen.dart';
import 'package:flutter_news/screens/home_screen.dart';
import 'package:flutter_news/screens/news_stand_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark
  ));

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RiNews',
      theme: ThemeData.dark(),
      home: RootApps(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RootApps extends StatefulWidget {
  RootApps({Key key}) : super(key: key);

  @override
  _RootAppsState createState() => _RootAppsState();
}

class _RootAppsState extends State<RootApps> {
  int _selectedIndex = 0;
  List _widgetScreen = [
    HomeScreen(),
    HeadlineScreen(),
    FollowingScreen(),
    NewsStandScreen()
  ];

  void onChangeIndexTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetScreen.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onChangeIndexTab,
        selectedItemColor: Colors.blueAccent,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            title: Text('For you'),
            activeIcon: Icon(Icons.home, color: Colors.blue)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language, color: Colors.grey),
            activeIcon: Icon(Icons.language, color: Colors.blue),
            title: Text('Headlines')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border, color: Colors.grey),
            activeIcon: Icon(Icons.star_border, color: Colors.blue),
            title: Text('Following')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq, color: Colors.grey),
            activeIcon: Icon(Icons.graphic_eq, color: Colors.blue),
            title: Text('Newsstand')
          )
        ],
      ),
    );
  }
}