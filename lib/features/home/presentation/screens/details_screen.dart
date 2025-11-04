import 'package:flutter/material.dart';
import 'package:nti_final_project/features/home/data/model/product.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.card_travel))],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Men Shoes'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (product.imageUrl != null && product.imageUrl!.isNotEmpty)
                ? Image.network(
                    product.imageUrl.toString(),
                    width: 311,
                    height: 202,
                    fit: BoxFit.cover,
                    loadingBuilder: (ctx, child, prog) {
                      if (prog == null) return child;
                      return Container(
                        width: 311,
                        height: 202,
                        color: Colors.grey[200],
                        child: const Center(
                          child: SizedBox(
                            width: 28,
                            height: 28,
                            child: CircularProgressIndicator(strokeWidth: 2.5),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (ctx, err, st) => Container(
                      width: 311,
                      height: 202,
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 44,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                : Container(
                    width: 311,
                    height: 202,
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.image, size: 44, color: Colors.grey),
                    ),
                  ),
            SizedBox(height: 16),
            Text(product.name),
            SizedBox(height: 6),
            Text("Price:${product.price.toString()}"),
            SizedBox(height: 6),
            Text(
              "Stock:${product.stock.toString()}",
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
