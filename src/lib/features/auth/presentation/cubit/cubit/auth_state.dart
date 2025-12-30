part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthVerification extends AuthState {
  final UserApp user;
  AuthVerification({required this.user});
}

final class AuthSuccess extends AuthState {
  final UserApp user;
  AuthSuccess({required this.user});
}

final class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}

// final class AuthRequestPassword extends AuthState {
//   final UserApp user;
//   AuthRequestPassword({required this.user});
// }
