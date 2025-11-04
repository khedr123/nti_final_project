import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileAppState();
}

// --- dark,light mode ---
class _ProfileAppState extends State<ProfileScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFFA3856E),
        scaffoldBackgroundColor: const Color(0xFFF5F5DE),
        fontFamily: 'Work Sans',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F5DE),
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFA3856E),
        scaffoldBackgroundColor: const Color(0xFF101922),
        fontFamily: 'Work Sans',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF101922),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: ProfilePage(
        isDarkMode: isDarkMode,
        onThemeChanged: (value) {
          setState(() {
            isDarkMode = value;
          });
        },
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const ProfilePage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Edit",
              style: TextStyle(
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- User Info ---
          Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuDPIdc_2ZnDLARDAvQ42KLsf98dGojFOu3dCGt9m91_zyBc70b5jzhsh8tKc2znfHiCoc4tmQKsg8J2SKwNE2reTSlQJXoWiaH_jDP6LXlstqSCUO-Xml3yEy45ZJCw7Mivg3XUyZ0YEA7ClfnCfngJHaIUGRSBuKqD8D4AnSYq_O2NG3ksllMdtBC04B-8sQBSybnhc9lHS9hMBSUe82bADT3DX4C_AIiPv-jF_hV13MJcyNKKkvlhVJ6-pTJlJ4g2Sw9eHFQ8QKM",
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "John Doe",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                "john.doe@email.com",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // --- ACCOUNT MANAGEMENT ---
          const SectionHeader(title: "ACCOUNT MANAGEMENT"),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: theme.brightness == Brightness.light
                ? Colors.white.withOpacity(0.5)
                : Colors.grey[800],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SettingTile(
                  icon: Icons.inventory_2_outlined,
                  title: "My Orders",
                  onTap: () {},
                ),
                SettingTile(
                  icon: Icons.favorite_outline,
                  title: "Wishlist",
                  onTap: () {},
                ),
                SettingTile(
                  icon: Icons.location_on_outlined,
                  title: "Shipping Addresses",
                  onTap: () {},
                ),
                SettingTile(
                  icon: Icons.payment_outlined,
                  title: "Payment Methods",
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // --- APP SETTINGS ---
          const SectionHeader(title: "APP SETTINGS"),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: theme.brightness == Brightness.light
                ? Colors.white.withOpacity(0.5)
                : Colors.grey[800],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.notifications_outlined),
                  title: const Text("Push Notifications"),
                  activeThumbColor: theme.primaryColor,
                  value: pushNotifications,
                  onChanged: (v) => setState(() => pushNotifications = v),
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode_outlined),
                  title: const Text("Dark Mode"),
                  activeThumbColor: theme.primaryColor,
                  value: widget.isDarkMode,
                  onChanged: (v) {
                    widget.onThemeChanged(v);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // --- SUPPORT & LEGAL ---
          const SectionHeader(title: "SUPPORT & LEGAL"),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: theme.brightness == Brightness.light
                ? Colors.white.withOpacity(0.5)
                : Colors.grey[800],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SettingTile(
                  icon: Icons.help_outline,
                  title: "Help & Support",
                  onTap: () {},
                ),
                SettingTile(
                  icon: Icons.description_outlined,
                  title: "Terms of Service",
                  onTap: () {},
                ),
                SettingTile(
                  icon: Icons.shield_outlined,
                  title: "Privacy Policy",
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // --- Logout Button ---
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.withOpacity(0.1),
              foregroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {},
            child: const Text(
              "Log Out",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Custom Widgets ---

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey[500],
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      leading: Container(
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark
              ? Colors.grey[800]
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: theme.iconTheme.color),
      ),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
