import 'package:flutter/material.dart';
import 'package:flutter_news/widget/custom_appbar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Search'),
      body: SingleChildScrollView(
        child: Center(
          child: Text('SearchScreen')
        ),
      ),
    );
  }
}