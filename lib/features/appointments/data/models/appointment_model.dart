import '../../../../core/constants/image_assets.dart';

enum AppointmentStatus {
  upcoming('Upcoming'),
  completed('Completed'),
  cancelled('Cancelled');

  final String label;
  const AppointmentStatus(this.label);
}

class AppointmentModel {
  final String id;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorImage;
  final String date;
  final String time;
  final String fee;
  final AppointmentStatus status;
  final double rating;
  final String patientName;
  final String patientImage;
  final String patientPhone;
  final String patientEmail;
  final String? reviewComment;

  const AppointmentModel({
    required this.id,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorImage,
    required this.date,
    required this.time,
    required this.fee,
    required this.status,
    this.rating = 0.0,
    this.patientName = 'Maya Patel',
    this.patientImage = ImageAssets.PatientAvatar1,
    this.patientPhone = '+20 100 123 4567',
    this.patientEmail = 'patient@doctorhunt.com',
    this.reviewComment,
  });

  AppointmentModel copyWith({
    String? id,
    String? doctorName,
    String? doctorSpecialty,
    String? doctorImage,
    String? date,
    String? time,
    String? fee,
    AppointmentStatus? status,
    double? rating,
    String? patientName,
    String? patientImage,
    String? patientPhone,
    String? patientEmail,
    String? reviewComment,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      doctorName: doctorName ?? this.doctorName,
      doctorSpecialty: doctorSpecialty ?? this.doctorSpecialty,
      doctorImage: doctorImage ?? this.doctorImage,
      date: date ?? this.date,
      time: time ?? this.time,
      fee: fee ?? this.fee,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      patientName: patientName ?? this.patientName,
      patientImage: patientImage ?? this.patientImage,
      patientPhone: patientPhone ?? this.patientPhone,
      patientEmail: patientEmail ?? this.patientEmail,
      reviewComment: reviewComment ?? this.reviewComment,
    );
  }
}
