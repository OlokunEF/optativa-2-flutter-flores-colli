import 'dart:convert';
import 'package:examen2_eduardoflores/modules/productos/domain/dto/dto.dart';
import 'package:http/http.dart' as http;

import '../../../../infrastructure/app/repository/repository.dart';

class ProductoRepository implements Repository<List<ProductoDTO>, String> {
  final String baseUrl = 'https://dummyjson.com/products/category/';
  
  @override
  Future<List<ProductoDTO>> execute(String params) async {
    //a la url se le agrega el parametro que se le pasa al metodo, en este caso la categoria
    final response = await http.get(Uri.parse('$baseUrl$params'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['products'];
      return data.map((json) => ProductoDTO.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los productos');
    }
  }
}
