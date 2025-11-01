import 'package:e_commerceapp/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product';
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F3D9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F3D9),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(product.name, style: const TextStyle(color: Colors.black)),
        actions: const [Icon(Icons.favorite_border, color: Colors.black)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: product.imageUrl != null && product.imageUrl!.isNotEmpty
                    ? Image.network(product.imageUrl!)
                    : const Icon(Icons.image, size: 100, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              '\$${product.price}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.deepOrangeAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(product.description ?? 'No description available'),
          ],
        ),
      ),
    );
  }
}
