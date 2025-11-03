import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:nti_final_project/features/add_product/presentation/screens/add_service.dart';
import 'package:nti_final_project/features/profile/presentation/screens/profile_screen.dart';
import 'package:nti_final_project/features/home/presentation/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  List<Widget> getScreen() {
   return [HomeScreen(),AddServiceScreen(),ProfileScreen()];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getScreen()[currentIndex],
      bottomNavigationBar: ConvexAppBar(style: TabStyle.flip,backgroundColor: Color(0xffA3856E),
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.add_box, title: 'Add'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        onTap: (index) => setState(() {
          currentIndex=index;
        })
      ),
    );
  }
}
