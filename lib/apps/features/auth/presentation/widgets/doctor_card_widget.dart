import 'package:flutter/material.dart';
import '../../../../generated/app_colore.dart';
import '../../../../generated/app_text.dart';
import '../../../../generated/style_atom.dart';

class DoctorCardWidget extends StatelessWidget {
  final String imagePath;
  final String name;
  final String specialty;
  final String experience;
  final bool isFavorite;

  const DoctorCardWidget({
    super.key,
    required this.imagePath,
    required this.name,
    required this.specialty,
    required this.experience,
    this.isFavorite = false,
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
            color: AppColors.title.withOpacity(0.05),
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
                        Text(name, style: AppTextStyles.doctorName),
                        Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? AppColors.heartCardStart : AppColors.favorite,
                          size: 20,
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
                children: const [
                  Text(AppText.nextAvailable, style: AppTextStyles.featurePrice),
                  Text(AppText.defaultTime, style: AppTextStyles.doctorMeta),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text(AppText.bookNow, style: AppTextStyles.homeGreeting),
              ),
            ],
          ),
        ],
      ),
    );
  }
}