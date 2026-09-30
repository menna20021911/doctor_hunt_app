// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../generated/app_colore.dart';
import '../../../../generated/app_text.dart';
import '../../../../generated/image_assets.dart';
import '../../../../generated/style_atom.dart';
import '../widgets/available_slots_section.dart';
import '../widgets/date_selector_bar.dart';
import '../widgets/doctor_info_header_card.dart';
import '../widgets/empty_slots_widget.dart';


class SelectTimeScreen extends StatefulWidget {
  final String doctorName;
  final String doctorSpecialty;
  final String doctorImage;
  final String doctorRating;

  const SelectTimeScreen({
    super.key,
    this.doctorName = 'Dr. Shruti Kedia',
    this.doctorSpecialty = 'Upasana Dental Clinic, salt lake',
    this.doctorImage = ImageAssets.drShrutiKedia,
    this.doctorRating = '4.8',
  });

  @override
  State<SelectTimeScreen> createState() => _SelectTimeScreenState();
}

class _SelectTimeScreenState extends State<SelectTimeScreen> {
  int selectedDateIndex = 0; // 0: Today, 1: Tomorrow
  String? selectedTimeSlot;

  final List<String> afternoonSlots = [
    '1:00 PM', '1:30 PM', '2:00 PM', '2:30 PM',
    '3:00 PM', '3:30 PM', '4:00 PM'
  ];

  final List<String> eveningSlots = [
    '5:00 PM', '5:30 PM', '6:00 PM', '6:30 PM',
    '7:00 PM'
  ];

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime nextDate = now.add(const Duration(days: 1));
    
    final String todayFormatted = 'Today, ${DateFormat('d MMM').format(now)}';
    final String nextDateFormatted = DateFormat('EEE, d MMM').format(nextDate);

    return Scaffold(
      backgroundColor: AppColors.homeSurface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: AppColors.title),
        title: const Text(AppText.selectTime, style: AppTextStyles.sectionTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DoctorInfoHeaderCard(
              imagePath: widget.doctorImage,
              name: widget.doctorName,
              specialty: widget.doctorSpecialty,
              rating: widget.doctorRating,
            ),
            const SizedBox(height: 20),

            DateSelectorBar(
      selectedIndex: selectedDateIndex,
      onDateSelected: (index) {
        setState(() {
          selectedDateIndex = index;
        });
      },
    ),
            const SizedBox(height: 24),

            Expanded(
              child: selectedDateIndex == 0
                  ? EmptySlotsWidget(
                      selectedDateText: todayFormatted,
                      nextAvailableText: 'Next availability on $nextDateFormatted',
                      onNextAvailablePressed: () {
                        setState(() {
                          selectedDateIndex = 1;
                        });
                      },
                      onContactClinicPressed: () {},
                    )
                  : AvailableSlotsSection(
                      selectedDateTitle: todayFormatted,
                      afternoonSlots: afternoonSlots,
                      eveningSlots: eveningSlots,
                      selectedTimeSlot: selectedTimeSlot,
                      onSlotSelected: (time) {
                        setState(() {
                          selectedTimeSlot = time;
                        });
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
