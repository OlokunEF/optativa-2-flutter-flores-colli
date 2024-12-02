import 'package:examen2_eduardoflores/screens/pantalla_busqueda.dart';
import 'package:examen2_eduardoflores/screens/pantalla_carrito.dart';
import 'package:examen2_eduardoflores/screens/pantalla_perfil.dart';
import 'package:examen2_eduardoflores/screens/pantalla_vistos.dart';
import 'package:flutter/material.dart';


//este es el archivo uqe contiene la barra de navegacion que se utiliza en todo el proyecto
class BarraNavegadora extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const BarraNavegadora({super.key, required this.title});


  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PantallaBusqueda(),
                ),
              );
            },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PantallaCarrito(),
                ),
              );
            },        
        ),
        IconButton(
          icon: const Icon(Icons.visibility),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PantallaVistos(),
                ),
              );
            },        
         ),
        IconButton(
          icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PantallaPerfil(),
                ),
              );
            },       
          ),
      ],
    );
  }

  //esta funcion es necesaria para que la barra de navegacion tenga un tamaño
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
