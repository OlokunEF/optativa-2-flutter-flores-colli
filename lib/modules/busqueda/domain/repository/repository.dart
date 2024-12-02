import 'dart:convert';
import 'package:examen2_eduardoflores/infrastructure/app/repository/repository.dart';
import 'package:examen2_eduardoflores/modules/busqueda/domain/dto/dto.dart';
import 'package:http/http.dart' as http;

//esto es lit casi lo mismo que el repository de productos y detalle producto, fue copia y pega practicamente
class BusquedaRepository implements Repository<List<BusquedaDTO>, String> {
  final String baseUrl = 'https://dummyjson.com/products/search?q=';
  
  @override
  Future<List<BusquedaDTO>> execute(String params) async {
    final response = await http.get(Uri.parse('$baseUrl$params'));
    if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded['products'] is List) {
          List<dynamic> data = decoded['products'];
          return data.map((json) => BusquedaDTO.fromJson(json)).toList();
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Error al buscar el producto');
      }
  }
}
