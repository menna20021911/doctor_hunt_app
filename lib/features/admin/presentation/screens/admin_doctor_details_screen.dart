import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/image_assets.dart';
import '../../../doctors/data/models/doctor_model.dart';
import '../../../doctors/presentation/cubit/doctors_cubit.dart';
import 'admin_doctor_availability_screen.dart';
import 'admin_edit_doctor_screen.dart';

class AdminDoctorDetailsScreen extends StatelessWidget {
  final DoctorModel doctor;

  const AdminDoctorDetailsScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    // Watch doctor from cubit to receive updates in real-time
    final currentDoctor = context.select<DoctorsCubit, DoctorModel>(
      (cubit) => cubit.getDoctorByName(doctor.name) ?? doctor,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF222B45),
            size: 18,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Doctor Details',
          style: TextStyle(
            color: Color(0xFF222B45),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded,
                color: Color(0xFF222B45)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Profile photo with status badge
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: const Color(0xFFF4F6F8),
                    child: currentDoctor.image.isNotEmpty
                        ? Image.asset(
                            currentDoctor.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              ImageAssets.drAhmedAli,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => const Icon(
                                Icons.person,
                                size: 50,
                                color: Color(0xFF8F9BB3),
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            size: 50,
                            color: Color(0xFF8F9BB3),
                          ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: currentDoctor.isActive
                          ? AppColors.primary
                          : const Color(0xFFEA3B3B),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      currentDoctor.isActive ? Icons.check : Icons.close,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Doctor Name
            Text(
              currentDoctor.name,
              style: const TextStyle(
                color: Color(0xFF222B45),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            // Status Badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: currentDoctor.isActive
                    ? const Color(0xFFE8F9F1)
                    : const Color(0xFFFFEEEE),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: currentDoctor.isActive
                          ? AppColors.primary
                          : const Color(0xFFEA3B3B),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    currentDoctor.isActive ? 'Active' : 'Inactive',
                    style: TextStyle(
                      color: currentDoctor.isActive
                          ? AppColors.primary
                          : const Color(0xFFEA3B3B),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Info Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE8EDF1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _DetailRow(
                    icon: Icons.medical_services_outlined,
                    label: 'Specialty',
                    value: currentDoctor.specialty,
                  ),
                  const Divider(height: 24, color: Color(0xFFF2F4F7)),
                  _DetailRow(
                    icon: Icons.star_border_rounded,
                    label: 'Rating',
                    value:
                        '${currentDoctor.rating} · ${currentDoctor.reviewsCount} reviews',
                    valueWidget: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded,
                            color: Color(0xFFFFAE33), size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${currentDoctor.rating} · ${currentDoctor.reviewsCount} reviews',
                          style: const TextStyle(
                            color: Color(0xFF222B45),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 24, color: Color(0xFFF2F4F7)),
                  _DetailRow(
                    icon: Icons.attach_money_rounded,
                    label: 'Consultation Fee',
                    value: '\$${currentDoctor.price.replaceAll('\$', '')}',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Edit Doctor Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          AdminEditDoctorScreen(doctor: currentDoctor),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(Icons.edit_outlined,
                    color: Colors.white, size: 18),
                label: const Text(
                  'Edit Doctor',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Manage Availability Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AdminDoctorAvailabilityScreen(
                          doctor: currentDoctor),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.calendar_today_outlined,
                    color: AppColors.primary, size: 18),
                label: const Text(
                  'Manage Availability',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 15,
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

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Widget? valueWidget;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary, size: 18),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8F9BB3),
            fontSize: 13,
          ),
        ),
        const Spacer(),
        valueWidget ??
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF222B45),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
      ],
    );
  }
}
