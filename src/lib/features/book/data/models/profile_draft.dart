import 'dart:io';

class ProfileModel {
  final File? avatarFile;
  final String? language;
  final double? textScale;
  final bool? darkMode;

  const ProfileModel({
    this.avatarFile,
    this.language,
    this.textScale,
    this.darkMode,
  });
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      avatarFile: json['avatar_file'] as File,
      language: json['language'] as String,
      textScale: json['text_scale'] as double,
      darkMode: json['dark_mode'] as bool,
    );
  }

  ProfileModel copyWith({
    File? avatarFile,
    String? language,
    double? textScale,
    bool? darkMode,
  }) {
    return ProfileModel(
      avatarFile: avatarFile ?? this.avatarFile,
      language: language ?? this.language,
      textScale: textScale ?? this.textScale,
      darkMode: darkMode ?? this.darkMode,
    );
  }

  bool get hasChanges =>
      avatarFile != null ||
      language != null ||
      textScale != null ||
      darkMode != null;
}
