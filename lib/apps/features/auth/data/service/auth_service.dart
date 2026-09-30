import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../main.dart';

class AuthService {
  Future<User?> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName},
    );
    return response.user;
  }

  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response.user;
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  User? get currentUser => supabase.auth.currentUser;
}