import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F3D9),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFFF6F3D9),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: const [
            CircleAvatar(radius: 36, child: Icon(Icons.person, size: 36)),
            SizedBox(height: 12),
            Text(
              'User Name',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 24),
            Card(
              child: ListTile(
                leading: Icon(Icons.shopping_bag),
                title: Text('Orders'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
