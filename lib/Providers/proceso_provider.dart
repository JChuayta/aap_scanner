import 'dart:async';
import 'package:procesos_judiciales/Model/proceso_model.dart';
import 'package:procesos_judiciales/global.dart';
import 'package:procesos_judiciales/Providers/request.dart' as r;

class ProcesoProvider {
  //esta clase la cree para hacer los metodos de login, el registro de usuario y tambien la recuperacion de contraseña

  final String _url = API_URL + '/proceso?';

  Future<List<Proceso>> fetchProcesos(String id) async {
    String ruta = _url + "id=" + id;

    return await r.Provider().getJson(ruta).then(((data) =>
        data['data'].map<Proceso>((pro) => Proceso.fromJson(pro)).toList()));
  }
}
