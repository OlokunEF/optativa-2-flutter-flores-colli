import 'package:examen2_eduardoflores/infrastructure/app/useCase/use_case.dart';
import 'package:examen2_eduardoflores/modules/productos/domain/dto/dto.dart';
import 'package:examen2_eduardoflores/modules/productos/domain/repository/repository.dart';
import 'package:localstorage/localstorage.dart';


//en el useCase entra un string (para denotar la categoria)
//y sale un ProductoDTO, que es la lista de productos de la API.
class ProductoUseCase implements UseCase<List<ProductoDTO>, String> {
  final ProductoRepository repositorio;
  final LocalStorage localstorage = LocalStorage('localstorage');

  ProductoUseCase(this.repositorio);

  @override
  Future<List<ProductoDTO>> execute(String category) async {
      // Check if there is any token in the local storage, if not return an error
      if (localstorage.getItem('tokendeacceso') == null) {
         throw Exception('No se encontro ningun Token');
      }
      return  repositorio.execute(category);
  }
}