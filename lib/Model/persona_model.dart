import 'dart:convert';

Persona personaFromJson(String str) => Persona.fromJson(json.decode(str));

String personaToJson(Persona data) => json.encode(data.toJson());

class Persona {
    int id;
    int ci;
    String nombre;
    String apellido;
    String sexo;
    int telefono;
    String cargo;
    String email;
    String profesion;
    bool condicion;

    Persona({
        this.id,
        this.ci,
        this.nombre,
        this.apellido,
        this.sexo,
        this.telefono,
        this.cargo,
        this.email,
        this.profesion,
        this.condicion,
    });

    factory Persona.fromJson(Map json) => Persona(
        id: json["id"],
        ci: json["ci"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        sexo: json["sexo"],
        telefono: json["telefono"],
        cargo: json["cargo"],
        email: json["email"],
        profesion: json["profesion"],
        condicion: json["condicion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ci": ci,
        "nombre": nombre,
        "apellido": apellido,
        "sexo": sexo,
        "telefono": telefono,
        "cargo": cargo,
        "email": email,
        "profesion": profesion,
        "condicion": condicion,
    };
}
