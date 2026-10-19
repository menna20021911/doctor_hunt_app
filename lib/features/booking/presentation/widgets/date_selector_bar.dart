import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_text.dart';
import 'date_selector_item.dart';

class DateSelectorBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDateSelected;

  const DateSelectorBar({
    super.key,
    required this.selectedIndex,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime tomorrowDate = now.add(const Duration(days: 1));

    final String todayFormatted = 'Today, ${DateFormat('d MMM').format(now)}';
    final String tomorrowFormatted = 'Tomorrow, ${DateFormat('d MMM').format(tomorrowDate)}';

    return Row(
      children: [
        Expanded(
          child: DateSelectorItem(
            title: todayFormatted,
            subtitle: AppText.noSlotsAvailable,
            isSelected: selectedIndex == 0,
            onTap: () => onDateSelected(0),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: DateSelectorItem(
            title: tomorrowFormatted,
            subtitle: AppText.slotsAvailable7,
            isSelected: selectedIndex == 1,
            onTap: () => onDateSelected(1),
          ),
        ),
      ],
    );
  }
}
