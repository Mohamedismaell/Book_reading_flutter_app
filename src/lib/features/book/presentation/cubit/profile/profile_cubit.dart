import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:bookreading/features/book/domain/usecases/user_profile_usecase.dart';
import 'package:bookreading/features/book/data/models/profile.dart';
import 'package:bookreading/features/book/domain/usecases/avatar_usecase.dart';
import 'package:bookreading/features/book/presentation/models/profile_draft.dart';
import 'package:meta/meta.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this.getUserProfile,
    this.updateUserProfile,
    this.uploadAvatar,
    // this.getAvatar,
  ) : super(ProfileInitial());
  final UpdateUserProfile updateUserProfile;
  final GetUserProfile getUserProfile;
  final UploadAvatar uploadAvatar;
  // final GetAvatar getAvatar;
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
    }
    _scheduleSave();
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
      String? avatarPath;

      //this do the upload
      if (draftToSave.avatarFile != null) {
        final result = await uploadAvatar.call(
          avatarFile: draftToSave.avatarFile!,
        );
        result.when(
          success: (path) => avatarPath = path,
          failure: (error) {
            print('Avatar upload failed: ${error.message}');
            _needResave = true;
          },
        );
      }

      await updateUserProfile.call(
        avatarUrl: avatarPath,
        language: draftToSave.language,
        textScale: draftToSave.textScale,
      );

      await getProfile(firstTime: false);
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

  Future<void> getProfile({required bool firstTime}) async {
    print('getProfile Called ');
    if (firstTime) emit(ProfileLoading());
    final result = await getUserProfile.call();
    result.when(
      success: (userProfile) async {
        emit(ProfileLoaded(profile: userProfile));
      },
      failure: (error) => emit(ProfileError(message: error.message)),
    );
  }

  @override
  Future<void> close() {
    _saveTimer?.cancel();
    return super.close();
  }
}
