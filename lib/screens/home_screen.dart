import 'package:flutter/material.dart';
import 'package:flutter_news/widget/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('News'),
      body: SingleChildScrollView(
        child: Center(
          child: Text('HomeScreen')
        ),
      ),
    );
  }
}