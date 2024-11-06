import 'dart:convert';
import 'package:examen2_eduardoflores/modules/productos/domain/dto/dto.dart';
import 'package:http/http.dart' as http;

class ProductoRepository {
  final String baseUrl = 'https://dummyjson.com/products/category/';

  Future<List<ProductoDTO>> agararProductoPorCategoria(String category) async {
    final response = await http.get(Uri.parse('$baseUrl$category'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['products'];
      return data.map((json) => ProductoDTO.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
