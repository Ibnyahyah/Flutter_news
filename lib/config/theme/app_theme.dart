import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    // fontFamily: '',
    appBarTheme: appBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(
      color: Color.fromARGB(255, 65, 63, 63),
    ),
    titleTextStyle:
        TextStyle(color: Color.fromARGB(255, 61, 60, 60), fontSize: 18),
  );
}
