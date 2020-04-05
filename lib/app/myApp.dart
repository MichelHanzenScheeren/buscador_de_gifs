import 'package:flutter/material.dart';
import 'package:buscadordegifs/app/homePage/HomePage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Buscador de GIFS",
      home: MyHomePage(),
    );
  }
}