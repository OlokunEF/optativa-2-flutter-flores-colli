import 'package:examen2_eduardoflores/screens/pantalla_navigator.dart';
import 'package:flutter/material.dart';


//Esta pantalla no se usa, es para la proxima entrega
class PantallaPerfil extends StatelessWidget {
  const PantallaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarraNavegadora(title: 'Perfil'), //barra de navegacion

      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Text("Sin implementar")
        ),
      
    );
  }
}