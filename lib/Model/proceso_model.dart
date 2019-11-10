import 'dart:convert';

import 'package:procesos_judiciales/Model/detalle_model.dart';

Proceso procesoFromJson(String str) => Proceso.fromJson(json.decode(str));

String procesoToJson(Proceso data) => json.encode(data.toJson());

class Proceso {
    String tipo;
    dynamic documento;
    String descripcion;
    bool condicion;
    DateTime createdAt;
    List<dynamic> detalle;

    Proceso({
        this.tipo,
        this.documento,
        this.descripcion,
        this.condicion,
        this.createdAt,
        this.detalle,
    });

    factory Proceso.fromJson(Map json) => Proceso(
        tipo: json["tipo"],
        documento: json["documento"],
        descripcion: json["descripcion"],
        condicion: json["condicion"],
        createdAt: DateTime.parse(json["created_at"]),
        detalle : json["nombres"].toList()    
    );

    Map<String, dynamic> toJson() => {
        "tipo": tipo,
        "documento": documento,
        "descripcion": descripcion,
        "condicion": condicion,
        "created_at": createdAt.toIso8601String(),
        "detalle":detalle,
    };
}
