import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/image_assets.dart';
import '../../../appointments/data/models/appointment_model.dart';
import '../../../appointments/presentation/screens/appointments_screen.dart';

void showThankYouDialog({
  required BuildContext context,
  required String doctorName,
  required String dateText,
  required String timeSlot,
  String? doctorImage,
  String? doctorSpecialty,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    builder: (context) => ThankYouDialog(
      doctorName: doctorName,
      dateText: dateText,
      timeSlot: timeSlot,
      doctorImage: doctorImage,
      doctorSpecialty: doctorSpecialty,
    ),
  );
}

class ThankYouDialog extends StatelessWidget {
  final String doctorName;
  final String dateText;
  final String timeSlot;
  final String? doctorImage;
  final String? doctorSpecialty;

  const ThankYouDialog({
    super.key,
    required this.doctorName,
    required this.dateText,
    required this.timeSlot,
    this.doctorImage,
    this.doctorSpecialty,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Colors.white,
      elevation: 10,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Thumbs up circular icon
            Container(
              width: 110,
              height: 110,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F8F3),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.thumb_up_alt_rounded,
                  color: AppColors.primary,
                  size: 52,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Title
            const Text(
              'Thank You !',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.title,
              ),
            ),
            const SizedBox(height: 10),

            // Subtitle
            const Text(
              'Your Appointment Successful',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.body,
              ),
            ),
            const SizedBox(height: 20),

            // Dynamic appointment details
            Text(
              'You booked an appointment with $doctorName on $dateText, at $timeSlot',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.body,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),

            // Done Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => AppointmentsScreen(
                        newAppointment: AppointmentModel(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          doctorName: doctorName,
                          doctorSpecialty:
                              doctorSpecialty ?? 'Specialist Consultation',
                          doctorImage: doctorImage ?? ImageAssets.doctor1,
                          date: dateText,
                          time: timeSlot,
                          fee: '\$30.00',
                          status: AppointmentStatus.upcoming,
                        ),
                      ),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
