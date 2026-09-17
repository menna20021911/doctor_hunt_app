// ignore_for_file: unused_import

import 'package:flutter/material.dart';

import '../../../../generated/app_colore.dart';
import '../../../../generated/app_text.dart';
import '../../../../generated/style_atom.dart';
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
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppText.homeGreeting, style: AppTextStyles.homeGreeting),
                  SizedBox(height: 6),
                  Text(AppText.findYourDoctor, style: AppTextStyles.homeTitle),
                ],
              ),
            ),
            ClipOval(
              child: Image.asset(
                avatarAsset,
                width: 43,
                height: 43,
                fit: BoxFit.cover,
                semanticLabel: 'Profile image',
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
            child: const IgnorePointer(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search_rounded, color: AppColors.body, size: 19),
                  suffixIcon: Icon(Icons.close_rounded, color: AppColors.body, size: 17),
                  hintText: AppText.homeSearchHint,
                  hintStyle: AppTextStyles.doctorMeta,
                  contentPadding: EdgeInsets.only(top: 14),
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
        children: [
          Text(title, style: AppTextStyles.sectionTitle),
          const Spacer(),
          GestureDetector(
            onTap: onSeeAllTap,
            behavior: HitTestBehavior.opaque,
            child: const Text(AppText.seeAll, style: AppTextStyles.seeAll),
          ),
        ],
      );
}

class LiveDoctorCard extends StatelessWidget {
  const LiveDoctorCard({super.key, required this.imageAsset, this.onTap});

  final String imageAsset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 104,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  imageAsset,
                  fit: BoxFit.cover,
                  semanticLabel: 'Live doctor',
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.liveBadge,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Text(AppText.liveBadge, style: AppTextStyles.liveBadge),
                  ),
                ),
                const Center(
                  child: Icon(
                    Icons.play_circle_outline_rounded,
                    color: AppColors.white,
                    size: 31,
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
          width: 72,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
            child: Image.asset(
              iconAsset,
              width: 33,
              height: 33,
              semanticLabel: 'Medical service',
            ),
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
          width: 145,
          decoration: BoxDecoration(
            color: AppColors.homeCard,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: AppColors.homeDivider,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(
                  imageAsset,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  semanticLabel: name,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: AppTextStyles.doctorName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Text(specialty, style: AppTextStyles.doctorSpecialty),
              const SizedBox(height: 4),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_rounded, color: AppColors.rating, size: 13),
                  Icon(Icons.star_rounded, color: AppColors.rating, size: 13),
                  Icon(Icons.star_rounded, color: AppColors.rating, size: 13),
                  Icon(Icons.star_rounded, color: AppColors.rating, size: 13),
                ],
              ),
              const SizedBox(height: 8),
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
          width: 94,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: AppColors.homeCard,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.favorite_border_rounded,
                    size: 12,
                    color: AppColors.favorite,
                  ),
                  const Spacer(),
                  const Icon(Icons.star_rounded, size: 11, color: AppColors.rating),
                  Text(rate, style: AppTextStyles.doctorMeta),
                ],
              ),
              const SizedBox(height: 3),
              ClipOval(
                child: Image.asset(
                  imageAsset,
                  width: 43,
                  height: 43,
                  fit: BoxFit.cover,
                  semanticLabel: name,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                name,
                style: AppTextStyles.doctorMeta,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              const Text(AppText.featurePrice, style: AppTextStyles.featurePrice),
            ],
          ),
        ),
      );
}

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) => Container(
        height: 66,
        decoration: const BoxDecoration(
          color: AppColors.homeCard,
          border: Border(top: BorderSide(color: AppColors.homeDivider)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _NavigationIcon(icon: Icons.home_rounded, selected: true),
            _NavigationIcon(icon: Icons.favorite_rounded),
            _NavigationIcon(icon: Icons.menu_book_rounded),
            _NavigationIcon(icon: Icons.chat_bubble_rounded),
          ],
        ),
      );
}

class _NavigationIcon extends StatelessWidget {
  const _NavigationIcon({required this.icon, this.selected = false});

  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) => Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 19,
          color: selected ? AppColors.white : AppColors.favorite,
        ),
      );
}