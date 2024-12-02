import 'package:examen2_eduardoflores/modules/carrito/domain/dto/carritoDTO.dart';
import 'package:examen2_eduardoflores/modules/carrito/domain/repository/agregarRepository.dart';
import 'package:examen2_eduardoflores/modules/carrito/useCase/agregarCarrito.dart';
import 'package:examen2_eduardoflores/modules/vistos/domain/dto/dto.dart';
import 'package:examen2_eduardoflores/modules/vistos/domain/repository/conseguirrepository.dart';
import 'package:examen2_eduardoflores/modules/vistos/useCase/conseguirUseCase.dart';
import 'package:examen2_eduardoflores/screens/pantalla_navigator.dart';

import 'package:flutter/material.dart';

class PantallaVistos extends StatelessWidget {
  const PantallaVistos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarraNavegadora(title: 'Vistos'), //barra de navegacion

      body: Padding(padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          FutureBuilder<List<ProductosVistosDTO>>(
            future: GetProductosVistosUseCase(GetProductosVistosRepository()).execute(null),
           builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          else {
            if(snapshot.hasError) {
              return Center(child: Text('Error al cargar los productos: ${snapshot.error}'));
            }
             else {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
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
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(8.0)),
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
                            Text(
                            'Precio: \$${product.price}',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            'Visto ${product.timesViewed} veces',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                            ),
                          ),
                          ElevatedButton(onPressed: () {
                              final AgregarCarritoUseCase addToCartUseCase = AgregarCarritoUseCase(AgregarCarritoRepository());
                              CarritoDTO ItemCarrito = CarritoDTO.fromJson({
                                'imagen': product.thumbnail,
                                'id': product.id,
                                'name': product.title,
                                'quantity': 1,
                                'price': product.price,
                              });
                              addToCartUseCase.execute(ItemCarrito);
                          },
                          child: Text("Agregar a carrito", style: TextStyle(color: Colors.blue),),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        )
      );
                
          }            
          }
        },
      ),
        ]
      ),
      
      )
    );
  }
}