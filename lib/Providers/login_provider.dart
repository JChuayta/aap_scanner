import 'dart:async';
import 'package:procesos_judiciales/Model/persona_model.dart';
import 'package:procesos_judiciales/global.dart';
import 'package:procesos_judiciales/Providers/request.dart' as r;

class LoginProvider {
  //esta clase la cree para hacer los metodos de login, el registro de usuario y tambien la recuperacion de contraseña

  final String _url = API_URL + '/login?';

  Future<List<Persona>> autenticando(String email, String pass) async {
    String ruta = _url + "email=" + email + "&" + "pass=" + pass;
    
    return await r.Provider().getJson(ruta).then(((data) =>
        data['data'].map<Persona>((item) => Persona.fromJson(item)).toList()));
  }
}
