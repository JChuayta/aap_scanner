import 'dart:io';

import 'package:flutter/material.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import 'package:procesos_judiciales/Model/imagen_model.dart';
import 'package:procesos_judiciales/Providers/proceso_provider.dart' as proceso;
import 'package:procesos_judiciales/global.dart';

class ImageScreen extends StatefulWidget {
  final int idProceso;
  ImageScreen({Key key, this.idProceso}) : super(key: key);
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  List<File> photos_list =
      new List(); // Lista imagenes sacadas con edge_detection
  List<String> url_image =
      new List(); //Lista de url de las imagenes que se subieron al repositorio en la nube
  List<Imagen> url_image_expediente =
      new List(); //Lista de url de las imagenes que pertenecen al proceso sacadas de la base de datos
  String imagePath = "";
  String fecha = "";
  void loadExpedientes() async {
    var images = await proceso.ProcesoProvider().fetchImages(widget.idProceso);
    setState(() {
      url_image_expediente.addAll(images);
    });
  }

  alerta(String value) {
    _guardarImage();
    // aqui guardare las imagenes que se encuentran en la lista y obtendre sus url
    AlertDialog dialog = new AlertDialog(
      content: Text(value,
          style: TextStyle(
            fontSize: 16.0,
            color: Theme.of(context).primaryColor,
          )),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              _addExpediente();
              Navigator.of(context).pop();
            },
            child: Text("SI")),
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("NO")),
      ],
    );
    showDialog(context: context, child: dialog);
  }

  _addExpediente() async {
    for (var imagen in url_image) {
      await proceso.ProcesoProvider()
          .subirExpediente(widget.idProceso, fecha, NOMBRE, imagen);
    }
  }

  _fechaActual() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    setState(() {
      fecha = formattedDate;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fechaActual();
    loadExpedientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Fotografias"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: () {
              photos_list.isNotEmpty
                  ? alerta("¿ esta seguro de guardar los datos ?")
                  : Toast.show("No se realizo ningun cambio", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            },
          )
        ],
      ),
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('assets/fondo_azul_oscuro.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: url_image_expediente.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Image.network(
                    url_image_expediente[index].imagen,
                    height: 500.0,
                    width: 400.0,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _edge();
        },
        child: Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _edge() async {
    var cade = await EdgeDetection.detectEdge;
    File _image = new File(cade);
    setState(() {
      photos_list.add(_image);
    });
  }

  _guardarImage() async {
    for (var ruta in photos_list) {
      String url = await proceso.ProcesoProvider().subirImagen(ruta);
      setState(() {
        url_image.add(url);
      });
    }
    photos_list.clear();
  }
}
