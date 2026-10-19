import 'package:equatable/equatable.dart';

class AdminProfileModel extends Equatable {
  final String fullName;
  final String email;
  final String clinicLocation;
  final String photo;

  const AdminProfileModel({
    this.fullName = 'Ahmed Khaled',
    this.email = 'admin@doctorhunt.com',
    this.clinicLocation = 'DoctorHunt HQ Clinic',
    this.photo = '',
  });

  AdminProfileModel copyWith({
    String? fullName,
    String? email,
    String? clinicLocation,
    String? photo,
  }) {
    return AdminProfileModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      clinicLocation: clinicLocation ?? this.clinicLocation,
      photo: photo ?? this.photo,
    );
  }

  @override
  List<Object?> get props => [fullName, email, clinicLocation, photo];
}
