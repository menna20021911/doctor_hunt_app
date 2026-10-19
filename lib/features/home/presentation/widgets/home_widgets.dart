import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../appointments/presentation/screens/appointments_screen.dart';
import '../../../doctors/presentation/screens/favourite_doctors_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, this.onTap, required this.avatarAsset});

  final String avatarAsset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Container(
        height: 155,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 42),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
          gradient: LinearGradient(
            colors: [AppColors.homeHeaderStart, AppColors.homeHeaderEnd],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.tr('home_greeting'),
                      style: AppTextStyles.homeGreeting),
                  const SizedBox(height: 6),
                  Text(context.tr('find_your_doctor'),
                      style: AppTextStyles.homeTitle),
                ],
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: ClipOval(
                child: Image.asset(
                  avatarAsset,
                  width: 43,
                  height: 43,
                  fit: BoxFit.cover,
                  semanticLabel: 'Profile image',
                ),
              ),
            ),
          ],
        ),
      );
}

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Container(
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.homeCard,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: AppColors.homeDivider,
              blurRadius: 14,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: IgnorePointer(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon:
                      const Icon(Icons.search_rounded, color: AppColors.body, size: 19),
                  suffixIcon:
                      const Icon(Icons.close_rounded, color: AppColors.body, size: 17),
                  hintText: context.tr('search_hint'),
                  hintStyle: AppTextStyles.doctorMeta,
                  contentPadding: const EdgeInsets.only(top: 14),
                ),
              ),
            ),
          ),
        ),
      );
}

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({
    super.key,
    required this.title,
    this.onSeeAllTap,
  });

  final String title;
  final VoidCallback? onSeeAllTap;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.sectionTitle),
          GestureDetector(
            onTap: onSeeAllTap,
            child: Text(context.tr('see_all'), style: AppTextStyles.seeAll),
          ),
        ],
      );
}

class LiveDoctorCard extends StatelessWidget {
  const LiveDoctorCard({
    super.key,
    required this.imageAsset,
    this.onTap,
  });

  final String imageAsset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 110,
            height: 140,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(imageAsset, fit: BoxFit.cover),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.liveBadge,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      AppText.liveBadge,
                      style: AppTextStyles.liveBadge,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow,
                        color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.iconAsset,
    required this.colors,
    this.onTap,
  });

  final String iconAsset;
  final List<Color> colors;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Image.asset(iconAsset, width: 36, height: 36),
          ),
        ),
      );
}

class PopularDoctorCard extends StatelessWidget {
  const PopularDoctorCard({
    super.key,
    required this.imageAsset,
    required this.name,
    required this.specialty,
    this.onTap,
  });

  final String imageAsset;
  final String name;
  final String specialty;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 140,
          decoration: BoxDecoration(
            color: AppColors.homeCard,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: AppColors.homeDivider,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  imageAsset,
                  width: 140,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: AppTextStyles.doctorName,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Text(
                specialty,
                style: AppTextStyles.doctorSpecialty,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: AppColors.rating, size: 13),
                  Icon(Icons.star, color: AppColors.rating, size: 13),
                  Icon(Icons.star, color: AppColors.rating, size: 13),
                  Icon(Icons.star, color: AppColors.rating, size: 13),
                  Icon(Icons.star_half, color: AppColors.rating, size: 13),
                ],
              ),
            ],
          ),
        ),
      );
}

class FeatureDoctorCard extends StatelessWidget {
  const FeatureDoctorCard({
    super.key,
    required this.imageAsset,
    required this.name,
    required this.rate,
    this.onTap,
  });

  final String imageAsset;
  final String name;
  final String rate;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 100,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.homeCard,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: AppColors.homeDivider,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.favorite_border,
                      size: 14, color: AppColors.favorite),
                  Row(
                    children: [
                      const Icon(Icons.star, color: AppColors.rating, size: 11),
                      const SizedBox(width: 2),
                      Text(rate, style: AppTextStyles.doctorMeta),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4),
              ClipOval(
                child: Image.asset(imageAsset,
                    width: 44, height: 44, fit: BoxFit.cover),
              ),
              const SizedBox(height: 6),
              Text(
                name,
                style: AppTextStyles.doctorName,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              const Text(AppText.featurePrice,
                  style: AppTextStyles.featurePrice),
            ],
          ),
        ),
      );
}

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) => Container(
        height: 64,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, Icons.home_rounded, true, () {}),
            _buildNavItem(context, Icons.favorite_outline_rounded, false, () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => const FavouriteDoctorsScreen()),
              );
            }),
            _buildNavItem(context, Icons.menu_book_rounded, false, () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AppointmentsScreen()),
              );
            }),
            _buildNavItem(context, Icons.settings_outlined, false, () {}),
          ],
        ),
      );

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: 42,
          height: 42,
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
