import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../cubit/doctors_cubit.dart';
import '../widgets/favourite_doctor_card.dart';
import 'doctor_details_screen.dart';

class FavouriteDoctorsScreen extends StatefulWidget {
  const FavouriteDoctorsScreen({super.key});

  @override
  State<FavouriteDoctorsScreen> createState() => _FavouriteDoctorsScreenState();
}

class _FavouriteDoctorsScreenState extends State<FavouriteDoctorsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allDoctors = context.watch<DoctorsCubit>().state;
    final favoriteDoctors =
        allDoctors.where((doctor) => doctor.isFavorite && doctor.isActive).toList();

    final query = _searchController.text.trim().toLowerCase();
    final filteredDoctors = query.isEmpty
        ? favoriteDoctors
        : favoriteDoctors.where((doctor) {
            return doctor.name.toLowerCase().contains(query) ||
                doctor.specialty.toLowerCase().contains(query);
          }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.title,
                size: 16,
              ),
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                }
              },
            ),
          ),
        ),
        title: Text(
          context.tr('favourite_doctors'),
          style: const TextStyle(
            color: AppColors.title,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Bottom subtle mint glow gradient matching Figma
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 220,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.mintGlow.withValues(alpha: 0.6),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Main Content
          Column(
            children: [
              const SizedBox(height: 12),

              // Search Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    style: const TextStyle(fontSize: 14, color: AppColors.title),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColors.body,
                        size: 20,
                      ),
                      hintText: context.tr('search_doctor_hint'),
                      hintStyle:
                          const TextStyle(color: AppColors.body, fontSize: 13),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.close_rounded,
                                color: AppColors.body,
                                size: 18,
                              ),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                            )
                          : null,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Doctors 2-Column Grid
              Expanded(
                child: filteredDoctors.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_border_rounded,
                              size: 60,
                              color: AppColors.body.withValues(alpha: 0.35),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              query.isEmpty
                                  ? context.tr('no_favourite_doctors')
                                  : context.tr('no_matching_doctors'),
                              style: const TextStyle(
                                color: AppColors.title,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              query.isEmpty
                                  ? context.tr('click_heart_to_add')
                                  : context.tr('try_searching_again'),
                              style: const TextStyle(
                                color: AppColors.body,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 0.90,
                        ),
                        itemCount: filteredDoctors.length,
                        itemBuilder: (context, index) {
                          final doc = filteredDoctors[index];
                          return FavouriteDoctorCard(
                            doctor: doc,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DoctorDetailsScreen(
                                    doctorName: doc.name,
                                    doctorSpecialty: doc.specialty,
                                    doctorImage: doc.image,
                                    doctorPrice: doc.price,
                                    doctorRating: doc.rating,
                                  ),
                                ),
                              );
                            },
                            onFavoriteToggle: (_) {
                              context.read<DoctorsCubit>().toggleFavorite(doc.name);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
    );
  }
}
