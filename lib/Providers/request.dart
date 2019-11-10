import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Provider {
  Provider();

  Future<dynamic> getJson(String url) async {
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  Future<List> postData(String url, Map<String, String> form) async {
    http.Response respuesta = await http.post(url, body: form);

    List datos = json.decode(respuesta.body);
    return datos;
  }
}
