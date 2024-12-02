
import 'package:examen2_eduardoflores/infrastructure/app/useCase/use_case.dart';
import 'package:examen2_eduardoflores/modules/busqueda/domain/dto/dto.dart';
import 'package:examen2_eduardoflores/modules/busqueda/domain/repository/repository.dart';
import 'package:localstorage/localstorage.dart';


//en el useCase entra un string (la query de la busqueda)
//y sale un DetalleProductoDTO, que es la lista de productos de la API.
class BusquedaUseCase implements UseCase<List<BusquedaDTO>, String> {
  final BusquedaRepository repositorio;
  final LocalStorage localstorage = LocalStorage('localstorage');

  BusquedaUseCase(this.repositorio);

  @override
  Future<List<BusquedaDTO>> execute(String busqueda) async {
      // checa si hay alguna token en el local storage, si no hay, regresa un error
      if (localstorage.getItem('tokendeacceso') == null) {
         throw Exception('No se encontro ningun Token');
      }
      return await repositorio.execute(busqueda);
  }
}