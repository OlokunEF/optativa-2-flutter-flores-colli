import 'package:examen2_eduardoflores/modules/detallado/domain/dto/dto.dart';
import 'package:examen2_eduardoflores/modules/detallado/domain/repository/repository.dart';
import 'package:flutter/material.dart';


class PantallasDetalle extends StatefulWidget {
  final int productId;

  const PantallasDetalle({super.key, required this.productId});

  @override
  _PantallasDetalleState createState() => _PantallasDetalleState();
}

class _PantallasDetalleState extends State<PantallasDetalle> {
  final DetalleProductoRepository productRepository = DetalleProductoRepository();
  late Future<DetalleProductoDTO> productFuture;


  //inicializamos los valores y hacemos llamada a la api con la id del producto
  @override
  void initState() {
    super.initState();
    productFuture = productRepository.fetchProductById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de producto', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<DetalleProductoDTO>(
        future: productFuture,
        builder: (context, snapshot) {//snapshot es el objeto que devuelve la promesa
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final product = snapshot.data!;
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
                  const SizedBox(height: 16),
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),


                  //caja vacia como un espaciado
                  const SizedBox(height: 8),
                  Text(
                    product.description ?? 'NO EXISTE DESCRIPCION',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Precio \$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Stock ${product.stock}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                    ElevatedButton.icon(
                    onPressed: () {
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text('Agregar', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
