import 'package:examen2_eduardoflores/infrastructure/app/useCase/use_case.dart';
import 'package:examen2_eduardoflores/modules/detallado/domain/dto/dto.dart';

import 'package:examen2_eduardoflores/modules/vistos/domain/repository/agregarrepository.dart';

class AddProductoVistoUseCase implements UseCase<void, DetalleProductoDTO> {
  final AddProductoVistosRepository repository;

  AddProductoVistoUseCase(this.repository);

  @override
  Future<void> execute(DetalleProductoDTO producto) async {
    await repository.execute(producto);
  }
}