import 'package:buscadordegifs/app/apiConnect/api.dart';
import 'package:buscadordegifs/app/gifPage/myGifPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GiphyApi _giphyApi = GiphyApi();

  Future<Null> _refresh() async {
    setState(() {});
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
                  _giphyApi.search(text);
                });
              },
            ),
            Divider(),
            Expanded(
                child: RefreshIndicator(
              onRefresh: _refresh,
              child: FutureBuilder(
                future: _giphyApi.getData(),
                builder: _buildBody,
              ),
            ))
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
          "Ah não, tivemos um problema!\nVerifique sua conexão com a internet... ",
          style: TextStyle(color: Colors.red, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset("assets/images/connection_failed.gif"),
        ),
        Divider(),
        IconButton(
          icon: Icon(Icons.refresh, color: Colors.white, size: 40),
          onPressed: _refresh,
        )
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
              child: Stack(
                children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5),
                  ),
                  FadeInImage.memoryNetwork(
                    image: snapshot.data["data"][index]["images"]
                        ["fixed_height"]["url"],
                    height: 400,
                    fit: BoxFit.cover,
                    placeholder: kTransparentImage,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MyGifPage(snapshot.data["data"][index]),
                    ));
              },
              onLongPress: () {
                Share.share(
                    snapshot.data["data"][index]["images"]["original"]["url"]);
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
                  _giphyApi.nextGifs();
                });
              },
            );
          }
        });
  }
}
