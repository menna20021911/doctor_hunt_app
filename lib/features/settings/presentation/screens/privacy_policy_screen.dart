import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        title: const Text(
          'Privacy policy',
          style: TextStyle(
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

          // Content
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Doctor Hunt Apps Privacy Policy',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.title,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words believable. It is a long established fact that reader will distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.body,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),

                // Bullet points with primary green dots
                _buildBulletPoint(
                  'The standard chunk of lorem Ipsum used since 1500s is reproduced below for those interested.',
                ),
                const SizedBox(height: 16),
                _buildBulletPoint(
                  'Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum". The point of using.',
                ),
                const SizedBox(height: 16),
                _buildBulletPoint(
                  'Lorem Ipsum is that it has a more-it is a long established fact that reader will distracted.',
                ),
                const SizedBox(height: 16),
                _buildBulletPoint(
                  'The point of using Lorem Ipsum is that it has a more-it is a long established fact that reader will distracted.',
                ),

                const SizedBox(height: 24),
                const Text(
                  'It is a long established fact that reader distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-it is a long established fact that reader will distracted.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.body,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6, right: 10),
          width: 7,
          height: 7,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.body,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
