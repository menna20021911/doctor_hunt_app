import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/admin_profile_model.dart';

class AdminCubit extends Cubit<AdminProfileModel> {
  AdminCubit() : super(const AdminProfileModel());

  void updateProfile({
    String? fullName,
    String? email,
    String? clinicLocation,
    String? photo,
  }) {
    emit(state.copyWith(
      fullName: fullName,
      email: email,
      clinicLocation: clinicLocation,
      photo: photo,
    ));
  }

  void updateClinicLocation(String newLocation) {
    emit(state.copyWith(clinicLocation: newLocation));
  }
}
