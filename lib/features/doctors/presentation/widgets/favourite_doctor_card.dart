import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/doctor_model.dart';

class FavouriteDoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onFavoriteToggle;

  const FavouriteDoctorCard({
    super.key,
    required this.doctor,
    this.onTap,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isFavorite = doctor.isFavorite;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Heart Icon (Aligned to the right)
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => onFavoriteToggle?.call(!isFavorite),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite
                        ? AppColors.selectedHeart
                        : AppColors.favorite,
                    size: 20,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 2),

            // Circular Doctor Image
            ClipOval(
              child: Image.asset(
                doctor.image,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 10),

            // Doctor Name
            Text(
              doctor.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.title,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 4),

            // Doctor Specialty in Green
            Text(
              doctor.specialty,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
