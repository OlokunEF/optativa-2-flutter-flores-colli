import 'package:examen2_eduardoflores/modules/categories/domain/dto/dto.dart';
import 'package:examen2_eduardoflores/modules/categories/domain/repository/repository.dart';


//esta funcion realmente no hace nada
//simplemente esta de placeholder de momento para usar a futuro
class CategoriesUseCase {
  final CategoryRepository repository;

  CategoriesUseCase(this.repository);

  Future<List<CategoryDTO>> execute() {
    return repository.fetchCategories();
  }
}
