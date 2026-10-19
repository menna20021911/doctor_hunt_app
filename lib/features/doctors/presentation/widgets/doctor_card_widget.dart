import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_text_styles.dart';

class DoctorCardWidget extends StatelessWidget {
  final String imagePath;
  final String name;
  final String specialty;
  final String experience;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onBookNow;

  const DoctorCardWidget({
    super.key,
    required this.imagePath,
    required this.name,
    required this.specialty,
    required this.experience,
    this.isFavorite = false,
    this.onFavoriteToggle,
    this.onBookNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.homeCard,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.title.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(imagePath, width: 84, height: 84, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(name, style: AppTextStyles.doctorName)),
                        GestureDetector(
                          onTap: onFavoriteToggle,
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? AppColors.selectedHeart : AppColors.favorite,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(specialty, style: AppTextStyles.doctorSpecialty),
                    Text(experience, style: AppTextStyles.doctorMeta),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const CircleAvatar(radius: 4, backgroundColor: AppColors.primary),
                        const SizedBox(width: 4),
                        const Text(AppText.matchPercentage, style: AppTextStyles.doctorMeta),
                        const SizedBox(width: 12),
                        const CircleAvatar(radius: 4, backgroundColor: AppColors.primary),
                        const SizedBox(width: 4),
                        const Text(AppText.patientStories, style: AppTextStyles.doctorMeta),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.homeDivider, height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.tr('next_available'), style: AppTextStyles.featurePrice),
                  const Text(AppText.defaultTime, style: AppTextStyles.doctorMeta),
                ],
              ),
              ElevatedButton(
                onPressed: onBookNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: Text(context.tr('book_now'), style: AppTextStyles.homeGreeting),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
