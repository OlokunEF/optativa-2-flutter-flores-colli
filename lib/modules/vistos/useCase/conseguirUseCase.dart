import 'package:examen2_eduardoflores/infrastructure/app/useCase/use_case.dart';
import 'package:examen2_eduardoflores/modules/vistos/domain/dto/dto.dart';
import 'package:examen2_eduardoflores/modules/vistos/domain/repository/conseguirrepository.dart';



class GetProductosVistosUseCase implements UseCase<List<ProductosVistosDTO>, void> {
  final GetProductosVistosRepository repository;

  GetProductosVistosUseCase(this.repository);

  @override
  Future<List<ProductosVistosDTO>> execute(void params) async {
    return await repository.execute(null);
  }
}