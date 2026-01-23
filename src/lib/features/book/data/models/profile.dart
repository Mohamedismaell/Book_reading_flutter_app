class ProfileModel {
  final String? avatarUrl;
  final String? language;
  final double? textScale;

  const ProfileModel({this.avatarUrl, this.language, this.textScale});
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      avatarUrl: json['avatar_url'] ?? 'assets/images/deafult_user_cover.png',
      language: json['language'] ?? 'en',
      textScale: json['text_scale'] ?? 18,
    );
  }

  ProfileModel copyWith({
    String? avatarUrl,
    String? language,
    double? textScale,
  }) {
    return ProfileModel(
      avatarUrl: avatarUrl ?? this.avatarUrl,
      language: language ?? this.language,
      textScale: textScale ?? this.textScale,
    );
  }

  @override
  String toString() =>
      'ProfileModel(avatarUrl: $avatarUrl, language: $language, textScale: $textScale)';
  bool get hasChanges =>
      avatarUrl != null || language != null || textScale != null;
}
