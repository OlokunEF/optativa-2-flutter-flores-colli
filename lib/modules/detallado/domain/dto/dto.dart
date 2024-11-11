class DetalleProductoDTO {
  final int id;
  final String title;
  final List<String> images;
  final String description;
  final num price;
  final int stock;

  DetalleProductoDTO({
    required this.id,
    required this.title,
    required this.images,
    required this.description,
    required this.price,
    required this.stock,
  });

  factory DetalleProductoDTO.fromJson(Map<String, dynamic> json) {
    return DetalleProductoDTO(
      id: json['id'] as int,
      title: json['title'] as String,
      images: List<String>.from(json['images'] as List),
      description: json['description'] as String,
      price: json['price'] as num,
      stock: json['stock'] as int,
    );
  }
}
