import 'package:equatable/equatable.dart';
import 'doctor_availability_model.dart';

class DoctorModel extends Equatable {
  final String name;
  final String specialty;
  final String image;
  final String price;
  final double rating;
  final String experience;
  final bool isFavorite;
  final bool isActive;
  final int reviewsCount;
  final DoctorAvailabilityModel? availability;

  const DoctorModel({
    required this.name,
    required this.specialty,
    required this.image,
    required this.price,
    required this.rating,
    this.experience = '5 Years experience',
    this.isFavorite = false,
    this.isActive = true,
    this.reviewsCount = 24,
    this.availability,
  });

  DoctorModel copyWith({
    String? name,
    String? specialty,
    String? image,
    String? price,
    double? rating,
    String? experience,
    bool? isFavorite,
    bool? isActive,
    int? reviewsCount,
    DoctorAvailabilityModel? availability,
  }) {
    return DoctorModel(
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      image: image ?? this.image,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      experience: experience ?? this.experience,
      isFavorite: isFavorite ?? this.isFavorite,
      isActive: isActive ?? this.isActive,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      availability: availability ?? this.availability,
    );
  }

  @override
  List<Object?> get props => [
        name,
        specialty,
        image,
        price,
        rating,
        experience,
        isFavorite,
        isActive,
        reviewsCount,
        availability,
      ];
}
