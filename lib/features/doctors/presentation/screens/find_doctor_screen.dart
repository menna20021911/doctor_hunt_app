import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/doctors_cubit.dart';
import '../widgets/doctor_card_widget.dart';
import '../../../booking/presentation/screens/select_time_screen.dart';
import 'doctor_details_screen.dart';

class FindDoctorsScreen extends StatelessWidget {
  const FindDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final allDoctors = context.watch<DoctorsCubit>().state;
    final doctorsList = allDoctors.where((d) => d.isActive).toList();

    return Scaffold(
      backgroundColor: AppColors.homeSurface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          context.tr('find_doctors'),
          style: AppTextStyles.sectionTitle,
        ),
        leading: const BackButton(color: AppColors.title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: doctorsList.length,
        itemBuilder: (context, index) {
          final doctor = doctorsList[index];

          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DoctorDetailsScreen(
                    doctorName: doctor.name,
                    doctorSpecialty: doctor.specialty,
                    doctorImage: doctor.image,
                    doctorPrice: doctor.price,
                    doctorRating: doctor.rating,
                  ),
                ),
              );
            },
            child: DoctorCardWidget(
              imagePath: doctor.image,
              name: doctor.name,
              specialty: doctor.specialty,
              experience: doctor.experience,
              isFavorite: doctor.isFavorite,
              onFavoriteToggle: () {
                context.read<DoctorsCubit>().toggleFavorite(doctor.name);
              },
              onBookNow: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SelectTimeScreen(
                      doctorName: doctor.name,
                      doctorSpecialty: doctor.specialty,
                      doctorImage: doctor.image,
                      doctorRating: doctor.rating.toString(),
                      isFavorite: doctor.isFavorite,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
