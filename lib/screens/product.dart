class Product {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final double price;

  Product({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? json['arabicDescription'] ?? '',
      imageUrl: json['coverPictureUrl'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}
