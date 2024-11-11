import 'package:examen2_eduardoflores/infrastructure/app/useCase/use_case.dart';
import 'package:examen2_eduardoflores/modules/categories/domain/dto/dto.dart';
import 'package:examen2_eduardoflores/modules/categories/domain/repository/repository.dart';
import 'package:localstorage/localstorage.dart';


class CategoriesUseCase implements UseCase<List<CategoryDTO>, void> {
  final CategoryRepository repositorio;

  CategoriesUseCase(this.repositorio);
  final LocalStorage localstorage = LocalStorage('localstorage');

  @override
  Future<List<CategoryDTO>> execute(void params) async {
    //para probar si esto sirve simplemente cvambiar el nombre de la variable
    if (localstorage.getItem('tokendeacceso') == null) {
      throw Exception('No se encontro ningun Token');
    }
    return repositorio.execute(params);
  }
}
