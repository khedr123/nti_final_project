import 'package:flutter/material.dart';
import 'package:nti_final_project/screens/widgets/cart_item_widget.dart';
import 'package:nti_final_project/screens/widgets/constants.dart';
import 'package:nti_final_project/screens/widgets/primary_button.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  final List<Map<String, dynamic>> cartItems = const [
    {
      'title': 'Graphic Tee',
      'price': 24.99,
      'quantity': 1,
      'image': 'https://via.placeholder.com/150/0000FF/808080?Text=Tee',
    },
    {
      'title': 'Denim Jeans',
      'price': 79.99,
      'quantity': 1,
      'image': 'https://via.placeholder.com/150/505050/FFFFFF?Text=Jeans',
    },
    {
      'title': 'Cozy Hoodie',
      'price': 49.99,
      'quantity': 2,
      'image': 'https://via.placeholder.com/150/A0A0A0/FFFFFF?Text=Hoodie',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double subtotal = cartItems.fold(
      0.0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );
    const double shipping = 5.00;
    final double total = subtotal + shipping;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.shopping_cart_outlined, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CartItemWidget(
                  imageUrl: item['image'],
                  title: item['title'],
                  price: '\$${item['price'].toStringAsFixed(2)}',
                  quantity: item['quantity'],
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildSummaryRow(
                    'Subtotal',
                    '\$${subtotal.toStringAsFixed(2)}',
                    false,
                  ),
                  _buildSummaryRow(
                    'Shipping',
                    '\$${shipping.toStringAsFixed(2)}',
                    false,
                  ),
                  const Divider(),
                  _buildSummaryRow(
                    'Total',
                    '\$${total.toStringAsFixed(2)}',
                    true,
                  ),
                ],
              ),
            ),
          ),
          // زر Checkout
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: PrimaryButton(text: 'Checkout', onPressed: () {}),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, bool isTotal) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.black54,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
