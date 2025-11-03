class ProductModel {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final double price;
  final num stock;

  ProductModel({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.price,
    required this.stock
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? json['arabicDescription'] ?? '',
      imageUrl: json['coverPictureUrl'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      stock:json['stock']
    );
  }
}
