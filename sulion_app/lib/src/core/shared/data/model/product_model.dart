class Product {
  const Product({
    required this.name,
    required this.description,
    this.image,
  });
  final String name;
  final String description;
  final String? image;
}
