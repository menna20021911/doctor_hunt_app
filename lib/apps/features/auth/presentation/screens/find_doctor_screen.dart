import 'package:flutter/material.dart';

import '../../../../generated/app_colore.dart';
import '../../../../generated/app_text.dart';
import '../../../../generated/image_assets.dart';
import '../../../../generated/style_atom.dart';
import '../screens/doctor_details_screen.dart';
import '../widgets/doctor_card_widget.dart';

class DoctorModel {
  final String name;
  final String specialty;
  final String image;
  final String price;
  final double rating;
  final String experience;
  final bool isFavorite;

  const DoctorModel({
    required this.name,
    required this.specialty,
    required this.image,
    required this.price,
    required this.rating,
    required this.experience,
    this.isFavorite = false,
  });
}

class FindDoctorsScreen extends StatelessWidget {
  const FindDoctorsScreen({super.key});

  // قائمة بيانات الأطباء
  static const List<DoctorModel> doctorsList = [
    DoctorModel(
      name: 'Dr. Shruti Kedia',
      specialty: AppText.dentistSpecialist,
      image: ImageAssets.drShrutiKedia,
      price: '28.00',
      rating: 4.5,
      experience: AppText.experienceYears,
      isFavorite: true,
    ),
    DoctorModel(
      name: 'Dr. Watamaniuk',
      specialty: AppText.doctorSearchHint,
      image: ImageAssets.drWatamaniuk,
      price: '25.00',
      rating: 4.0,
      experience: AppText.experienceYears,
    ),
    DoctorModel(
      name: 'Dr. Crownover',
      specialty: AppText.doctorSearchHint,
      image: ImageAssets.drCrownover,
      price: '30.00',
      rating: 5.0,
      experience: AppText.experienceYears,
      isFavorite: true,
    ),
    DoctorModel(
      name: 'Dr. Balestra',
      specialty: AppText.doctorSearchHint,
      image: ImageAssets.drBalestra,
      price: '22.00',
      rating: 3.8,
      experience: AppText.experienceYears,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeSurface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          AppText.findDoctors,
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
            ),
          );
        },
      ),
    );
  }
}