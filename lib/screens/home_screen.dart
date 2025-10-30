import 'package:flutter/material.dart';
import 'package:nti_final_project/screens/cart_screen.dart';
import 'package:nti_final_project/screens/widgets/bottom_nav_bar.dart';
import 'package:nti_final_project/screens/widgets/constants.dart';
import 'package:nti_final_project/screens/widgets/custom_input_field';
import 'package:nti_final_project/screens/widgets/primary_button.dart';
import 'package:nti_final_project/screens/widgets/product_card_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _screenContent = <Widget>[
    const ProductsViewContent(),
    const AddNewServiceContent(),
    const ProfileScreenContent(),
  ];

  AppBar _buildAppBar(int index) {
    if (index == 0) {
      return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.menu, color: Colors.black),
            const Text(
              'StyleSphere',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),

            IconButton(
              icon: Icon(Icons.shopping_cart_outlined, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
            ),
          ],
        ),
      );
    } else if (index == 1) {
      return AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 20,
        ),
        title: const Text(
          'Add New Service',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      );
    } else {
      return AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,

      appBar: _buildAppBar(_selectedIndex),

      body: _screenContent.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class ProductsViewContent extends StatelessWidget {
  const ProductsViewContent({super.key});

  final List<Map<String, String>> dummyProducts = const [
    {
      'title': 'Graphic Tee',
      'price': '\$24.99',
      'image': 'https://via.placeholder.com/150/0000FF/808080?Text=Tee',
    },
    {
      'title': 'Denim Jeans',
      'price': '\$79.99',
      'image': 'https://via.placeholder.com/150/505050/FFFFFF?Text=Jeans',
    },
    {
      'title': 'White Sneakers',
      'price': '\$59.99',
      'image': 'https://via.placeholder.com/150/FFFFFF/000000?Text=Sneakers',
    },
    {
      'title': 'Leather Jacket',
      'price': '\$149.99',
      'image': 'https://via.placeholder.com/150/303030/FFFFFF?Text=Jacket',
    },
    {
      'title': 'Cozy Hoodie',
      'price': '\$49.99',
      'image': 'https://via.placeholder.com/150/A0A0A0/FFFFFF?Text=Hoodie',
    },
    {
      'title': 'Minimalist Watch',
      'price': '\$199.99',
      'image': 'https://via.placeholder.com/150/000000/FFFFFF?Text=Watch',
    },
  ];

  final List<String> categories = const [
    'All',
    'T-shirts',
    'Jeans',
    'Shoes',
    'Jackets',
    'Watches',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for products...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: kLightInputField,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
            ),
          ),
        ),

        SizedBox(
          height: 45,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 16.0 : 8.0,
                  right: 8.0,
                ),
                child: Chip(
                  label: Text(categories[index]),
                  backgroundColor: index == 0
                      ? kPrimaryColor
                      : kLightInputField,
                  labelStyle: TextStyle(
                    color: index == 0 ? Colors.white : Colors.black87,
                    fontWeight: index == 0
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                ),
              );
            },
          ),
        ),

        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: dummyProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemBuilder: (context, index) {
              return ProductCardWidget(
                imageUrl: dummyProducts[index]['image']!,
                title: dummyProducts[index]['title']!,
                price: dummyProducts[index]['price']!,
              );
            },
          ),
        ),
      ],
    );
  }
}

class AddNewServiceContent extends StatelessWidget {
  const AddNewServiceContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomInputField(
            labelText: 'Service Name',
            hintText: 'e.g. Graphic T-Shirt Design',
          ),
          const CustomInputField(
            labelText: 'Description',
            hintText: 'Describe the service you are offering',
          ),
          const CustomInputField(labelText: 'Price', hintText: '\$ 0.00'),
          const CustomInputField(
            labelText: 'Category',
            hintText: 'Select a category',
            isDropdown: true,
          ),
          const CustomInputField(labelText: 'Stock', hintText: 'e.g. 100'),
          const SizedBox(height: 10),
          PrimaryButton(text: 'Add Service', onPressed: () {}),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------------

// ****** محتوى شاشة البروفايل (ProfileScreenContent) ******
class ProfileScreenContent extends StatelessWidget {
  const ProfileScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile Page Content (Empty)',
        style: TextStyle(fontSize: 20, color: Colors.black54),
      ),
    );
  }
}
