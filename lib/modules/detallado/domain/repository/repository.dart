import 'dart:convert';
import 'package:examen2_eduardoflores/infrastructure/app/repository/repository.dart';
import 'package:examen2_eduardoflores/modules/detallado/domain/dto/dto.dart';
import 'package:http/http.dart' as http;

class DetalleProductoRepository implements Repository<DetalleProductoDTO, int> {
  final String baseUrl = 'https://dummyjson.com/products';
  
  @override
  Future<DetalleProductoDTO> execute(int params) async {
    final response = await http.get(Uri.parse('$baseUrl/$params'));
    if (response.statusCode == 200) {
      return DetalleProductoDTO.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al cargar el producto');
    }
  }
}
