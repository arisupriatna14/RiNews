import 'package:flutter/material.dart';
import 'package:flutter_news/screens/search_screen.dart';
import 'package:flutter_news/utils/font.dart';
import 'package:flutter_news/widget/custom_route.dart';

AppBar customAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontSize.semiBold,
        fontFamily: Fonts.Raleway
      )
    ),
    elevation: 0.0,
    actions: <Widget>[
      Container(
        margin: EdgeInsets.only(right: 8.0),
        child: IconButton(
          icon: Icon(Icons.search, size: 30.0),
          onPressed: () => Navigator.push(
            context,
            customRoutes(routes: SearchScreen())
          )
        ),
      )
    ],
    leading: IconButton(
      icon: Icon(Icons.account_circle, size: 30.0),
      onPressed: () {}
    ),
    centerTitle: true,
  );
}
