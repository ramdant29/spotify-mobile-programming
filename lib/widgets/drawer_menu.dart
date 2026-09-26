import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const CustomDrawer({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return NavigationDrawerTheme(
      data: const NavigationDrawerThemeData(
        indicatorColor: Colors.transparent,
      ),
      child: SizedBox(
        width: screenWidth * 0.85,
        child: NavigationDrawer(
          backgroundColor: const Color(0xFF212121),
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 16, 6),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    child: Icon(Icons.person, size: 40),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'User',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Lihat profil',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xff404040)),
            const NavigationDrawerDestination(
              icon: Icon(Icons.add_outlined, color: Colors.white, size: 28),
              label: Text('Tambah Akun', style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
            const NavigationDrawerDestination(
              icon: Icon(Icons.access_time, color: Colors.white, size: 28),
              label: Text('Baru Diputar', style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
            const NavigationDrawerDestination(
              icon: Icon(Icons.campaign_outlined, color: Colors.white, size: 28),
              label: Text('Info Terkini', style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
            const NavigationDrawerDestination(
              icon: Icon(Icons.settings_outlined, color: Colors.white, size: 28),
              label: Text('Pengaturan dan privasi', style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }
}