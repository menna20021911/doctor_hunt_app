import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_text.dart';
import '../../../../core/constants/image_assets.dart';
import '../../data/models/doctor_availability_model.dart';
import '../../data/models/doctor_model.dart';

class DoctorsCubit extends Cubit<List<DoctorModel>> {
  DoctorsCubit() : super(_initialDoctors);

  static final List<DoctorModel> _initialDoctors = [
    DoctorModel(
      name: 'Dr. Ahmed Ali',
      specialty: 'Cardiology',
      image: ImageAssets.drAhmedAli,
      price: '28.00',
      rating: 4.8,
      reviewsCount: 128,
      isActive: true,
      availability: DoctorAvailabilityModel.defaultAvailability(),
    ),
    DoctorModel(
      name: 'Dr. Sara Mohamed',
      specialty: 'Orthopedic',
      image: ImageAssets.doctor2,
      price: '30.00',
      rating: 4.7,
      reviewsCount: 56,
      isActive: true,
      availability: DoctorAvailabilityModel.defaultAvailability(),
    ),
    DoctorModel(
      name: 'Dr. Mostafa Hassan',
      specialty: 'Dermatologist',
      image: ImageAssets.doctor3,
      price: '24.00',
      rating: 4.3,
      reviewsCount: 34,
      isActive: false, // Inactive doctor matching Figma list
      availability: DoctorAvailabilityModel.defaultAvailability(),
    ),
    DoctorModel(
      name: 'Dr. Nouran Samir',
      specialty: 'Pediatrician',
      image: ImageAssets.drPediatrician,
      price: '26.00',
      rating: 4.9,
      reviewsCount: 212,
      isActive: true,
      availability: DoctorAvailabilityModel.defaultAvailability(),
    ),
    DoctorModel(
      name: 'Dr. Shruti Kedia',
      specialty: AppText.dentistSpecialist,
      image: ImageAssets.drShrutiKedia,
      price: '28.00',
      rating: 4.5,
      reviewsCount: 24,
      isFavorite: true,
      isActive: true,
      availability: DoctorAvailabilityModel.defaultAvailability(),
    ),
    DoctorModel(
      name: 'Dr. Watamaniuk',
      specialty: AppText.doctorSearchHint,
      image: ImageAssets.drWatamaniuk,
      price: '25.00',
      rating: 4.0,
      reviewsCount: 18,
      isFavorite: false,
      isActive: true,
      availability: DoctorAvailabilityModel.defaultAvailability(),
    ),
    DoctorModel(
      name: 'Dr. Crownover',
      specialty: AppText.doctorSearchHint,
      image: ImageAssets.drCrownover,
      price: '30.00',
      rating: 5.0,
      reviewsCount: 42,
      isFavorite: true,
      isActive: true,
      availability: DoctorAvailabilityModel.defaultAvailability(),
    ),
    DoctorModel(
      name: 'Dr. Balestra',
      specialty: AppText.doctorSearchHint,
      image: ImageAssets.drBalestra,
      price: '22.00',
      rating: 3.8,
      reviewsCount: 15,
      isFavorite: false,
      isActive: true,
      availability: DoctorAvailabilityModel.defaultAvailability(),
    ),
  ];

  void addDoctor(DoctorModel doctor) {
    emit([doctor, ...state]);
  }

  void updateDoctor(String originalName, DoctorModel updatedDoctor) {
    final updatedList = state.map((doctor) {
      if (doctor.name == originalName) {
        return updatedDoctor;
      }
      return doctor;
    }).toList();
    emit(updatedList);
  }

  void toggleDoctorActive(String doctorName) {
    final updatedList = state.map((doctor) {
      if (doctor.name == doctorName) {
        return doctor.copyWith(isActive: !doctor.isActive);
      }
      return doctor;
    }).toList();
    emit(updatedList);
  }

  void setDoctorActive(String doctorName, bool isActive) {
    final updatedList = state.map((doctor) {
      if (doctor.name == doctorName) {
        return doctor.copyWith(isActive: isActive);
      }
      return doctor;
    }).toList();
    emit(updatedList);
  }

  void deleteDoctor(String doctorName) {
    final updatedList = state.where((d) => d.name != doctorName).toList();
    emit(updatedList);
  }

  void updateDoctorAvailability(
    String doctorName,
    DoctorAvailabilityModel availability,
  ) {
    final updatedList = state.map((doctor) {
      if (doctor.name == doctorName) {
        return doctor.copyWith(availability: availability);
      }
      return doctor;
    }).toList();
    emit(updatedList);
  }

  void toggleFavorite(String doctorName) {
    final updated = state.map((doctor) {
      if (doctor.name == doctorName) {
        return doctor.copyWith(isFavorite: !doctor.isFavorite);
      }
      return doctor;
    }).toList();

    emit(updated);
  }

  bool isDoctorFavorite(String doctorName) {
    final doc = state.cast<DoctorModel?>().firstWhere(
          (d) => d?.name == doctorName,
          orElse: () => null,
        );
    return doc?.isFavorite ?? false;
  }

  DoctorModel? getDoctorByName(String doctorName) {
    return state.cast<DoctorModel?>().firstWhere(
          (d) => d?.name == doctorName,
          orElse: () => null,
        );
  }
}
