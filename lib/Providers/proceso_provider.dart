import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:procesos_judiciales/Model/proceso_model.dart';
import 'package:procesos_judiciales/Model/imagen_model.dart';
import 'package:procesos_judiciales/global.dart';
import 'package:procesos_judiciales/Providers/request.dart' as r;

class ProcesoProvider {
// esta clase tendra como objetivo el envio ey recibo de datos hacia nuestra api en el ambito del procesos judicial
// u el exediente
  final String _url = API_URL + '/proceso?';
  final String _urlExpediente = API_URL + '/expediente?';
  final String _urlFotos = API_URL + '/fotos?';

  Future<List<Proceso>> fetchProcesos(String id) async {
    String ruta = _url + "id=" + id;

    return await r.Provider().getJson(ruta).then(((data) =>
        data['data'].map<Proceso>((pro) => Proceso.fromJson(pro)).toList()));
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dwq72cog2/image/upload?upload_preset=lkpbycp7');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);

    return respData['secure_url'];
  }

  Future<void> subirExpediente(
      int idProceso, String fecha, String procurador, String imagen) async {
    String ruta = _urlExpediente +
        "id_proceso=" +
        idProceso.toString() +
        "&" +
        "fecha=" +
        fecha +
        "&" +
        "procurador=" +
        procurador +
        "&" +
        "imagen=" +
        imagen;

    return await r.Provider().getJson(ruta);
  }

  Future<List<Imagen>> fetchImages(int id) async {
    print(id);
    String ruta = _urlFotos + "id=" + id.toString();

    return await r.Provider().getJson(ruta).then(((data) =>
        data['imagenes'].map<Imagen>((img) => Imagen.fromJson(img)).toList()));
  }
}
