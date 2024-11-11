import 'package:examen2_eduardoflores/modules/detallado/domain/dto/carritoDTO.dart';
import 'package:examen2_eduardoflores/modules/detallado/domain/dto/dto.dart';
import 'package:examen2_eduardoflores/modules/detallado/domain/repository/repository.dart';
import 'package:examen2_eduardoflores/modules/detallado/useCase/useCase.dart';
import 'package:examen2_eduardoflores/screens/pantalla_carrito.dart';
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
      appBar: AppBar(
        title: Text('Detalle de producto', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
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

                            //creamos un objeto de tipo CarritoDTO con los datos del producto
                           CarritoDTO ItemCarrito = CarritoDTO.fromJson({
                            'imagen': product.images[0],
                            'id': product.id,
                            'name': product.title,
                            'quantity': quantity,
                            'price': product.price,
                          });

                          List<dynamic> carritoJson = carritoLocalStorage.getItem('carrito') ?? [];
                          List<CarritoDTO> carrito = carritoJson.map((item) => CarritoDTO.fromJson(Map<String, dynamic>.from(item))).toList();

                          int carritoIndex = carrito.indexWhere((element) => element.id == product.id.toString());

                          //si el producto no esta en el carrito lo agregamos
                          if (carritoIndex == -1) {
                            //si el carrito tiene mas de 7 productos no permitimos agregar mas
                            if (carrito.length > 7) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('El carrito esta lleno'),
                                duration: Duration(seconds: 2),
                              ));
                              return;
                            }

                            
                            carrito.add(ItemCarrito);
                          } 
                          //si el producto ya esta en el carrito solo aumentamos la cantidad y precio
                          else {
                            carrito[carritoIndex].quantity += quantity;
                            carrito[carritoIndex].totalPrice = carrito[carritoIndex].price * carrito[carritoIndex].quantity;

                            if (carrito[carritoIndex].quantity > product.stock) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('No hay suficiente stock'),
                                duration: Duration(seconds: 2),
                              ));
                              return;
                            }
                          }

                          carritoLocalStorage.setItem('carrito', carrito.map((item) => item.toJson()).toList());


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
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaCarrito()));

                      },
                      icon: Icon(Icons.shopping_cart, color: Colors.white),
                      label: Text('Ver Carrito', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        ),
                    ),
                    ),
                    SizedBox(height: 16),

                    ElevatedButton.icon(
                      onPressed: () {
                        carritoLocalStorage.clear();
                      },
                      icon: Icon(Icons.delete_sweep, color: Colors.white),
                      label: Text('Vaciar carrito', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
            
          }
        },
      ),
    );
  }
}
