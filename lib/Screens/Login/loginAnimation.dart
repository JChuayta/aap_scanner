import 'package:flutter/material.dart';
import 'package:procesos_judiciales/Model/persona_model.dart';
import 'package:procesos_judiciales/Providers/login_provider.dart' as login;
import 'package:procesos_judiciales/Screens/Home/index.dart';
import 'dart:async';

import 'package:procesos_judiciales/argumentos.dart';

class StaggerAnimation extends StatefulWidget {
  StaggerAnimation({Key key, this.buttonController})
      : buttonSqueezeanimation = new Tween(
          begin: 320.0,
          end: 70.0,
        ).animate(
          new CurvedAnimation(
            parent: buttonController,
            curve: new Interval(
              0.0,
              0.150,
            ),
          ),
        ),
        buttomZoomOut = new Tween(
          begin: 70.0,
          end: 1000.0,
        ).animate(
          new CurvedAnimation(
            parent: buttonController,
            curve: new Interval(
              0.550,
              0.999,
              curve: Curves.bounceOut,
            ),
          ),
        ),
        containerCircleAnimation = new EdgeInsetsTween(
          begin: const EdgeInsets.only(bottom: 50.0),
          end: const EdgeInsets.only(bottom: 0.0),
        ).animate(
          new CurvedAnimation(
            parent: buttonController,
            curve: new Interval(
              0.500,
              0.800,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final AnimationController buttonController;
  final Animation<EdgeInsets> containerCircleAnimation;
  final Animation buttonSqueezeanimation;
  final Animation buttomZoomOut;

  @override
  _StaggerAnimationState createState() => _StaggerAnimationState();
}

class _StaggerAnimationState extends State<StaggerAnimation> {
  
  List<Persona> persona = new List();
  String cadena;
  Persona person = new Persona();
  
  Future<Null> _playAnimation() async {
    try {
      await widget.buttonController.forward();
      await widget.buttonController.reverse();
    } on TickerCanceled {}
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return new Padding(
      padding: widget.buttomZoomOut.value == 70
          ? const EdgeInsets.only(bottom: 50.0)
          : widget.containerCircleAnimation.value,
      child: new InkWell(
          onTap: () {
            _playAnimation();
          },
          child: new Hero(
            tag: "fade",
            child: widget.buttomZoomOut.value <= 300
                ? new Container(
                    width: widget.buttomZoomOut.value == 70
                        ? widget.buttonSqueezeanimation.value
                        : widget.buttomZoomOut.value,
                    height: widget.buttomZoomOut.value == 70
                        ? 60.0
                        : widget.buttomZoomOut.value,
                    alignment: FractionalOffset.center,
                    decoration: new BoxDecoration(
                      color: const Color.fromRGBO(247, 64, 106, 1.0),
                      borderRadius: widget.buttomZoomOut.value < 400
                          ? new BorderRadius.all(const Radius.circular(30.0))
                          : new BorderRadius.all(const Radius.circular(0.0)),
                    ),
                    child: widget.buttonSqueezeanimation.value > 75.0
                        ? new Text(
                            "Sign In",
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.3,
                            ),
                          )
                        : widget.buttomZoomOut.value < 300.0
                            ? new CircularProgressIndicator(
                                value: null,
                                strokeWidth: 1.0,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              )
                            : null)
                : new Container(
                    width: widget.buttomZoomOut.value,
                    height: widget.buttomZoomOut.value,
                    decoration: new BoxDecoration(
                      shape: widget.buttomZoomOut.value < 500
                          ? BoxShape.circle
                          : BoxShape.rectangle,
                      color: const Color.fromRGBO(247, 64, 106, 1.0),
                    ),
                  ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.buttonController.addListener(() async {
      //datoUser();
      if (widget.buttonController.isCompleted) {
        //aqui tengo que colocar mi metodo post
        datoUser();
        if (persona.isNotEmpty) {
         // print(persona[0].nombre);
         Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(persona: persona[0],)));
         // Navigator.pushNamed(context, "home", arguments: persona[0].nombre);
        }
      }
    });
    return new AnimatedBuilder(
      builder: _buildAnimation,
      animation: widget.buttonController,
    );
  }

  void datoUser() async {
    var data = await login.LoginProvider()
        .autenticando("carlos@gmail.com", "11393173");
    setState(() {
      //person=data;
      // cadena = data;
      persona.addAll(data);
    });
  }
}
