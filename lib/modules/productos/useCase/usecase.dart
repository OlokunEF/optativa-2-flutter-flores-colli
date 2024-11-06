import 'package:examen2_eduardoflores/modules/productos/domain/dto/dto.dart';
import 'package:examen2_eduardoflores/modules/productos/domain/repository/repository.dart';


//el usecase de momento no hace nada, es para implementar a futuro
class ProductoUseCase {
  final ProductoRepository repository;

  ProductoUseCase(this.repository);
  
  Future<List<ProductoDTO>> execute(String category) {
    return repository.agararProductoPorCategoria(category);
  }
}
