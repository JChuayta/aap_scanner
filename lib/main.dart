import 'package:flutter/material.dart';
import 'package:procesos_judiciales/Screens/Home/index.dart';
import 'package:procesos_judiciales/Screens/Login/index.dart';

void main() async{
 // Routes();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expedientes',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginScreen(),
          'home': (BuildContext context) => HomeScreen(),
        },
        theme: ThemeData(primaryColor: Colors.deepPurple[300]),
      ),
    );
  }
}
