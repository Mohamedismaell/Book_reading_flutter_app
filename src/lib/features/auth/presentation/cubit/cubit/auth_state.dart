part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthNone extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthVerification extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthForgetPassword extends AuthState {}

final class AuthUpdatePassword extends AuthState {}

final class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}

// final class AuthRequestPassword extends AuthState {
//   final UserApp user;
//   AuthRequestPassword({required this.user});
// }
