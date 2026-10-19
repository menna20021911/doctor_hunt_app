import '../../../../core/error/result.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<Result<UserEntity>> call({
    required String email,
    required String password,
    required String fullName,
  }) {
    return _repository.signUp(
      email: email,
      password: password,
      fullName: fullName,
    );
  }
}
