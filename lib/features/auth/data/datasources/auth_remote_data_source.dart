import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/network/supabase_client.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  UserModel? getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _client;

  AuthRemoteDataSourceImpl({SupabaseClient? client})
      : _client = client ?? SupabaseClientProvider.client;

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName},
    );

    final user = response.user;
    if (user == null) {
      throw const AuthException('تعذر إنشاء الحساب');
    }
    return UserModel.fromSupabaseUser(user);
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user == null) {
      throw const AuthException('تعذر تسجيل الدخول');
    }
    return UserModel.fromSupabaseUser(user);
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  UserModel? getCurrentUser() {
    final user = _client.auth.currentUser;
    return user != null ? UserModel.fromSupabaseUser(user) : null;
  }
}
