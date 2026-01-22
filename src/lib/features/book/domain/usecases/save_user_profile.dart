import 'dart:io';

import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book/domain/repositories/book_repository.dart';

class SaveUserProfile {
  final BookRepository repository;
  SaveUserProfile({required this.repository});
  Future<Result> call({
    File? avatarFile,
    String? language,
    double? textScale,
    bool? darkMode,
    // DateTime? updatedAt,
  }) async {
    return await repository.getBooks();
  }
}
