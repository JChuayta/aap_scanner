import 'package:folding_cell/folding_cell.dart';
import 'package:flutter/material.dart';
import 'package:procesos_judiciales/Model/persona_model.dart';
import 'package:procesos_judiciales/Model/proceso_model.dart';
import 'package:procesos_judiciales/Providers/proceso_provider.dart' as p;
import 'package:procesos_judiciales/Screens/Image/index.dart';

class HomeScreen extends StatefulWidget {
  final Persona persona;
  HomeScreen({Key key, this.persona}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Proceso> proceso_list = new List();

  GlobalKey<SimpleFoldingCellState> _foldingCellKey1 =
      new GlobalKey<SimpleFoldingCellState>();
  GlobalKey<SimpleFoldingCellState> _foldingCellKey2 =
      new GlobalKey<SimpleFoldingCellState>();
  GlobalKey<SimpleFoldingCellState> _foldingCellKey3 =
      new GlobalKey<SimpleFoldingCellState>();
  GlobalKey<SimpleFoldingCellState> _foldingCellKey4 =
      new GlobalKey<SimpleFoldingCellState>();
  GlobalKey<SimpleFoldingCellState> _foldingCellKey5 =
      new GlobalKey<SimpleFoldingCellState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargandoProcesos();
  }

  GlobalKey<SimpleFoldingCellState> _sacarKey(int index) {
    switch (index) {
      case 1:
        {
          return _foldingCellKey1;
        }
        break;
      case 2:
        {
          return _foldingCellKey2;
        }
        break;
      case 3:
        {
          return _foldingCellKey3;
        }
        break;
      case 4:
        {
          return _foldingCellKey4;
        }
        break;
      case 5:
        {
          return _foldingCellKey5;
        }
        break;
    }
    return _foldingCellKey5;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Expedientes'),
        ),
        body: contenido(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.deepPurple[300],
          items: _getItemBottomNavigatorBar(),
//          onTap: ,
        ));
  }

  DecorationImage backgroundImage = new DecorationImage(
    image: new ExactAssetImage('assets/fondo.jpg'),
    fit: BoxFit.cover,
  );
  List<BottomNavigationBarItem> _getItemBottomNavigatorBar() {
    return [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.thumb_up,
          color: Colors.white,
        ),
        title: Text("Populares"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.update, color: Colors.white),
        title: Text("Proximamente"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.star, color: Colors.white),
        title: Text("Mejor valordas"),
      ),
    ];
  }

  Widget contenido() {
    return Container(
      color: Colors.grey[300],
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: proceso_list.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              _simpleFoldingCell(_sacarKey(index), proceso_list[index]),
            ],
          );
        },
      ),
    );
  }

  Widget _simpleFoldingCell(
      GlobalKey<SimpleFoldingCellState> key, Proceso proceso) {
    return Container(
      child: SimpleFoldingCell(
        key: key,
        frontWidget: _frontWidget(key, proceso),
        innerTopWidget: _innerTopWidget(key, proceso),
        innerBottomWidget: _innerBottomWidget(key, proceso),
        cellSize: Size(MediaQuery.of(context).size.width, 150),
        padding: EdgeInsets.all(10.0),
        onClose: () => {},
        onOpen: () => {},
      ),
    );
  }

  Widget _frontWidget(
      GlobalKey<SimpleFoldingCellState> llavesita, Proceso pro) {
    return Container(
      color: Color(0xffdf4f4),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Color(0xff6a53a4),
                ),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      pro.createdAt.toString().substring(0, 10),
                      style: TextStyle(color: Colors.white),
                    ),
                    Divider(
                      height: 10.0,
                    ),
                    Text(
                      pro.createdAt
                          .toString()
                          .substring(11, pro.createdAt.toString().length - 7),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ))),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      pro.tipo.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      'DETALLE',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    onTap: () => llavesita?.currentState?.toggleFold(),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _innerTopWidget(
      GlobalKey<SimpleFoldingCellState> llavesita, Proceso pro) {
    return Container(
        color: Color(0xff6a53a4),
        child: Column(
          children: <Widget>[
            //titulo
            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                "Asunto",
                style: TextStyle(
                  color: Color(0xffF7B928),
                  fontSize: 18.0,
                ),
              ),
            ),
            //descripcion
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.note,
                    color: Color(0xffF7B928),
                  ),
                 Text("  "),
                  Expanded(
                      child: Text(
                    pro.descripcion.toString(),
                    style: TextStyle(color: Colors.white),
                  ),),
                ],
              ),
            ),
            //acusado
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.person,
                    color: Color(0xffF7B928),
                  ),
                  Text(
                    "  Demandante:  ",
                    style: TextStyle(
                      color: Color(0xffF7B928),
                    ),
                  ),
                  Text(
                    pro.detalle[0]['nombre'].toString() +
                        ' ' +
                        pro.detalle[0]['apellido'].toString(),
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            //demandante
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.person,
                    color: Color(0xffF7B928),
                  ),
                  Text(
                    "  Acusado:  ",
                    style: TextStyle(
                      color: Color(0xffF7B928),
                    ),
                  ),
                  Text(
                    pro.detalle[1]['nombre'].toString() +
                        ' ' +
                        pro.detalle[1]['apellido'].toString(),
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            Divider(
              height: 5.0,
            ),
            //boton cerra
            GestureDetector(
              child: Text(
                'Cerrar',
                style: TextStyle(
                  color: Color(0xffF7B928),
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              onTap: () => llavesita?.currentState?.toggleFold(),
            ),
          ],
        ));
  }

  Widget _innerBottomWidget(
      GlobalKey<SimpleFoldingCellState> llave, Proceso p) {
    return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Expedientes",
              style: TextStyle(fontSize: 20.0, color: Colors.deepPurple),
            ),
            Divider(
              height: 20.0,
            ),
            _crearBotones(context),
          ],
        ));
  }

  Widget _crearBotones(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          child: RaisedButton(
            onPressed: () {},
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.picture_as_pdf,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  "  Ver",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            color: Color(0xffF7B928),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        Container(
          child: RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageScreen()));
            },
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  "  Tomar",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            color: Color(0xffF7B928),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ],
    );
  }

  void cargandoProcesos() async {
    var data =
        await p.ProcesoProvider().fetchProcesos(widget.persona.id.toString());
    setState(() {
      proceso_list.addAll(data);
    });
  }
}
