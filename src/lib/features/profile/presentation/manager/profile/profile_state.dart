// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final String? imagePath;

  const ProfileState({this.imagePath});
  @override
  List<Object?> get props => [imagePath];

  ProfileState copyWith({String? imagePath}) {
    return ProfileState(imagePath: imagePath ?? this.imagePath);
  }

  @override
  bool get stringify => true;
}
