
import 'package:examen2_eduardoflores/infrastructure/app/useCase/use_case.dart';
import 'package:examen2_eduardoflores/modules/detallado/domain/dto/dto.dart';
import 'package:examen2_eduardoflores/modules/detallado/domain/repository/repository.dart';

import 'package:localstorage/localstorage.dart';


//en el useCase entra un int (id del producto)
//y sale un DetalleProductoDTO, que es la lista de productos de la API.
class DetalleProductoUseCase implements UseCase<DetalleProductoDTO, int> {
  final DetalleProductoRepository repositorio;
  final LocalStorage localstorage = LocalStorage('localstorage');

  DetalleProductoUseCase(this.repositorio);

  @override
  Future<DetalleProductoDTO> execute(int id) async {
      // checa si hay alguna token en el local storage, si no hay, regresa un error
      if (localstorage.getItem('tokendeacceso') == null) {
         throw Exception('No se encontro ningun Token');
      }
      return await repositorio.execute(id);
  }
}