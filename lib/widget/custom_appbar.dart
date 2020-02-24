import 'package:flutter/material.dart';

AppBar customAppBar(String title) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 20.0
      )
    ),
    centerTitle: false,
    backgroundColor: Colors.white,
    elevation: 0.0,
  );
}
