// pantalla_carrito.dart
import 'package:examen2_eduardoflores/modules/detallado/domain/dto/carritoDTO.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class PantallaCarrito extends StatefulWidget {
  const PantallaCarrito({super.key});

  @override
  _PantallaCarritoState createState() => _PantallaCarritoState();
}

class _PantallaCarritoState extends State<PantallaCarrito> {
  final LocalStorage storage = LocalStorage('carrito');
  List<CarritoDTO> carrito = [];
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _loadCarritoItems();
  }

  Future<void> _loadCarritoItems() async {
    await storage.ready;

    //vemos si hay algo en el carrito, si no retorna una lista vacia  
    List<dynamic> items = storage.getItem('carrito') ?? [];
    setState(() {

      //serializamos los items a un objeto de tipo CarritoDTO
      carrito = items
          .map((item) => CarritoDTO.fromJson(Map<String, dynamic>.from(item)))
          .toList();
      totalAmount = carrito.fold(0.0, (sum, item) => sum + item.totalPrice);
    });
  }

  void _deleteItem(int index) async {
    await storage.ready;
    setState(() {

      //removemos el item del carrito y actualizamos el total
      carrito.removeAt(index);
      storage.setItem('carrito', carrito.map((item) => item.toJson()).toList());
      totalAmount = carrito.fold(0.0, (sum, item) => sum + item.totalPrice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Carrito - Total: \$${totalAmount.toStringAsFixed(2)}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: carrito.isEmpty
          //si el carrito esta vacio mostramos un mensaje
          ? Center(child: Text('El carrito está vacío.'))
          //de lo contrario el list view con los items del carrito
          : ListView.builder(
              itemCount: carrito.length,
              itemBuilder: (context, index) {
                final item = carrito[index];
                return ListTile(
                  leading: Image.network(item.imagen),
                  title: Text(item.name),
                  subtitle: Text(
                      'Cantidad: ${item.quantity}\nPrecio: \$${item.price.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Total: \$${item.totalPrice.toStringAsFixed(2)}'),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteItem(index),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}