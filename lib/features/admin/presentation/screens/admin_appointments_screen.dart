import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../appointments/data/models/appointment_model.dart';
import '../../../appointments/presentation/cubit/appointments_cubit.dart';
import '../widgets/admin_app_bar.dart';
import '../widgets/admin_appointment_card.dart';

class AdminAppointmentsScreen extends StatefulWidget {
  const AdminAppointmentsScreen({super.key});

  @override
  State<AdminAppointmentsScreen> createState() =>
      _AdminAppointmentsScreenState();
}

class _AdminAppointmentsScreenState extends State<AdminAppointmentsScreen> {
  int _selectedTabIndex = 0; // 0: Upcoming, 1: Completed, 2: Cancelled

  @override
  Widget build(BuildContext context) {
    final appointments = context.watch<AppointmentsCubit>().state;

    final upcoming = appointments
        .where((a) => a.status == AppointmentStatus.upcoming)
        .toList();
    final completed = appointments
        .where((a) => a.status == AppointmentStatus.completed)
        .toList();
    final cancelled = appointments
        .where((a) => a.status == AppointmentStatus.cancelled)
        .toList();

    List<AppointmentModel> displayedList;
    if (_selectedTabIndex == 0) {
      displayedList = upcoming;
    } else if (_selectedTabIndex == 1) {
      displayedList = completed;
    } else {
      displayedList = cancelled;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AdminAppBar(title: 'Appointments'),
      body: Column(
        children: [
          // Segmented Tabs Pill matching Figma Screenshot 4
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F9F1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _TabPill(
                    title: 'Upcoming',
                    count: upcoming.length,
                    isSelected: _selectedTabIndex == 0,
                    onTap: () => setState(() => _selectedTabIndex = 0),
                  ),
                  _TabPill(
                    title: 'Completed',
                    count: completed.length,
                    isSelected: _selectedTabIndex == 1,
                    onTap: () => setState(() => _selectedTabIndex = 1),
                  ),
                  _TabPill(
                    title: 'Cancelled',
                    count: cancelled.length,
                    isSelected: _selectedTabIndex == 2,
                    onTap: () => setState(() => _selectedTabIndex = 2),
                  ),
                ],
              ),
            ),
          ),

          // Appointment list
          Expanded(
            child: displayedList.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event_busy_rounded,
                            size: 64,
                            color: const Color(0xFFC5CEE0).withValues(alpha: 0.6),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            _selectedTabIndex == 0
                                ? 'No Upcoming Appointments'
                                : _selectedTabIndex == 1
                                    ? 'No Completed Appointments'
                                    : 'No Cancelled Appointments',
                            style: const TextStyle(
                              color: Color(0xFF222B45),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                    itemCount: displayedList.length,
                    itemBuilder: (context, index) {
                      final apt = displayedList[index];
                      return AdminAppointmentCard(
                        appointment: apt,
                        onCancel: () {
                          context
                              .read<AppointmentsCubit>()
                              .cancelAppointment(apt.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Appointment for ${apt.patientName} cancelled'),
                              backgroundColor: const Color(0xFFEA3B3B),
                            ),
                          );
                        },
                        onMarkCompleted: () {
                          context
                              .read<AppointmentsCubit>()
                              .markAppointmentCompleted(apt.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Appointment for ${apt.patientName} marked as completed'),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        },
                        onViewDetails: () {
                          _showAppointmentDetailsModal(context, apt);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showAppointmentDetailsModal(
      BuildContext context, AppointmentModel apt) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.white,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EDF1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Appointment Details',
              style: TextStyle(
                color: Color(0xFF222B45),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _modalRow('Patient', apt.patientName),
            _modalRow('Phone', apt.patientPhone),
            _modalRow('Email', apt.patientEmail),
            _modalRow('Doctor', apt.doctorName),
            _modalRow('Specialty', apt.doctorSpecialty),
            _modalRow('Date & Time', '${apt.date} · ${apt.time}'),
            _modalRow('Fee', apt.fee),
            _modalRow('Status', apt.status.label),
            if (apt.reviewComment != null)
              _modalRow('Review', '${apt.rating} ★ · "${apt.reviewComment}"'),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Close',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _modalRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  color: Color(0xFF8F9BB3), fontSize: 13)),
          Text(value,
              style: const TextStyle(
                  color: Color(0xFF222B45),
                  fontWeight: FontWeight.w600,
                  fontSize: 13)),
        ],
      ),
    );
  }
}

class _TabPill extends StatelessWidget {
  final String title;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabPill({
    required this.title,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            '$title ($count)',
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF677294),
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
