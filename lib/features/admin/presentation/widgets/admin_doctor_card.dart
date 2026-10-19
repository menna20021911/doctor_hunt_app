import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/image_assets.dart';
import '../../../doctors/data/models/doctor_model.dart';

class AdminDoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  final VoidCallback onTap;

  const AdminDoctorCard({
    super.key,
    required this.doctor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                // Doctor Photo
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 58,
                    height: 58,
                    color: const Color(0xFFF4F6F8),
                    child: doctor.image.isNotEmpty
                        ? Image.asset(
                            doctor.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              ImageAssets.drAhmedAli,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => const Icon(
                                Icons.person,
                                color: Color(0xFF8F9BB3),
                                size: 30,
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            color: Color(0xFF8F9BB3),
                            size: 30,
                          ),
                  ),
                ),
                const SizedBox(width: 14),

                // Doctor Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF222B45),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        doctor.specialty,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF8F9BB3),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFFAE33),
                            size: 16,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${doctor.rating} · ${doctor.reviewsCount} reviews',
                            style: const TextStyle(
                              color: Color(0xFF8F9BB3),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Status Badge (Active / Inactive)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: doctor.isActive
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
                          color: doctor.isActive
                              ? AppColors.primary
                              : const Color(0xFFEA3B3B),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        doctor.isActive ? 'Active' : 'Inactive',
                        style: TextStyle(
                          color: doctor.isActive
                              ? AppColors.primary
                              : const Color(0xFFEA3B3B),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
