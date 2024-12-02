import 'package:examen2_eduardoflores/infrastructure/app/repository/repository.dart';
import 'package:examen2_eduardoflores/modules/vistos/domain/dto/dto.dart';
import 'package:localstorage/localstorage.dart';

//este repository es para conseguir los productos vistos
class GetProductosVistosRepository implements Repository<List<ProductosVistosDTO>, void> {
  final LocalStorage storage = LocalStorage('vistos');

  @override
  Future<List<ProductosVistosDTO>> execute(void params) async {
    await storage.ready;

    List<dynamic> productosVistos = storage.getItem('vistos') ?? [];
    
    //simplemente mapea los productos vistos a ProductosVistosDTO
    return productosVistos.map((item) => ProductosVistosDTO.fromJson(item)).toList();
  }
}