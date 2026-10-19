import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  void updateProfile({
    String? name,
    String? email,
    String? phone,
    String? image,
  }) {
    emit(state.copyWith(
      name: name,
      email: email,
      phone: phone,
      image: image,
    ));
  }
}
