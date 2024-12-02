//usamos propio tipo de datos para el carrito

class CarritoDTO {
  final String imagen;
  final String id;
  final String name;
  int quantity;
  double price;
  double totalPrice;
  String dateAdded;

  CarritoDTO({
    required this.imagen,
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  })  : totalPrice = price * quantity,
        dateAdded = DateTime.now().toIso8601String();
  //esto lo convierte de json a un objeto de tipo CarritoDTO
  factory CarritoDTO.fromJson(Map<String, dynamic> json) {
    return CarritoDTO(
      imagen: json['imagen'],
      id: json['id'].toString(),
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
    );
  }
  //y este lo convierte de un objeto de tipo CarritoDTO a json
  Map<String, dynamic> toJson() {
    return {
      'imagen': imagen,
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'totalPrice': totalPrice,
      'dateAdded': dateAdded,
    };
  }
}