import 'package:flutter/material.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'time_slot_widget.dart';

class AvailableSlotsSection extends StatelessWidget {
  final String selectedDateTitle;
  final List<String> afternoonSlots;
  final List<String> eveningSlots;
  final String? selectedTimeSlot;
  final ValueChanged<String> onSlotSelected;

  const AvailableSlotsSection({
    super.key,
    required this.selectedDateTitle,
    required this.afternoonSlots,
    required this.eveningSlots,
    required this.selectedTimeSlot,
    required this.onSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(selectedDateTitle, style: AppTextStyles.sectionTitle),
          const SizedBox(height: 16),
          const Text(AppText.afternoonSlots, style: AppTextStyles.slotHeader),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: afternoonSlots.map((time) {
              return TimeSlotChip(
                time: time,
                isSelected: selectedTimeSlot == time,
                onTap: () => onSlotSelected(time),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Text(AppText.eveningSlots, style: AppTextStyles.slotHeader),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: eveningSlots.map((time) {
              return TimeSlotChip(
                time: time,
                isSelected: selectedTimeSlot == time,
                onTap: () => onSlotSelected(time),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
