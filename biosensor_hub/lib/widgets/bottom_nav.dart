import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.cyan,
      unselectedItemColor: Colors.white54,
      backgroundColor: Colors.grey.shade900,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.sensors),
          label: 'TELEMETRY',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_remote),
          label: 'CONTROLLER',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: 'ANALYTICS',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.security),
          label: 'SAFETY',
        ),
      ],
    );
  }
}