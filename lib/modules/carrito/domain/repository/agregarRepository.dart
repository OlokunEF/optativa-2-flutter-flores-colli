
import 'package:examen2_eduardoflores/infrastructure/app/repository/repository.dart';
import 'package:examen2_eduardoflores/modules/carrito/domain/dto/carritoDTO.dart';
import 'package:localstorage/localstorage.dart';

//movimos esta funcion desde la pantalla de detalle hasta su propio archivo
class AgregarCarritoRepository implements Repository<void, CarritoDTO> {
  final LocalStorage carritoLocalStorage = LocalStorage('carrito');

  @override
  Future<void> execute(CarritoDTO item) async {
    await carritoLocalStorage.ready;

        List<dynamic> carritoJson = carritoLocalStorage.getItem('carrito') ?? [];
        //convertimos la lista de json a una lista de CarritoDTO (se guardan como json por defecto)
        List<CarritoDTO> carrito = carritoJson
            .map((jsonItem) => CarritoDTO.fromJson(Map<String, dynamic>.from(jsonItem)))
            .toList();

        //checamos si el item ya esta en el carrito
        int carritoIndex = carrito.indexWhere((element) => element.id == item.id);

        //si el index es -1 significa que no lo encontro
        if (carritoIndex == -1) {
          // Checar si el carrito está lleno
          if (carrito.length >= 7) {
            throw Exception('El carrito está lleno');
          }
          carrito.add(item);
        } else {
          //si ya esta en el carrito, solo aumentamos la cantidad y recalculamos el total
          carrito[carritoIndex].quantity += item.quantity;
          carrito[carritoIndex].totalPrice = carrito[carritoIndex].price * carrito[carritoIndex].quantity;
        }
        //guardamos el carrito en el local storage
        print("Producto agregado");
        await carritoLocalStorage.setItem('carrito', carrito.map((item) => item.toJson()).toList());
  }
}

