
import 'package:flutter/material.dart';
import 'package:nti_final_project/features/home/presentation/screens/details_screen.dart';
import 'package:nti_final_project/features/home/data/model/product.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(product: product),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: SizedBox.expand(
                      child:
                          (product.imageUrl != null &&
                              product.imageUrl!.isNotEmpty)
                          ? Image.network(product.imageUrl!, fit: BoxFit.cover)
                          : const Center(child: Icon(Icons.image, size: 48)),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Column(
                      children: [
                        _icon(Icons.shopping_cart_outlined),
                        const SizedBox(height: 8),
                        _icon(Icons.delete_forever),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.deepOrange),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _icon(IconData icon) => CircleAvatar(
    radius: 14,
    backgroundColor: Colors.white,
    child: Icon(icon, size: 16, color: Colors.black54),
  );
}