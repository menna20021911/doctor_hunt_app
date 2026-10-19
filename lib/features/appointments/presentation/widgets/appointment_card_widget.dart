import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/appointment_model.dart';

class AppointmentCardWidget extends StatefulWidget {
  final AppointmentModel appointment;
  final VoidCallback? onViewDetails;
  final VoidCallback? onCancel;
  final VoidCallback? onRate;
  final ValueChanged<double>? onRatingChanged;

  const AppointmentCardWidget({
    super.key,
    required this.appointment,
    this.onViewDetails,
    this.onCancel,
    this.onRate,
    this.onRatingChanged,
  });

  @override
  State<AppointmentCardWidget> createState() => _AppointmentCardWidgetState();
}

class _AppointmentCardWidgetState extends State<AppointmentCardWidget> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.appointment.rating;
  }

  @override
  Widget build(BuildContext context) {
    final apt = widget.appointment;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFF2F5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor Info + Status Badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  apt.doctorImage,
                  width: 54,
                  height: 54,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      apt.doctorName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.title,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      apt.doctorSpecialty,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.body,
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(apt.status),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFF1F4F7), height: 1),
          const SizedBox(height: 14),

          // Date & Time & Fee
          Row(
            children: [
              // Left Column (Date & Fee)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoItem(
                      icon: Icons.calendar_today_outlined,
                      label: 'Appointment date',
                      value: apt.date,
                    ),
                    const SizedBox(height: 12),
                    _buildInfoItem(
                      icon: Icons.monetization_on_outlined,
                      label: 'Consultation fee',
                      value: apt.fee,
                      isValueBold: true,
                    ),
                  ],
                ),
              ),

              // Right Column (Time)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoItem(
                      icon: Icons.access_time_outlined,
                      label: 'Appointment time',
                      value: apt.time,
                    ),
                    const SizedBox(height: 36), // Alignment spacing
                  ],
                ),
              ),
            ],
          ),

          // Rating row if Completed
          if (apt.status == AppointmentStatus.completed) ...[
            const SizedBox(height: 12),
            const Divider(color: Color(0xFFF1F4F7), height: 1),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tap to rate your visit',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.body,
                  ),
                ),
                Row(
                  children: List.generate(5, (index) {
                    final starIndex = index + 1;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _rating = starIndex.toDouble());
                        widget.onRatingChanged?.call(_rating);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Icon(
                          starIndex <= _rating
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          color: AppColors.rating,
                          size: 20,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ],

          const SizedBox(height: 16),

          // Action Buttons
          _buildActionButtons(apt.status),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(AppointmentStatus status) {
    Color bg;
    Color dotColor;
    Color textColor;

    switch (status) {
      case AppointmentStatus.upcoming:
        bg = AppColors.badgeGreenBg;
        dotColor = AppColors.primary;
        textColor = AppColors.primary;
        break;
      case AppointmentStatus.completed:
        bg = AppColors.badgeGreenBg;
        dotColor = AppColors.primary;
        textColor = AppColors.primary;
        break;
      case AppointmentStatus.cancelled:
        bg = AppColors.cancelRedBg;
        dotColor = AppColors.cancelRed;
        textColor = AppColors.cancelRed;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            status.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    bool isValueBold = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.badgeGreenBg,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 15, color: AppColors.primary),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.body,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isValueBold ? FontWeight.bold : FontWeight.w600,
                  color: AppColors.title,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.upcoming:
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: widget.onViewDetails,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: const Text(
                  'View Details',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: widget.onCancel,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.cancelRed),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: const Text(
                  'Cancel Appointment',
                  style: TextStyle(
                    color: AppColors.cancelRed,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        );

      case AppointmentStatus.completed:
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: widget.onViewDetails,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: const Text(
                  'View Details',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: widget.onRate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: const Text(
                  'Rate Doctor',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        );

      case AppointmentStatus.cancelled:
        return SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: widget.onViewDetails,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: const Size(double.infinity, 40),
            ),
            child: const Text(
              'View Details',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        );
    }
  }
}
