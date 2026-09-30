import 'package:flutter/material.dart';

import 'chose_role_screen.dart';
import '../../../../../generated/image_assets.dart';
import 'onboarding_page_layout.dart';

class Onboarding3Screen extends StatelessWidget {
  const Onboarding3Screen({super.key, this.onGetStarted, this.onSkip});

  final VoidCallback? onGetStarted;
  final VoidCallback? onSkip;

  @override
  Widget build(BuildContext context) => OnboardingPageLayout(
        imageAsset: ImageAssets.onboardingDoctor3,
        imageLabel: 'Medical researcher working in a laboratory',
        title: 'Easy Appointments',
        primaryActionLabel: 'Get Started',
        onPrimaryAction: onGetStarted ?? () => _finishOnboarding(context),
        onSkip: onSkip ?? () => _finishOnboarding(context),
      );

  void _finishOnboarding(BuildContext context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const ChoseRoleScreen()),
      );
}
