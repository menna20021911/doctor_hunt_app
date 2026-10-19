import 'package:flutter/material.dart';
import '../../../../../core/constants/image_assets.dart';
import 'onboarding3_screen.dart';
import 'onboarding_page_layout.dart';

class Onboarding2Screen extends StatelessWidget {
  const Onboarding2Screen({super.key, this.onNext, this.onSkip});

  final VoidCallback? onNext;
  final VoidCallback? onSkip;

  @override
  Widget build(BuildContext context) => OnboardingPageLayout(
        imageAsset: ImageAssets.onboardingDoctor2,
        imageLabel: 'Doctor working in a laboratory',
        title: 'Choose Best Doctors',
        primaryActionLabel: 'Next',
        onPrimaryAction: onNext ?? () => _openNextPage(context),
        onSkip: onSkip ?? () => _openNextPage(context),
      );

  void _openNextPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const Onboarding3Screen()),
    );
  }
}
