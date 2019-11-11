
class Imagen {
  String imagen;

  Imagen({
    this.imagen,
  });

  factory Imagen.fromJson(Map json) => Imagen(
        imagen: json["imagen"],
      );
}
