import 'dart:io';

class ProfileDraftModel {
  final File? avatarFile;
  final String? language;
  final double? textScale;
  final bool? darkMode;

  const ProfileDraftModel({
    this.avatarFile,
    this.language,
    this.textScale,
    this.darkMode,
  });

  ProfileDraftModel copyWith({
    File? avatarFile,
    String? language,
    double? textScale,
    bool? darkMode,
  }) {
    return ProfileDraftModel(
      avatarFile: avatarFile ?? this.avatarFile,
      language: language ?? this.language,
      textScale: textScale ?? this.textScale,
      darkMode: darkMode ?? this.darkMode,
    );
  }

  bool get isEmpty =>
      avatarFile == null &&
      language == null &&
      textScale == null &&
      darkMode == null;
}
