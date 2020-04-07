import 'dart:convert';
import 'package:http/http.dart' as http;

class GiphyApi {
  String _search = "";
  int _offset = 0;

  Future<Map> getData() async {
    http.Response response;
    if (_search.isNotEmpty) {
      response = await http.get(
          "https://api.giphy.com/v1/gifs/search?api_key=MHNHi4nQy2AEQfeW23BVysMSNRBzecCj&q=$_search&limit=19&offset=$_offset&rating=G&lang=pt");
    } else {
      response = await http.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=MHNHi4nQy2AEQfeW23BVysMSNRBzecCj&limit=19&offset=$_offset&rating=G");
    }
    return json.decode(response.body);
  }

  Future<Map> search(String search) async {
    _search = search;
    _offset = 0;
    return await getData();
  }

  void nextGifs() {
    _offset += 19;
  }
}
