import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _search = "";
  int _offset = 0;

  Future<Map> _getGifs() async {
    http.Response response;
    if(_search.isEmpty) {
      response = await http.get("https://api.giphy.com/v1/gifs/trending?api_key=MHNHi4nQy2AEQfeW23BVysMSNRBzecCj&limit=20&rating=G");
    } else {
      response = await http.get("https://api.giphy.com/v1/gifs/search?api_key=MHNHi4nQy2AEQfeW23BVysMSNRBzecCj&q=$_search&limit=20&offset=$_offset&rating=G&lang=pt");
    }
    return json.decode(response.body);
  }


  @override
  void initState() {
    super.initState();
    _getGifs().then((data) {
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/appBar.gif"),
        //title: Image.network("https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"), // (get by net)
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
    );
  }
}