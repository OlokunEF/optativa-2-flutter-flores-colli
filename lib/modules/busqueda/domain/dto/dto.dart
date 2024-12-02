//este es el DTO de la entidad Producto que retorna al usar la funcion de buscar

class BusquedaDTO {
  final int id;
  final String title;
  final double price;
  final String thumbnail;

  BusquedaDTO({required this.id, required this.title, required this.price, required this.thumbnail});

  factory BusquedaDTO.fromJson(Map<String, dynamic> json) {
    return BusquedaDTO(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      thumbnail: json['thumbnail'],
    );
  }
}
