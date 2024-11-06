import 'package:examen2_eduardoflores/rutas/routers.dart';
import 'package:examen2_eduardoflores/screens/pantalla_login.dart';
import 'package:flutter/material.dart';


class ListRouters {
  static final Map<String, Widget Function(BuildContext)> listScreens = {
    Routers.login: (context) =>  PantallaLogin(),

  };
}
