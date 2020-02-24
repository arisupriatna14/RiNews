import 'package:flutter/material.dart';
import 'package:flutter_news/widget/custom_appbar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Setting'),
      body: SingleChildScrollView(
        child: Center(
          child: Text('SettingScreen')
        ),
      ),
    );
  }
}