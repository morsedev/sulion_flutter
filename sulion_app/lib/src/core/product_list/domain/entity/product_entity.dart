class ProductEntity {
  ProductEntity({
    required this.id,
    required this.description,
    this.image,
  });

  final String id;
  final String description;
  final String? image;

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
        id: json['name'] ?? '',
        description: json['description'] ?? '',
        image: json['image']);
  }
}
