import 'package:examen2_eduardoflores/modules/productos/domain/dto/dto.dart';
import 'package:examen2_eduardoflores/modules/productos/domain/repository/repository.dart';
import 'package:examen2_eduardoflores/modules/productos/useCase/usecase.dart';
import 'package:examen2_eduardoflores/screens/pantallas_detalle.dart';
import 'package:flutter/material.dart';


class PantallasProductos extends StatefulWidget {
  final String category;

  //decibimos el valor que mandamos en pantalla_categoria
  const PantallasProductos({super.key, required this.category});

  @override
  _PantallasProductosState createState() => _PantallasProductosState();
}

class _PantallasProductosState extends State<PantallasProductos> {
  late ProductoUseCase fetchProductsUseCase;
  late Future<List<ProductoDTO>> productsFuture;


//inicializamos los valores
  @override
  void initState() {
    super.initState();
    //nota: el use case no hace nada de momento
    fetchProductsUseCase = ProductoUseCase(ProductoRepository());
    productsFuture = fetchProductsUseCase.execute(widget.category);
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: 
        Text('Products',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false, 

      ),

      //otro future list
      body: FutureBuilder<List<ProductoDTO>>(
        future: productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }  else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final product = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PantallasDetalle(productId: product.id), //mandamos el id del producto a la pantalla de detalle
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
                              child: Image.network(
                                product.thumbnail,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  product.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Detalles',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
