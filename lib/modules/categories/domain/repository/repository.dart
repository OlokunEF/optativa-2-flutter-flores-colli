import 'dart:convert';
import 'package:examen2_eduardoflores/modules/categories/domain/dto/dto.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {
  final String apiUrl = 'https://dummyjson.com/products/categories';

  Future<List<CategoryDTO>> fetchCategories() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => CategoryDTO.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
