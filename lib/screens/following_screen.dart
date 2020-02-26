import 'package:flutter/material.dart';
import 'package:flutter_news/widget/custom_appbar.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Following'),
      body: SingleChildScrollView(
        child: Center(
          child: Text('FollowingScreen')
        ),
      ),
    );
  }
}