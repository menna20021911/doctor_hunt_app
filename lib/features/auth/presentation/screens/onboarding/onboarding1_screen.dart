import 'package:flutter/material.dart';
import '../../../../../core/constants/image_assets.dart';
import 'onboarding2_screen.dart';
import 'onboarding_page_layout.dart';

class Onboarding1Screen extends StatelessWidget {
  const Onboarding1Screen({super.key, this.onNext, this.onSkip});

  final VoidCallback? onNext;
  final VoidCallback? onSkip;

  @override
  Widget build(BuildContext context) => OnboardingPageLayout(
        imageAsset: ImageAssets.image,
        imageLabel: 'Doctor caring for a patient',
        title: 'Find Trusted Doctors',
        primaryActionLabel: 'Next',
        onPrimaryAction: onNext ?? () => _openNextPage(context),
        onSkip: onSkip ?? () => _openNextPage(context),
      );

  void _openNextPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const Onboarding2Screen()),
    );
  }
}
