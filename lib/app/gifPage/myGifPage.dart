import 'package:flutter/material.dart';
import 'package:share/share.dart';

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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: () {
              Share.share(_gifData["images"]["original"]["url"]);
            },
          )
        ],
      ),
      body: Center(child: Image.network(_gifData["images"]["original"]["url"]))
    );
  }
}
