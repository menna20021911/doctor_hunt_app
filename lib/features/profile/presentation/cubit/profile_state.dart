import 'package:equatable/equatable.dart';

import '../../../../core/constants/image_assets.dart';

class ProfileState extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String image;

  const ProfileState({
    this.name = 'menna',
    this.email = 'menna@doctorhunt.com',
    this.phone = '+8801800000000',
    this.image = ImageAssets.userProfile,
  });

  ProfileState copyWith({
    String? name,
    String? email,
    String? phone,
    String? image,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [name, email, phone, image];
}
