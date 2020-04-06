import 'package:flutter/material.dart';

class MyGifPage extends StatelessWidget {
  final _gifData;

  MyGifPage(this._gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(_gifData["title"]),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(child: Image.network(_gifData["images"]["fixed_height"]["url"]))
    );
  }
}
