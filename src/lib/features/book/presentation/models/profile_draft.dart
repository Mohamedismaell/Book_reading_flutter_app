import 'dart:io';

class ProfileDraft {
  final File? avatarFile;
  final String? language;
  final double? textScale;

  const ProfileDraft({this.avatarFile, this.language, this.textScale});

  ProfileDraft copyWith({
    File? avatarFile,
    String? language,
    double? textScale,
  }) {
    return ProfileDraft(
      avatarFile: avatarFile ?? this.avatarFile,
      language: language ?? this.language,
      textScale: textScale ?? this.textScale,
    );
  }

  @override
  String toString() =>
      'ProfileDraft(avatarFile: $avatarFile, language: $language, textScale: $textScale)';
  bool get hasChanges =>
      avatarFile != null || language != null || textScale != null;
}
