import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../core/constants/image_assets.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/available_slots_section.dart';
import '../widgets/date_selector_bar.dart';
import '../widgets/doctor_info_header_card.dart';
import '../widgets/empty_slots_widget.dart';
import '../widgets/thank_you_dialog.dart';

class SelectTimeScreen extends StatefulWidget {
  final String doctorName;
  final String doctorSpecialty;
  final String doctorImage;
  final String doctorRating;
  final bool isFavorite;

  const SelectTimeScreen({
    super.key,
    this.doctorName = 'Dr. Shruti Kedia',
    this.doctorSpecialty = 'Upasana Dental Clinic, salt lake',
    this.doctorImage = ImageAssets.drShrutiKedia,
    this.doctorRating = '4.8',
    this.isFavorite = false,
  });

  @override
  State<SelectTimeScreen> createState() => _SelectTimeScreenState();
}

class _SelectTimeScreenState extends State<SelectTimeScreen> {
  int selectedDateIndex = 1; // 0: Today, 1: Tomorrow (Default to 1 like Figma)
  String? selectedTimeSlot = '2:00 PM'; // Default to 2:00 PM like Figma

  final List<String> afternoonSlots = [
    '1:00 PM',
    '1:30 PM',
    '2:00 PM',
    '2:30 PM',
    '3:00 PM',
    '3:30 PM',
    '4:00 PM'
  ];

  final List<String> eveningSlots = [
    '5:00 PM',
    '5:30 PM',
    '6:00 PM',
    '6:30 PM',
    '7:00 PM'
  ];

  void _onConfirmPressed(String dateFormatted) {
    if (selectedDateIndex == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لا توجد مواعيد متاحة في هذا اليوم، يرجى اختيار يوم آخر.'),
        ),
      );
      return;
    }

    if (selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى اختيار الموعد المناسب أولاً.'),
        ),
      );
      return;
    }

    // Show Thank You Popup Dialog exactly like Figma
    showThankYouDialog(
      context: context,
      doctorName: widget.doctorName,
      dateText: dateFormatted,
      timeSlot: selectedTimeSlot!,
      doctorImage: widget.doctorImage,
      doctorSpecialty: widget.doctorSpecialty,
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime nextDate = now.add(const Duration(days: 1));

    final String todayFormatted = 'Today, ${DateFormat('d MMM').format(now)}';
    final String nextDateFormatted = DateFormat('EEE, d MMM').format(nextDate);
    final String tomorrowFormatted =
        'Tomorrow, ${DateFormat('d MMM').format(nextDate)}';

    final String activeDateText =
        selectedDateIndex == 0 ? todayFormatted : tomorrowFormatted;

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
              initialIsFavorite: widget.isFavorite,
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
                      nextAvailableText:
                          'Next availability on $nextDateFormatted',
                      onNextAvailablePressed: () {
                        setState(() {
                          selectedDateIndex = 1;
                        });
                      },
                      onContactClinicPressed: () {},
                    )
                  : AvailableSlotsSection(
                      selectedDateTitle: tomorrowFormatted,
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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 52,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _onConfirmPressed(activeDateText),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
