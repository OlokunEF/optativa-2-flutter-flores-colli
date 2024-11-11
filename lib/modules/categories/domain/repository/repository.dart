import 'dart:convert';
import 'package:examen2_eduardoflores/infrastructure/app/repository/repository.dart';
import 'package:examen2_eduardoflores/modules/categories/domain/dto/dto.dart';
import 'package:http/http.dart' as http;

class CategoryRepository implements Repository<List<CategoryDTO>, void> {
  final String apiUrl = 'https://dummyjson.com/products/categories';
  
  @override
  Future<List<CategoryDTO>> execute(void params) async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => CategoryDTO.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar las categorias');
    }
  }
}
