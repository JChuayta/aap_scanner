import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';

import 'package:procesos_judiciales/Model/imagen_model.dart';
import 'package:procesos_judiciales/Providers/proceso_provider.dart' as proceso;

class PdfScreen extends StatefulWidget {
  final int idProceso;
  PdfScreen({Key key, this.idProceso}) : super(key: key);
  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  List<Imagen> url_image_expediente = new List();
  String pdfStorage;
  
  Future<void> generateExampleDocument() async {
    var htmlContent = """
    <!DOCTYPE html>
    <html>
    <head>
        <style>
        table, th, td {
          border: 1px solid black;
          border-collapse: collapse;
        }
        th, td, p {
          padding: 5px;
          text-align: left;
        }
        </style>
      </head>
      <body>
        <h2>PDF Generated with flutter_html_to_pdf plugin</h2>

        <table style="width:100%">
          <caption>Sample HTML Table</caption>
          <tr>
            <th>Month</th>
            <th>Savings</th>
          </tr>
          <tr>
            <td>January</td>
            <td>100</td>
          </tr>
          <tr>
            <td>February</td>
            <td>50</td>
          </tr>
        </table>

        <p>Image loaded from web</p>
        <img src="https://i.imgur.com/wxaJsXF.png" alt="web-img">
      </body>
    </html>
    """;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    var targetPath = appDocDir.path;
    var targetFileName = "example-pdf";

    var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        htmlContent, targetPath, targetFileName);
    generatedPdfFilePath = generatedPdfFile.path;
  }
  /*_crearPdf() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    var targetPath = appDocDir.path;
    var targetFileName = "example-pdf";
  }
*/
  void loadExpedientes() async {
    var images = await proceso.ProcesoProvider().fetchImages(widget.idProceso);
    setState(() {
      url_image_expediente.addAll(images);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadExpedientes();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
