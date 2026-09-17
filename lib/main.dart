import 'package:flutter/material.dart';

import 'apps/generated/app_colore.dart';
import 'apps/features/auth/presentation/screens/splash/splash_screen.dart';
import 'apps/generated/style_atom.dart';

void main() => runApp(const DoctorHuntApp());

class DoctorHuntApp extends StatelessWidget {
  const DoctorHuntApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Doctor Hunt',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      );
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            final artworkHeight = (constraints.maxHeight * .48).clamp(300.0, 440.0).toDouble();
            final contentPadding = (constraints.maxWidth * .10).clamp(24.0, 40.0).toDouble();
            return Stack(
              children: [
                const _BottomGlow(),
                SafeArea(
                  child: Column(
                    children: [
                      SizedBox(height: artworkHeight, width: double.infinity, child: const _OnboardingArtwork()),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: contentPadding),
                          child: Column(
                            children: [
                              Text('Find Trusted Doctors', style: AppTextStyles.title),
                              const SizedBox(height: 12),
                              const Text(
                                'Contrary to popular belief, Lorem Ipsum is not\nsimply random text. It has roots in a piece of\nover 2000 years old.',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.description,
                              ),
                              const Spacer(),
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: FilledButton(
                                  onPressed: () => _showMessage(context, 'Next onboarding screen'),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                                  ),
                                  child: const Text('Next', style: AppTextStyles.button),
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextButton(
                                onPressed: () => _showMessage(context, 'Onboarding skipped'),
                                child: const Text('Skip', style: AppTextStyles.skip),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );
}

class _OnboardingArtwork extends StatelessWidget {
  const _OnboardingArtwork();

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final diameter = (constraints.maxWidth * .74).clamp(260.0, 350.0).toDouble();
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -diameter * .68,
                left: -diameter * .44,
                child: Container(
                  width: diameter * 1.25,
                  height: diameter * 1.25,
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                ),
              ),
              Positioned(top: diameter * .05, right: -diameter * .14, child: _DoctorPhoto(diameter: diameter)),
            ],
          );
        },
      );
}

class _DoctorPhoto extends StatelessWidget {
  const _DoctorPhoto({required this.diameter});
  final double diameter;

  @override
  Widget build(BuildContext context) => Container(
        width: diameter,
        height: diameter,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Image.network(
          'https://images.unsplash.com/photo-1584982751601-97dcc096659c?auto=format&fit=crop&w=900&q=85',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const _PhotoFallback(),
        ),
      );
}

class _PhotoFallback extends StatelessWidget {
  const _PhotoFallback();

  @override
  Widget build(BuildContext context) => Container(
        color: const Color(0xffdceff2),
        child: const Center(child: Icon(Icons.medical_services_rounded, size: 88, color: AppColors.primary)),
      );
}

class _BottomGlow extends StatelessWidget {
  const _BottomGlow();

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 220,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, AppColors.mintGlow],
            ),
          ),
        ),
      );
}
