// To parse this JSON data, do
//
//     final detalle = detalleFromJson(jsonString);

import 'dart:convert';

Detalle detalleFromJson(String str) => Detalle.fromJson(json.decode(str));

String detalleToJson(Detalle data) => json.encode(data.toJson());

class Detalle {
    String nombre;
    String apellido;
    String descripcion;

    Detalle({
        this.nombre,
        this.apellido,
        this.descripcion,
    });

    factory Detalle.fromJson(Map<String, dynamic> json) => Detalle(
        nombre: json["nombre"],
        apellido: json["apellido"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellido": apellido,
        "descripcion": descripcion,
    };
}
