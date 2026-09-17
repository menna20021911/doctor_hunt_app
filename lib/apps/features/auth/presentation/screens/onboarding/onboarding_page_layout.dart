import 'package:flutter/material.dart';

import '../../../../../generated/app_colore.dart';
import '../../../../../generated/style_atom.dart';

/// Shared responsive composition for the three onboarding pages.
class OnboardingPageLayout extends StatelessWidget {
  const OnboardingPageLayout({
    required this.imageAsset,
    required this.imageLabel,
    required this.title,
    required this.primaryActionLabel,
    required this.onPrimaryAction,
    required this.onSkip,
    super.key,
  });

  final String imageAsset;
  final String imageLabel;
  final String title;
  final String primaryActionLabel;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSkip;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            const _BottomGlow(),
            SafeArea(
              top: false,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final artworkHeight = (constraints.maxHeight * .58).clamp(370.0, 470.0).toDouble();
                  final padding = (constraints.maxWidth * .07).clamp(24.0, 32.0).toDouble();
                  return Column(
                    children: [
                      SizedBox(
                        height: artworkHeight,
                        width: double.infinity,
                        child: Image.asset(
                          imageAsset,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                          semanticLabel: imageLabel,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: padding),
                          child: Column(
                            children: [
                              const SizedBox(height: 18),
                              Text(title, style: AppTextStyles.title, textAlign: TextAlign.center),
                              const SizedBox(height: 12),
                              const Text(
                                'Contrary to popular belief, Lorem Ipsum is not\nsimply random text. It has roots in a piece of\nover 2000 years old.',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.description,
                              ),
                              const Spacer(),
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: FilledButton(
                                  onPressed: onPrimaryAction ?? () {},
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                                  ),
                                  child: Text(primaryActionLabel, style: AppTextStyles.button),
                                ),
                              ),
                              const SizedBox(height: 7),
                              TextButton(
                                onPressed: onSkip ?? () {},
                                child: const Text('Skip', style: AppTextStyles.skip),
                              ),
                              const SizedBox(height: 6),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
}

class _BottomGlow extends StatelessWidget {
  const _BottomGlow();

  @override
  Widget build(BuildContext context) => const Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 230,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, AppColors.mintGlow],
              ),
            ),
          ),
        ),
      );
}
