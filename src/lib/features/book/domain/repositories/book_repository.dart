import 'dart:io';

import 'package:bookreading/core/connections/result.dart';

abstract class BookRepository {
  //*Book Data
  Future<Result> getBooks();
  Future<Result> getChapters(int bookId);
  Future<Result> getBookById(int bookId);

  Future<Result> getUserProfile();
  Future<Result> updateUserProfile({
    String? avatarUrl,
    String? language,
    double? textScale,
    bool? darkMode,
  });
  Future<Result> uploadAvatar({required File avatarFile});
}
