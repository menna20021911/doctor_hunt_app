import 'package:flutter/material.dart';

import '../../../../generated/app_colore.dart';
import '../../../../generated/app_text.dart';
import '../../../../generated/image_assets.dart';
import '../screens/find_doctor_screen.dart';
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
                          const HomeHeader(avatarAsset: ImageAssets.iconHeader),
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
                          title: AppText.liveDoctors,
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
                          separatorBuilder: (_, __) => const SizedBox(width: 11),
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
                          title: AppText.popularDoctor,
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
                              onTap: () => _navigateToFindDoctors(context),
                            ),
                            const SizedBox(width: 14),
                            PopularDoctorCard(
                              imageAsset: ImageAssets.drBlessing,
                              name: 'Dr. Blessing',
                              specialty: AppText.dentistSpecialist,
                              onTap: () => _navigateToFindDoctors(context),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: HomeSectionHeader(
                          title: AppText.featureDoctor,
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
                              onTap: () => _navigateToFindDoctors(context),
                            ),
                            const SizedBox(width: 12),
                            FeatureDoctorCard(
                              imageAsset: ImageAssets.drStrain,
                              name: 'Dr. Strain',
                              rate: '3.0',
                              onTap: () => _navigateToFindDoctors(context),
                            ),
                            const SizedBox(width: 12),
                            FeatureDoctorCard(
                              imageAsset: ImageAssets.drLachinet,
                              name: 'Dr. Lachinne',
                              rate: '2.9',
                              onTap: () => _navigateToFindDoctors(context),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              const HomeBottomNavigation(),
            ],
          ),
        ),
      );
}