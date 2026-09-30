import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/service/auth_service.dart';
import 'auth_event.dart';
import 'app_auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AppAuthState> {
  final AuthService _authService;

  AuthBloc({AuthService? authService})
      : _authService = authService ?? AuthService(),
        super(AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AppAuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signUp(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
      );

      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(const AuthError('فشل إنشاء الحساب.'));
      }
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AppAuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signIn(
        email: event.email,
        password: event.password,
      );

      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(const AuthError('فشل تسجيل الدخول.'));
      }
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AppAuthState> emit,
  ) async {
    emit(AuthLoading());
    await _authService.signOut();
    emit(Unauthenticated());
  }
}