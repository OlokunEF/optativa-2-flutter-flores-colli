import 'dart:convert';
import 'package:examen2_eduardoflores/modules/detallado/domain/dto/dto.dart';
import 'package:http/http.dart' as http;

class DetalleProductoRepository {
  final String baseUrl = 'https://dummyjson.com/products';

  Future<DetalleProductoDTO> fetchProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return DetalleProductoDTO.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al cargar el producto');
    }
  }
}