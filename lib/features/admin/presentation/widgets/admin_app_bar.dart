import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;

  const AdminAppBar({
    super.key,
    required this.title,
    this.onNotificationTap,
    this.onProfileTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF222B45),
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        // Notification bell with badge
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: InkWell(
            onTap: onNotificationTap ?? () {},
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8F8),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE8EDF1)),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    color: Color(0xFF677294),
                    size: 20,
                  ),
                  Positioned(
                    top: 8,
                    right: 9,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Admin avatar badge
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: InkWell(
            onTap: onProfileTap ?? () {},
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: Color(0xFF0EBE7F),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
