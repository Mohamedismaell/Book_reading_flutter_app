import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:bookreading/features/auth/data/models/user_app.dart';
import 'package:bookreading/features/book/domain/usecases/get_user_profile.dart';
import 'package:bookreading/features/book/domain/usecases/update_user_profile.dart';
import 'package:bookreading/features/book/data/models/profile_draft.dart';
import 'package:meta/meta.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.getUserProfile, this.updateUserProfile)
    : super(ProfileInitial());
  final UpdateUserProfile updateUserProfile;
  final GetUserProfile getUserProfile;
  final ProfileModel profileModel = const ProfileModel();

  void updateDraft({
    File? avatarFile,
    String? language,
    double? textScale,
    bool? darkMode,
  }) {
    profileModel.copyWith(
      avatarFile: avatarFile,
      language: language,
      textScale: textScale,
      darkMode: darkMode,
    );
  }

  Future<void> saveProfile() async {
    if (profileModel.hasChanges) return;
    emit(ProfileSaving());
    await updateUserProfile.call(
      avatarFile: profileModel.avatarFile,
      language: profileModel.language,
      textScale: profileModel.textScale,
      darkMode: profileModel.darkMode,
    );

    emit(ProfileLoading());
    final result = await getUserProfile.call();
    result.when(
      success: (userProfile) => emit(ProfileLoaded(userProfile: userProfile)),
      failure: (error) => emit(ProfileError(message: error.errMessage)),
    );
  }
}
