import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthBloc({
    SignInUseCase? signInUseCase,
    SignUpUseCase? signUpUseCase,
    SignOutUseCase? signOutUseCase,
    GetCurrentUserUseCase? getCurrentUserUseCase,
  })  : _signInUseCase = signInUseCase ?? SignInUseCase(AuthRepositoryImpl()),
        _signUpUseCase = signUpUseCase ?? SignUpUseCase(AuthRepositoryImpl()),
        _signOutUseCase = signOutUseCase ?? SignOutUseCase(AuthRepositoryImpl()),
        _getCurrentUserUseCase =
            getCurrentUserUseCase ?? GetCurrentUserUseCase(AuthRepositoryImpl()),
        super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<CheckAuthStatusRequested>(_onCheckAuthStatusRequested);
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _signUpUseCase(
      email: event.email,
      password: event.password,
      fullName: event.fullName,
    );

    result.when(
      success: (user) => emit(Authenticated(user)),
      failure: (failure) => emit(AuthError(failure.message)),
    );
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _signInUseCase(
      email: event.email,
      password: event.password,
    );

    result.when(
      success: (user) => emit(Authenticated(user)),
      failure: (failure) => emit(AuthError(failure.message)),
    );
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _signOutUseCase();
    result.when(
      success: (_) => emit(Unauthenticated()),
      failure: (failure) => emit(AuthError(failure.message)),
    );
  }

  void _onCheckAuthStatusRequested(
    CheckAuthStatusRequested event,
    Emitter<AuthState> emit,
  ) {
    final user = _getCurrentUserUseCase();
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }
}
