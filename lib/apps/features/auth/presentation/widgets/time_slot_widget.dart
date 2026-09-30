import 'package:flutter/material.dart';
import '../../../../generated/app_colore.dart';
import '../../../../generated/style_atom.dart';

class TimeSlotChip extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotChip({
    super.key,
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.slotChipBg,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          time,
          style: isSelected
              ? AppTextStyles.slotTimeSelected
              : AppTextStyles.slotTime,
        ),
      ),
    );
  }
}