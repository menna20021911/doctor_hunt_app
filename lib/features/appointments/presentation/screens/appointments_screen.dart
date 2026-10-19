import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/image_assets.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../doctors/presentation/screens/favourite_doctors_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../data/models/appointment_model.dart';
import '../cubit/appointments_cubit.dart';
import '../widgets/appointment_card_widget.dart';

class AppointmentsScreen extends StatefulWidget {
  final int initialTabIndex; // 0: Upcoming, 1: Completed, 2: Cancelled
  final AppointmentModel? newAppointment;

  const AppointmentsScreen({
    super.key,
    this.initialTabIndex = 0,
    this.newAppointment,
  });

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  late int _selectedTabIndex;

  @override
  void initState() {
    super.initState();
    _selectedTabIndex = widget.initialTabIndex;

    if (widget.newAppointment != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<AppointmentsCubit>().addAppointment(widget.newAppointment!);
      });
    }
  }

  List<AppointmentModel> _currentAppointments(List<AppointmentModel> appointments) {
    switch (_selectedTabIndex) {
      case 0:
        return appointments
            .where((a) => a.status == AppointmentStatus.upcoming)
            .toList();
      case 1:
        return appointments
            .where((a) => a.status == AppointmentStatus.completed)
            .toList();
      case 2:
        return appointments
            .where((a) => a.status == AppointmentStatus.cancelled)
            .toList();
      default:
        return [];
    }
  }

  void _cancelAppointment(AppointmentModel appointment) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Appointment'),
        content: Text(
            'Are you sure you want to cancel your appointment with ${appointment.doctorName}?'),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('No'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cancelRed,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              context
                  .read<AppointmentsCubit>()
                  .cancelAppointment(appointment.id);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Appointment has been cancelled.')),
              );
            },
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  void _rateDoctor(AppointmentModel appointment) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('Thank you for rating ${appointment.doctorName}!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allAppointments = context.watch<AppointmentsCubit>().state;
    final filteredList = _currentAppointments(allAppointments);

    return Scaffold(
      backgroundColor: AppColors.homeSurface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.title, size: 20),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            }
          },
        ),
        title: Text(
          context.tr('appointments'),
          style: const TextStyle(
            color: AppColors.title,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          // Segmented Tabs Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildTabItem(title: context.tr('upcoming'), index: 0),
                const SizedBox(width: 8),
                _buildTabItem(title: context.tr('completed'), index: 1),
                const SizedBox(width: 8),
                _buildTabItem(title: context.tr('cancelled'), index: 2),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Appointments Cards List
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Text(
                      'No ${_getTabName(_selectedTabIndex)} appointments',
                      style: const TextStyle(color: AppColors.body, fontSize: 14),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final apt = filteredList[index];
                      return AppointmentCardWidget(
                        appointment: apt,
                        onViewDetails: () {},
                        onCancel: () => _cancelAppointment(apt),
                        onRate: () => _rateDoctor(apt),
                        onRatingChanged: (newRating) {
                          context
                              .read<AppointmentsCubit>()
                              .addReview(apt.id, newRating, '');
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 2),
    );
  }

  String _getTabName(int index) {
    switch (index) {
      case 0:
        return 'upcoming';
      case 1:
        return 'completed';
      case 2:
        return 'cancelled';
      default:
        return '';
    }
  }

  Widget _buildTabItem({required String title, required int index}) {
    final isSelected = _selectedTabIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTabIndex = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.tabInactive,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.primary,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
