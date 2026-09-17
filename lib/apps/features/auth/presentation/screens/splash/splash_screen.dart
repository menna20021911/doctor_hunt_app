import 'package:flutter/material.dart';

import '../../../../../generated/image_assets.dart';
import '../onboarding/onboarding1_screen.dart';

/// First screen shown while the application is initializing.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _openOnboarding();
  }

  Future<void> _openOnboarding() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const Onboarding1Screen()),
    );
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, .48, 1],
              colors: [Color(0xffdff5ff), Colors.white, Color(0xffc9f8e8)],
            ),
          ),
          child: SafeArea(child: _SplashLogo()),
        ),
      );
}

class _SplashLogo extends StatelessWidget {
  const _SplashLogo();

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final logoWidth = (constraints.maxWidth * .48).clamp(170.0, 210.0).toDouble();
          return Align(
            alignment: const Alignment(0, -.05),
            child: Image.asset(
              ImageAssets.logo,
              width: logoWidth,
              fit: BoxFit.contain,
              semanticLabel: 'Doctor Hunt',
            ),
          );
        },
      );
}
