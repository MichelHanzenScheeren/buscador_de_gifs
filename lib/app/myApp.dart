import 'package:flutter/material.dart';
import 'package:buscadordegifs/app/homePage/HomePage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Buscador de GIFS",
      home: MyHomePage(),
      theme: ThemeData(
        hintColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        ),
      ),
    );
  }
}
