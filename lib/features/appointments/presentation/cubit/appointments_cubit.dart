import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/image_assets.dart';
import '../../data/models/appointment_model.dart';

class AppointmentsCubit extends Cubit<List<AppointmentModel>> {
  AppointmentsCubit() : super(_initialAppointments);

  static final List<AppointmentModel> _initialAppointments = [
    const AppointmentModel(
      id: '1',
      doctorName: 'Dr. Ananya Shah',
      doctorSpecialty: 'Specialist Cardiologist',
      doctorImage: ImageAssets.doctor1,
      date: '02 Oct 2026',
      time: '10:30 AM',
      fee: '\$28.00',
      status: AppointmentStatus.upcoming,
      patientName: 'Maya Patel',
      patientImage: ImageAssets.PatientAvatar1,
      patientPhone: '+20 101 234 5678',
      patientEmail: 'maya.patel@example.com',
    ),
    const AppointmentModel(
      id: '2',
      doctorName: 'Dr. Shruti Kedia',
      doctorSpecialty: 'Specialist Dentist',
      doctorImage: ImageAssets.drShrutiKedia,
      date: '08 Oct 2026',
      time: '02:00 PM',
      fee: '\$32.00',
      status: AppointmentStatus.upcoming,
      patientName: 'James Wilson',
      patientImage: ImageAssets.PatientAvatar2,
      patientPhone: '+20 102 345 6789',
      patientEmail: 'james.wilson@example.com',
    ),
    const AppointmentModel(
      id: '3',
      doctorName: 'Dr. Sarah Tranquilli',
      doctorSpecialty: 'Internal Medicine',
      doctorImage: ImageAssets.doctor2,
      date: '21 Sep 2026',
      time: '09:00 AM',
      fee: '\$30.00',
      status: AppointmentStatus.completed,
      rating: 4.8,
      reviewComment: 'Very professional and kind.',
      patientName: 'Olivia Martin',
      patientImage: ImageAssets.PatientAvatar3,
      patientPhone: '+20 103 456 7890',
      patientEmail: 'olivia.martin@example.com',
    ),
    const AppointmentModel(
      id: '4',
      doctorName: 'Dr. Michael Bonebrake',
      doctorSpecialty: 'Specialist Dentist',
      doctorImage: ImageAssets.doctor3,
      date: '12 Sep 2026',
      time: '04:30 PM',
      fee: '\$24.00',
      status: AppointmentStatus.completed,
      rating: 5.0,
      reviewComment: 'Clear and reassuring.',
      patientName: 'Daniel Kim',
      patientImage: ImageAssets.PatientAvatar4,
      patientPhone: '+20 104 567 8901',
      patientEmail: 'daniel.kim@example.com',
    ),
    const AppointmentModel(
      id: '5',
      doctorName: 'Dr. Ahmed Ali',
      doctorSpecialty: 'Cardiologist',
      doctorImage: ImageAssets.drAhmedAli,
      date: '01 Sep 2026',
      time: '11:00 AM',
      fee: '\$28.00',
      status: AppointmentStatus.cancelled,
      patientName: 'Amr Nabil',
      patientImage: ImageAssets.PatientAvatar5,
      patientPhone: '+20 105 678 9012',
      patientEmail: 'amr.nabil@example.com',
    ),
  ];

  void addAppointment(AppointmentModel appointment) {
    emit([appointment, ...state]);
  }

  void cancelAppointment(String appointmentId) {
    final updated = state.map((apt) {
      if (apt.id == appointmentId) {
        return apt.copyWith(status: AppointmentStatus.cancelled);
      }
      return apt;
    }).toList();
    emit(updated);
  }

  void markAppointmentCompleted(String appointmentId) {
    final updated = state.map((apt) {
      if (apt.id == appointmentId) {
        return apt.copyWith(status: AppointmentStatus.completed);
      }
      return apt;
    }).toList();
    emit(updated);
  }

  void addReview(String appointmentId, double rating, String comment) {
    final updated = state.map((apt) {
      if (apt.id == appointmentId) {
        return apt.copyWith(
          rating: rating,
          reviewComment: comment,
        );
      }
      return apt;
    }).toList();
    emit(updated);
  }
}
