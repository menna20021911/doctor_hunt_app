import '../../../../core/error/result.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  Future<Result<UserEntity>> signIn({
    required String email,
    required String password,
  });

  Future<Result<void>> signOut();

  UserEntity? getCurrentUser();
}
