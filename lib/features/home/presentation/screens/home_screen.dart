import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../core/constants/image_assets.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../doctors/presentation/screens/doctor_details_screen.dart';
import '../../../doctors/presentation/screens/find_doctor_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../widgets/home_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToFindDoctors(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const FindDoctorsScreen(),
      ),
    );
  }

  void _navigateToDoctorDetails(
    BuildContext context, {
    required String name,
    required String specialty,
    required String image,
    required String price,
    required double rating,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DoctorDetailsScreen(
          doctorName: name,
          doctorSpecialty: specialty,
          doctorImage: image,
          doctorPrice: price,
          doctorRating: rating,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          HomeHeader(
                            avatarAsset: ImageAssets.iconHeader,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const ProfileScreen(),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            left: 20,
                            right: 20,
                            bottom: -26,
                            child: HomeSearchField(
                              onTap: () => _navigateToFindDoctors(context),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: HomeSectionHeader(
                          title: context.tr('live_doctors'),
                          onSeeAllTap: () => _navigateToFindDoctors(context),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 140,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 11),
                          itemBuilder: (context, index) {
                            final images = [
                              ImageAssets.doctor1,
                              ImageAssets.doctor2,
                              ImageAssets.doctor3,
                            ];
                            return LiveDoctorCard(
                              imageAsset: images[index],
                              onTap: () => _navigateToFindDoctors(context),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        height: 80,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          children: [
                            ServiceCard(
                              iconAsset: ImageAssets.iconTeeth,
                              colors: const [
                                AppColors.dentalCardStart,
                                AppColors.dentalCardEnd,
                              ],
                              onTap: () => _navigateToFindDoctors(context),
                            ),
                            const SizedBox(width: 14),
                            ServiceCard(
                              iconAsset: ImageAssets.iconHeart,
                              colors: const [
                                AppColors.heartCardStart,
                                AppColors.heartCardEnd,
                              ],
                              onTap: () => _navigateToFindDoctors(context),
                            ),
                            const SizedBox(width: 14),
                            ServiceCard(
                              iconAsset: ImageAssets.iconEye,
                              colors: const [
                                AppColors.eyeCardStart,
                                AppColors.eyeCardEnd,
                              ],
                              onTap: () => _navigateToFindDoctors(context),
                            ),
                            const SizedBox(width: 14),
                            ServiceCard(
                              iconAsset: ImageAssets.iconStomach,
                              colors: const [
                                AppColors.medicalCardStart,
                                AppColors.medicalCardEnd,
                              ],
                              onTap: () => _navigateToFindDoctors(context),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: HomeSectionHeader(
                          title: context.tr('popular_doctor'),
                          onSeeAllTap: () => _navigateToFindDoctors(context),
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          children: [
                            PopularDoctorCard(
                              imageAsset: ImageAssets.drFillerup,
                              name: 'Dr. Fillerup Grab',
                              specialty: AppText.medicineSpecialist,
                              onTap: () => _navigateToDoctorDetails(
                                context,
                                name: 'Dr. Fillerup Grab',
                                specialty: AppText.medicineSpecialist,
                                image: ImageAssets.drFillerup,
                                price: '25.00',
                                rating: 4.5,
                              ),
                            ),
                            const SizedBox(width: 14),
                            PopularDoctorCard(
                              imageAsset: ImageAssets.drBlessing,
                              name: 'Dr. Blessing',
                              specialty: AppText.dentistSpecialist,
                              onTap: () => _navigateToDoctorDetails(
                                context,
                                name: 'Dr. Blessing',
                                specialty: AppText.dentistSpecialist,
                                image: ImageAssets.drBlessing,
                                price: '28.00',
                                rating: 4.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: HomeSectionHeader(
                          title: context.tr('feature_doctor'),
                          onSeeAllTap: () => _navigateToFindDoctors(context),
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 125,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          children: [
                            FeatureDoctorCard(
                              imageAsset: ImageAssets.drCrick,
                              name: 'Dr. Crick',
                              rate: '3.7',
                              onTap: () => _navigateToDoctorDetails(
                                context,
                                name: 'Dr. Crick',
                                specialty: 'Specialist Medicine',
                                image: ImageAssets.drCrick,
                                price: '25.00',
                                rating: 3.7,
                              ),
                            ),
                            const SizedBox(width: 12),
                            FeatureDoctorCard(
                              imageAsset: ImageAssets.drStrain,
                              name: 'Dr. Strain',
                              rate: '3.0',
                              onTap: () => _navigateToDoctorDetails(
                                context,
                                name: 'Dr. Strain',
                                specialty: 'Specialist Dental',
                                image: ImageAssets.drStrain,
                                price: '22.00',
                                rating: 3.0,
                              ),
                            ),
                            const SizedBox(width: 12),
                            FeatureDoctorCard(
                              imageAsset: ImageAssets.drLachinet,
                              name: 'Dr. Lachinne',
                              rate: '2.9',
                              onTap: () => _navigateToDoctorDetails(
                                context,
                                name: 'Dr. Lachinne',
                                specialty: 'Specialist General',
                                image: ImageAssets.drLachinet,
                                price: '20.00',
                                rating: 2.9,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              const AppBottomNavBar(currentIndex: 0),
            ],
          ),
        ),
      );
}
