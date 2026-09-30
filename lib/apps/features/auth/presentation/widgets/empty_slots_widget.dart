import 'package:flutter/material.dart';
import '../../../../generated/app_colore.dart';
import '../../../../generated/app_text.dart';
import '../../../../generated/style_atom.dart';

class EmptySlotsWidget extends StatelessWidget {
  final String selectedDateText;
  final VoidCallback onNextAvailablePressed;
  final VoidCallback onContactClinicPressed;

  const EmptySlotsWidget({
    super.key,
    required this.selectedDateText,
    required this.onNextAvailablePressed,
    required this.onContactClinicPressed, required String nextAvailableText,
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
            child: const Text(
              AppText.nextAvailabilityWed,
              style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        Text(AppText.or, style: AppTextStyles.description),
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
              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}