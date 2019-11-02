import 'package:flutter/material.dart';
import 'package:edge_detection/edge_detection.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String ruta = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text("esta es laa ruta" + ruta),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _edge();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  _edge() async {
    String cade = await EdgeDetection.detectEdge;
    setState(() {
      ruta = cade;
    });
  }
}
