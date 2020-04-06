import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

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
      body: Stack(
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 5),
          ),
          Center(
              child: FadeInImage.memoryNetwork(
            image: _gifData["images"]["original"]["url"],
            height: 400,
            fit: BoxFit.cover,
            placeholder: kTransparentImage,
          ))
        ],
      ),
    );
  }
}
