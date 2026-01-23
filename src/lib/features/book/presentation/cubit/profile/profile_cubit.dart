import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bookreading/features/book/domain/usecases/get_user_profile.dart';
import 'package:bookreading/features/book/domain/usecases/update_user_profile.dart';
import 'package:bookreading/features/book/data/models/profile_draft.dart';
import 'package:bookreading/features/book/presentation/models/profile_draft.dart';
import 'package:meta/meta.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.getUserProfile, this.updateUserProfile)
    : super(ProfileInitial());
  final UpdateUserProfile updateUserProfile;
  final GetUserProfile getUserProfile;
  final ProfileModel profileModel = const ProfileModel();
  ProfileDraft _draft = const ProfileDraft();
  Timer? _saveTimer;
  bool _isSaving = false;
  bool _needResave = false;
  void updateDraft({File? avatarFile, String? language, double? textScale}) {
    print(' Draft before  ====>  $_draft');
    _draft = _draft.copyWith(
      avatarFile: avatarFile,
      language: language,
      textScale: textScale,
    );
    print(' Draft After ====>  $_draft');
    // emit(ProfileSaving(draft: _draft));
    if (_isSaving) {
      _needResave = true;
      _scheduleSave();
    }
  }

  void _scheduleSave() {
    _saveTimer?.cancel();

    _saveTimer = Timer(const Duration(milliseconds: 800), () {
      _backgroundSave();
    });
  }

  Future<void> _backgroundSave() async {
    if (_isSaving) return;
    if (!_draft.hasChanges) return;

    _isSaving = true;
    _needResave = false;
    final draftToSave = _draft;
    try {
      await updateUserProfile.call(
        avatarUrl: null, // real URL after upload
        language: draftToSave.language,
        textScale: draftToSave.textScale,
      );

      await getProfile();
      if (!_needResave) {
        _draft = const ProfileDraft();
      }
    } catch (e) {
      print('Background save failed: $e');
    } finally {
      _isSaving = false;

      if (_needResave) {
        _backgroundSave();
      }
    }
  }

  Future<void> getProfile() async {
    emit(ProfileLoading());
    final result = await getUserProfile.call();
    result.when(
      success: (userProfile) => emit(ProfileLoaded(profile: userProfile)),
      failure: (error) => emit(ProfileError(message: error.errMessage)),
    );
  }

  @override
  Future<void> close() {
    _saveTimer?.cancel();
    return super.close();
  }
}
