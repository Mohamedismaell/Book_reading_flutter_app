part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileSaving extends ProfileState {}

final class ProfileSaved extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final UserProfile userProfile;

  ProfileLoaded({required this.userProfile});
}

final class ProfileError extends ProfileState {
  final String message;

  ProfileError({required this.message});
}
