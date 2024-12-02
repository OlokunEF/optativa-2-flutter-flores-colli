
import 'package:examen2_eduardoflores/infrastructure/app/repository/repository.dart';
import 'package:examen2_eduardoflores/modules/detallado/domain/dto/dto.dart';
import 'package:localstorage/localstorage.dart';


//este es el repositorio para agregar objetos a la lista de productos vistos previamente
class AddProductoVistosRepository implements Repository<void, DetalleProductoDTO>{
  final LocalStorage storage = LocalStorage('vistos');

  @override
  Future<void> execute(DetalleProductoDTO producto) async {
    await storage.ready;

    //agarramos la lista de productos vistos del local storage
    List<dynamic> productosVistos = storage.getItem('vistos') ?? [];
    
    // checa si el producto ya esta en la lista de productos vistos
    int index = productosVistos.indexWhere((item) => item['id'] == producto.id);
    if (index != -1) {
      //si el producto ya esta en la lista, aumenta el contador de veces visto (Si retorna -1 es porque no esta en la lista)
      productosVistos[index]['timesViewed'] = (productosVistos[index]['timesViewed'] as int) + 1;
    } else {
      //si el producto no esta en la lista, lo agrega
      productosVistos.add({
        'id': producto.id,
        'title': producto.title,
        'thumbnail': producto.images[0],
        'price': producto.price,
        'timesViewed': 1,
      });
    }
    print("agregando producto a lista de vistos");

    await storage.setItem('vistos', productosVistos);
  }
}
