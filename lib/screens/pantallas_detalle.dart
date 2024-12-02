import 'package:examen2_eduardoflores/modules/carrito/domain/dto/carritoDTO.dart';
import 'package:examen2_eduardoflores/modules/carrito/domain/repository/agregarRepository.dart';
import 'package:examen2_eduardoflores/modules/carrito/useCase/agregarCarrito.dart';
import 'package:examen2_eduardoflores/modules/detallado/domain/dto/dto.dart';
import 'package:examen2_eduardoflores/modules/detallado/domain/repository/repository.dart';
import 'package:examen2_eduardoflores/modules/detallado/useCase/useCase.dart';
import 'package:examen2_eduardoflores/modules/vistos/domain/repository/agregarrepository.dart';
import 'package:examen2_eduardoflores/modules/vistos/useCase/agregarUseCase.dart';
import 'package:examen2_eduardoflores/screens/pantalla_navigator.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';


class PantallasDetalle extends StatefulWidget {
  final int productId;

  PantallasDetalle({required this.productId});

  @override
  _PantallasDetalleState createState() => _PantallasDetalleState();
}

class _PantallasDetalleState extends State<PantallasDetalle> {
  final DetalleProductoUseCase detalleProductoUseCase = DetalleProductoUseCase(DetalleProductoRepository());
  final AddProductoVistoUseCase addProductoVistoUseCase = AddProductoVistoUseCase(AddProductoVistosRepository());

  late Future<DetalleProductoDTO> productFuture;
  var quantity = 1;
  LocalStorage carritoLocalStorage = LocalStorage('carrito');

  //inicializamos los valores y hacemos llamada a la api con la id del producto
  @override
  void initState() {
    super.initState();
    productFuture = detalleProductoUseCase.execute(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarraNavegadora(title: 'Detallado'), //barra de navegacion

      body: FutureBuilder<DetalleProductoDTO>(
        future: productFuture,
        builder: (context, snapshot) {//snapshot es el objeto que devuelve la promesa
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if(snapshot.hasError) {
              return Center(child: Text('Error al cargar el producto: ${snapshot.error}'));
            }
            else{
            final product = snapshot.data!;

            print("asdf");
            //agrergamos el producto a la lista de productos vistos
            addProductoVistoUseCase.execute(product);


            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    product.images[0],
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 16),
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),


                  //me canse de meter todo dentro de padding() asi que use una caja vacia como un espaciado
                  SizedBox(height: 8),
                  Text(
                    product.description ?? 'No description available.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Precio \$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Stock ${product.stock}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            final AgregarCarritoUseCase addToCartUseCase = AgregarCarritoUseCase(AgregarCarritoRepository());

                            //creamos un objeto de tipo CarritoDTO con los datos del producto
                           CarritoDTO ItemCarrito = CarritoDTO.fromJson({
                            'imagen': product.images[0],
                            'id': product.id,
                            'name': product.title,
                            'quantity': quantity,
                            'price': product.price,
                          });
                          //y los insertamos en el carrito
                            addToCartUseCase.execute(ItemCarrito);


                          },
                          icon: Icon(Icons.add, color: Colors.white),
                          label: Text('Agregar', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                    ),
                    SizedBox(width: 16),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                          ),
                          Text('$quantity'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                if (quantity < snapshot.data!.stock) quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                      ],
                    ),
                    SizedBox(height: 16),  
                    const SizedBox(height: 8),
                  ...product.reviews.map((review) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  review.reviewerName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '⭐ ${review.rating}',
                                  style: const TextStyle(color: Colors.amber),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(review.comment),
                            const SizedBox(height: 4),
                            Text(
                              'Fecha: ${review.date.toLocal()}'.split(' ')[0],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
            }            
          }
        },
      ),
    );
  }
}
