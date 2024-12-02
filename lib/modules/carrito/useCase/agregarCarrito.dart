import 'package:examen2_eduardoflores/infrastructure/app/useCase/use_case.dart';
import 'package:examen2_eduardoflores/modules/carrito/domain/dto/carritoDTO.dart';
import 'package:examen2_eduardoflores/modules/carrito/domain/repository/agregarRepository.dart';
import 'package:localstorage/localstorage.dart';


class AgregarCarritoUseCase implements UseCase<void, CarritoDTO> {
  final AgregarCarritoRepository repositorio;

  AgregarCarritoUseCase(this.repositorio);
  final LocalStorage localstorage = LocalStorage('localstorage');

  @override
  Future<void> execute(CarritoDTO params) async {
      repositorio.execute(params);     
  }
}
