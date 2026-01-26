import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book/domain/repositories/book_repository.dart';

class UpdateUserProfile {
  final BookRepository repository;
  UpdateUserProfile({required this.repository});
  Future<Result> call({
    String? avatarUrl,
    String? language,
    double? textScale,
    bool? darkMode,
    // DateTime? updatedAt,
  }) async {
    return await repository.updateUserProfile(
      avatarUrl: avatarUrl,
      language: language,
      textScale: textScale,
      darkMode: darkMode,
    );
  }
}

class GetUserProfile {
  final BookRepository repository;
  GetUserProfile({required this.repository});
  Future<Result> call() async {
    return await repository.getUserProfile();
  }
}

class GetUserStats {
  final BookRepository repository;
  GetUserStats({required this.repository});
  Future<Result> call() async {
    return await repository.getUserStats();
  }
}
