import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl({AuthRemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ?? AuthRemoteDataSourceImpl();

  @override
  Future<Result<UserEntity>> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final user = await _remoteDataSource.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );
      return Success(user);
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } catch (e) {
      return FailureResult(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );
      return Success(user);
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } catch (e) {
      return FailureResult(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await _remoteDataSource.signOut();
      return const Success(null);
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    } catch (e) {
      return FailureResult(ServerFailure(e.toString()));
    }
  }

  @override
  UserEntity? getCurrentUser() {
    return _remoteDataSource.getCurrentUser();
  }
}
