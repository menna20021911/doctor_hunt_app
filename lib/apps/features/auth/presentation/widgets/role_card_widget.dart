import 'package:flutter/material.dart';

import '../../../../generated/app_colore.dart';
import '../../../../generated/style_atom.dart';

enum UserRole {
  patient('Patient', 'Find doctors, book\nappointments,\nand manage your medical\nrecords.', Icons.personal_injury_rounded),
  admin('Admin', 'Manage doctors, appointments,\nusers, and the platform.', Icons.grid_view_rounded);

  const UserRole(this.label, this.description, this.icon);

  final String label;
  final String description;
  final IconData icon;
}

class RoleCardWidget extends StatelessWidget {
  const RoleCardWidget({super.key, required this.role, required this.isSelected, required this.onTap});

  final UserRole role;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
        color: isSelected ? AppColors.roleSurface : AppColors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(23),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: isSelected ? AppColors.primary : AppColors.inactiveBorder, width: isSelected ? 2 : 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(color: AppColors.roleIconSurface, shape: BoxShape.circle),
                  child: Icon(role.icon, color: isSelected ? AppColors.primaryDark : AppColors.body),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(role.label, style: AppTextStyles.roleName),
                      const SizedBox(height: 6),
                      Text(role.description, style: AppTextStyles.roleDescription),
                    ],
                  ),
                ),
                if (isSelected) const Icon(Icons.check_circle_rounded, color: AppColors.primaryDark, size: 25),
              ],
            ),
          ),
        ),
      );
}
