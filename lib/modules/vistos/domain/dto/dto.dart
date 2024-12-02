class ProductosVistosDTO {
  final int id;
  final String title;
  final String thumbnail;
  final num price;
  int timesViewed;
  ProductosVistosDTO({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.timesViewed,
    });

  factory ProductosVistosDTO.fromJson(Map<String, dynamic> json) {
    return ProductosVistosDTO(
      id: json['id'] as int,
      title: json['title'] as String,
      thumbnail: json['thumbnail'] as String,
      price: json['price'] as num,
      timesViewed: json['timesViewed'] as int,
    );
  }
   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'price': price,
      'timesViewed': timesViewed,
    };
  }
}
