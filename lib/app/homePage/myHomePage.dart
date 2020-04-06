import 'package:buscadordegifs/app/gifPage/myGifPage.dart';
import 'package:flutter/cupertino.dart';
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
    if (_search.isEmpty) {
      response = await http.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=MHNHi4nQy2AEQfeW23BVysMSNRBzecCj&limit=19&offset=$_offset&rating=G");
    } else {
      response = await http.get(
          "https://api.giphy.com/v1/gifs/search?api_key=MHNHi4nQy2AEQfeW23BVysMSNRBzecCj&q=$_search&limit=19&offset=$_offset&rating=G&lang=pt");
    }
    return json.decode(response.body);
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
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  labelText: "Pesquisar:",
                  labelStyle: TextStyle(color: Colors.white, fontSize: 15),
                  border: OutlineInputBorder()),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              onSubmitted: (text) {
                setState(() {
                  _offset = 0;
                  _search = text;
                });
              },
            ),
            Divider(),
            Expanded(
              child: FutureBuilder(
                future: _getGifs(),
                builder: _buildBody,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
      case ConnectionState.none:
        return _buildWaitingBody();
        break;
      default:
        if (snapshot.hasError) {
          return _errorBody();
        } else {
          return _createGifTable(context, snapshot);
        }
        break;
    }
  }

  Widget _buildWaitingBody() {
    return Container(
      alignment: Alignment.center,
      width: 250,
      height: 250,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 5,
      ),
    );
  }

  Widget _errorBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Oh, we had a problem!\nCheck your internet and try again... ",
          style: TextStyle(color: Colors.red, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        Divider(),
        Icon(Icons.error_outline, color: Colors.red, size: 80),
      ],
    );
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: snapshot.data["data"].length + 1,
        itemBuilder: (context, index) {
          if (index < snapshot.data["data"].length) {
            return GestureDetector(
              child: Image.network(
                  snapshot.data["data"][index]["images"]["fixed_height"]["url"],
                  height: 400,
                  fit: BoxFit.cover),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => MyGifPage(snapshot.data["data"][index]),
                    ));
              },
            );
          } else {
            return GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.navigate_next, color: Colors.white, size: 80),
                  Text("Next", style: TextStyle(color: Colors.white))
                ],
              ),
              onTap: () {
                setState(() {
                  _offset += 19;
                });
              },
            );
          }
        });
  }
}
