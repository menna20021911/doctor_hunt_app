import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AppAuthState extends Equatable {
  const AppAuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AppAuthState {}

class AuthLoading extends AppAuthState {}

class Authenticated extends AppAuthState {
  final User user;
  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AppAuthState {}

class AuthError extends AppAuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}