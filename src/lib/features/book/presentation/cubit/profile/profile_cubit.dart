import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bookreading/features/book/domain/usecases/save_user_profile.dart';
import 'package:bookreading/features/book/presentation/models/profile_draft.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.saveUserProfile) : super(ProfileInitial());
  final SaveUserProfile saveUserProfile;
  final ProfileDraftModel profileDraftModel = const ProfileDraftModel();

  void updateDraft({
    File? avatarFile,
    String? language,
    double? textScale,
    bool? darkMode,
  }) {
    profileDraftModel.copyWith(
      avatarFile: avatarFile,
      language: language,
      textScale: textScale,
      darkMode: darkMode,
    );
  }

  Future<void> saveProfile() async {
    if (profileDraftModel.hasChanges) return;
    emit(ProfileLoading());
    await saveUserProfile.call(
      avatarFile: profileDraftModel.avatarFile,
      language: profileDraftModel.language,
      textScale: profileDraftModel.textScale,
      darkMode: profileDraftModel.darkMode,
    );
  }
}
