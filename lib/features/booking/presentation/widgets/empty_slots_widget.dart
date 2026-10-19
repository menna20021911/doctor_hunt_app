import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../core/theme/app_text_styles.dart';

class EmptySlotsWidget extends StatelessWidget {
  final String selectedDateText;
  final String nextAvailableText;
  final VoidCallback onNextAvailablePressed;
  final VoidCallback onContactClinicPressed;

  const EmptySlotsWidget({
    super.key,
    required this.selectedDateText,
    required this.nextAvailableText,
    required this.onNextAvailablePressed,
    required this.onContactClinicPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(selectedDateText, style: AppTextStyles.sectionTitle),
        const SizedBox(height: 12),
        Text(AppText.noSlotsAvailable, style: AppTextStyles.emptyStateText),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: onNextAvailablePressed,
            child: Text(
              nextAvailableText.isNotEmpty
                  ? nextAvailableText
                  : AppText.nextAvailabilityWed,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(AppText.or, style: AppTextStyles.description),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: onContactClinicPressed,
            child: const Text(
              AppText.contactClinic,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
