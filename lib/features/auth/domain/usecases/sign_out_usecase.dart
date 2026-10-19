import '../../../../core/error/result.dart';
import '../repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<Result<void>> call() {
    return _repository.signOut();
  }
}
