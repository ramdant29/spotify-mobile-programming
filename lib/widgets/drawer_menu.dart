import 'package:flutter/material.dart';
import '../utils/auth_service.dart';
import '../screens/profile_screen.dart';

class CustomDrawer extends StatelessWidget {
  final int selectedIndex;
  final bool isLoggedIn;
  final Function(int) onDestinationSelected;

  const CustomDrawer({
    super.key,
    required this.selectedIndex,
    required this.isLoggedIn,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService.loggedInUser;

    return Drawer(
      backgroundColor: const Color(0xFF121212),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF1F1F1F),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (currentUser != null) {
                      Navigator.pop(context); 
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileScreen()),
                      );
                    }
                  },
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.green,
                        child: Icon(Icons.person, size: 36, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentUser?.name ?? 'Belum Masuk',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              currentUser?.email ?? 'Ketuk untuk buat/masuk akun',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.add_box_outlined, color: Colors.white),
            title: const Text('Tambah Akun', style: TextStyle(color: Colors.white)),
            onTap: () => onDestinationSelected(0),
          ),
          ListTile(
            leading: const Icon(Icons.access_time, color: Colors.white),
            title: const Text('Baru Diputar', style: TextStyle(color: Colors.white)),
            onTap: () => onDestinationSelected(1),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.white),
            title: const Text('Info Terkini', style: TextStyle(color: Colors.white)),
            onTap: () => onDestinationSelected(2),
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined, color: Colors.white),
            title: const Text('Pengaturan dan privasi', style: TextStyle(color: Colors.white)),
            onTap: () => onDestinationSelected(3),
          ),
        ],
      ),
    );
  }
}