import 'package:e_commerceapp/models/product.dart';
import 'package:e_commerceapp/services/api_service.dart';
import 'package:flutter/material.dart';
import 'product_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];
  bool loading = true;
  String selectedCategory = 'All';
  final categories = ['All', 'T-shirts', 'Jeans', 'Shoes', 'Jackets'];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final items = await ApiService.fetchProducts();
      setState(() {
        products = items;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading products: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    final filtered = products;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F3D9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            children: [
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                  const Text(
                    'StyleSphere',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart_outlined),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for products...',
                  filled: true,
                  fillColor: const Color(0xFFF0EFD9),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 46,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (c, i) {
                    final cat = categories[i];
                    final sel = cat == selectedCategory;
                    return GestureDetector(
                      onTap: () => setState(() => selectedCategory = cat),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: sel ? const Color(0xFF7F4A2D) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFDCD6BF)),
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            color: sel ? Colors.white : Colors.black87,
                            fontWeight: sel
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: loading
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        padding: const EdgeInsets.only(bottom: 12),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.66,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                            ),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final p = filtered[index];
                          return ProductCard(product: p);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),

      //
      bottomNavigationBar: Container(
        color: const Color(0xFF8B5E3C),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'Home', true),
            _buildNavItem(Icons.add_circle_outline, 'Add Service', false),
            _buildNavItem(Icons.person, 'Profile', false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool active) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        ProductDetailsScreen.routeName,
        arguments: product,
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
                        _icon(Icons.favorite_border),
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
