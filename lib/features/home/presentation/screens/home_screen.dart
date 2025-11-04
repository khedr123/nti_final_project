import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_final_project/features/home/data/api_service/api_service.dart';
import 'package:nti_final_project/features/home/data/model/product.dart';
import 'package:nti_final_project/screens/cart_screen.dart';
import 'package:nti_final_project/screens/widgets/custom_card.dart';

import '../../../../cubits/cart/cart_cubit.dart';
import '../../../../cubits/cart/cart_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _bannerController = PageController(
    viewportFraction: 0.92,
  );

  List<ProductModel> products = [];
  bool loading = true;
  String selectedCategory = 'All';
  final categories = ['All', 'T-shirt', 'Jeans', 'Shoes', 'Jacket'];
  Timer? _cartTimer;

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(
            title: Text(
              'Sort & Filter',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.sort),
            title: const Text('Price: Low to High'),
            onTap: () {
              setState(() {
                products.sort((a, b) => a.price.compareTo(b.price));
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.sort),
            title: const Text('Price: High to Low'),
            onTap: () {
              setState(() {
                products.sort((a, b) => b.price.compareTo(a.price));
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.new_releases),
            title: const Text('Newest First'),
            onTap: () {
              setState(() {
                products.sort((a, b) => b.id.compareTo(a.id));
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  bool _showCartSummary = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    _cartTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    try {
      final items = await ApiService.fetchProducts();
      setState(() {
        products = items;
        if (selectedCategory != 'All') {
          products = products
              .where(
                (p) => p.name.toLowerCase().contains(
                  selectedCategory.toLowerCase(),
                ),
              )
              .toList();
        }
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading products: $e')));
      }
    }
  }

  void _showCartSummaryBriefly() {
    setState(() => _showCartSummary = true);
    _cartTimer?.cancel();
    _cartTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _showCartSummary = false);
    });
  }

  Widget _buildBannerItem(String title, String category) {
    return GestureDetector(
      onTap: () {
        setState(() => selectedCategory = category);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFF7F4A2D),
        ),
        // slightly tighter padding for a compact banner
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      // reduced title size for compact banner
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() => selectedCategory = category);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF7F4A2D),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Shop now', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final columns = screenWidth >= 1000 ? 4 : (screenWidth >= 700 ? 3 : 2);
    final childAspect = screenWidth >= 700 ? 0.72 : 0.66;
    final bannerHeight = MediaQuery.of(context).size.height * 0.13;

    List<ProductModel> filteredProducts = products;
    if (selectedCategory != 'All') {
      filteredProducts = products
          .where(
            (p) =>
                p.name.toLowerCase().contains(selectedCategory.toLowerCase()),
          )
          .toList();
    }

    return Scaffold(
      key: _scaffoldKey,
      // Pale warm background (soft yellow-white to match project theme)
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        // Keep AppBar matching the page background but use brown for icons/text
        backgroundColor: const Color(0xFFFFF8E1),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF7F4A2D)),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: const Text(
          'StyleSphere',
          style: TextStyle(color: Color(0xFF7F4A2D)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            color: const Color(0xFF7F4A2D),
            onPressed: _showFilterSheet,
          ),
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              final count = context.read<CartCubit>().itemCount;
              return Badge(
                backgroundColor: const Color(0xFFEE5253),
                label: Text(
                  count.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFFFFF8E1), // match pale project background
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Color(0xFF7F4A2D)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 35,
                        color: Color(0xFF7F4A2D),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'StyleSphere',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home, color: Color(0xFF7F4A2D)),
                title: const Text(
                  'Home',
                  style: TextStyle(color: Color(0xFF7F4A2D)),
                ),
                selected: true,
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(
                  Icons.shopping_cart,
                  color: Color(0xFF7F4A2D),
                ),
                title: const Text(
                  'Cart',
                  style: TextStyle(color: Color(0xFF7F4A2D)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.favorite_border,
                  color: Color(0xFF7F4A2D),
                ),
                title: const Text(
                  'Wishlist',
                  style: TextStyle(color: Color(0xFF7F4A2D)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Add wishlist navigation
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.settings, color: Color(0xFF7F4A2D)),
                title: const Text(
                  'Settings',
                  style: TextStyle(color: Color(0xFF7F4A2D)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Add settings navigation
                },
              ),
            ],
          ),
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF7F4A2D)),
              child: Center(
                child: Text(
                  'Profile',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            // Add profile options here
          ],
        ),
      ),

      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          _loadProducts();
                        } else {
                          products = products
                              .where(
                                (p) =>
                                    p.name.toLowerCase().contains(
                                      value.toLowerCase(),
                                    ) ||
                                    (p.description?.toLowerCase() ?? '')
                                        .contains(value.toLowerCase()),
                              )
                              .toList();
                        }
                      });
                    },
                  ),
                ),

                // Hero Banner
                SizedBox(
                  height: bannerHeight,
                  child: PageView(
                    controller: _bannerController,
                    children: [
                      _buildBannerItem('Big Sale', 'Jeans'),
                      _buildBannerItem('New Arrivals', 'Jackets'),
                      _buildBannerItem('Hot Picks', 'Shoes'),
                    ],
                  ),
                ),

                // Categories (white rounded pills with brown selection)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          final selected = selectedCategory == category;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 4,
                            ),
                            child: ChoiceChip(
                              label: Text(
                                category,
                                style: TextStyle(
                                  color: selected
                                      ? Colors.white
                                      : Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              selected: selected,
                              onSelected: (sel) {
                                setState(() {
                                  selectedCategory = sel ? category : 'All';
                                });
                              },
                              backgroundColor: Colors.white,
                              selectedColor: const Color(0xFF7F4A2D),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: selected ? 2 : 0,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // Products Grid
                Expanded(
                  child: loading
                      ? const Center(child: CircularProgressIndicator())
                      : filteredProducts.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.inbox,
                                size: 72,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'No products found',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.only(bottom: 80),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: columns,
                                childAspectRatio: childAspect,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                              ),
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            return ProductCard(
                              product: product,
                              onAddToCart: () {
                                context.read<CartCubit>().addProduct(product);
                                _showCartSummaryBriefly();
                              },
                            );
                          },
                        ),
                ),
              ],
            ),

            // Floating cart summary
            if (_showCartSummary)
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.shopping_cart),
                        const SizedBox(width: 8),
                        BlocBuilder<CartCubit, CartState>(
                          builder: (context, state) {
                            return Text(
                              '${state.items.length} items - \$${state.subtotal.toStringAsFixed(2)}',
                            );
                          },
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CartScreen(),
                            ),
                          ),
                          child: const Text('View Cart'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
