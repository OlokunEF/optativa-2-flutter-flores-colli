class ProductoDTO {
  final int id;
  final String title;
  final String thumbnail;

  ProductoDTO({required this.id, required this.title, required this.thumbnail});

  factory ProductoDTO.fromJson(Map<String, dynamic> json) {
    return ProductoDTO(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
    );
  }
}
