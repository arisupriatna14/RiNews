import 'package:flutter/material.dart';
import 'package:flutter_news/screens/home_screen.dart';
import 'package:flutter_news/screens/search_screen.dart';
import 'package:flutter_news/screens/setting_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RootApps(),
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
    SearchScreen(),
    SettingScreen()
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings')
          )
        ],
      ),
    );
  }
}