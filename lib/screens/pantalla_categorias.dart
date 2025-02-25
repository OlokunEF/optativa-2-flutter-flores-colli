import 'package:examen2_eduardoflores/modules/categories/domain/dto/dto.dart';
import 'package:examen2_eduardoflores/modules/categories/domain/repository/repository.dart';
import 'package:examen2_eduardoflores/modules/categories/useCase/usecase.dart';
import 'package:examen2_eduardoflores/screens/pantalla_navigator.dart';
import 'package:examen2_eduardoflores/screens/pantallas_productos.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';


class PantallaCategorias extends StatefulWidget {
  @override
  _PantallaCategoriasState createState() => _PantallaCategoriasState();
}

class _PantallaCategoriasState extends State<PantallaCategorias> {
  final CategoriesUseCase fetchCategoriesUseCase = CategoriesUseCase(CategoryRepository());

  late Future<List<CategoryDTO>> categoriesFuture;

  final LocalStorage localstorage = LocalStorage('localstorage');

  //inicilizamos valores, el usecase no hace nada de mmomento
  @override
  void initState() {
    super.initState();
    categoriesFuture = fetchCategoriesUseCase.execute('categories');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarraNavegadora(title: 'Categorias'), //barra de navegacion

      //future builder es como un list builder pero con cosas asincronas, como promesas.
      body: FutureBuilder<List<CategoryDTO>>(
        future: categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); //si no hay datos, pon pantala de carga
          } else {
            if(snapshot.hasError) {
              return Center(child: Text('Error al cargar las categorias: ${snapshot.error}')); //si hay error, muestra el error
            }
            else{
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final category = snapshot.data![index];
                return ListTile(
                  leading: Icon(
                    index.isEven ? Icons.restaurant : Icons.shopping_bag, //isEven es un metodo de dart que devuelve true si el numero es par
                    color: index.isEven ? Colors.blue : Colors.red,
                  ),
                  title: Text(category.name),
                  subtitle: Text(category.slug),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: index.isEven ? Colors.blue : Colors.red,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PantallasProductos(category: category.slug), //mandamos la categoria a la pantalla de productos (slug es el nombre de la categoria)
                      ),
                    );
                  },
                );
              },
            );
            }
          }
        },
      ),
    );
  }
}
