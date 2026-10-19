import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../../features/appointments/presentation/screens/appointments_screen.dart';
import '../../features/doctors/presentation/screens/favourite_doctors_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex; // 0: Home, 1: Favorites, 2: Appointments, 3: Settings

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget targetScreen;
    switch (index) {
      case 0:
        targetScreen = const HomeScreen();
        break;
      case 1:
        targetScreen = const FavouriteDoctorsScreen();
        break;
      case 2:
        targetScreen = const AppointmentsScreen();
        break;
      case 3:
        targetScreen = const SettingsScreen();
        break;
      default:
        return;
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => targetScreen,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 0: Home
          _buildNavItem(
            icon: Icons.home_rounded,
            isSelected: currentIndex == 0,
            onTap: () => _onItemTapped(context, 0),
          ),

          // 1: Favorites
          _buildNavItem(
            icon: Icons.favorite_rounded,
            isSelected: currentIndex == 1,
            onTap: () => _onItemTapped(context, 1),
          ),

          // 2: Appointments (Book icon next to Favorites)
          _buildNavItem(
            icon: Icons.menu_book_rounded,
            isSelected: currentIndex == 2,
            onTap: () => _onItemTapped(context, 2),
          ),

          // 3: Settings
          _buildNavItem(
            icon: Icons.settings_rounded,
            isSelected: currentIndex == 3,
            onTap: () => _onItemTapped(context, 3),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : AppColors.body,
          size: 22,
        ),
      ),
    );
  }
}
