import 'dart:io';

import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/book/domain/repositories/book_repository.dart';

class UploadAvatar {
  final BookRepository repository;
  UploadAvatar({required this.repository});
  Future<Result> call({required File avatarFile}) async {
    return await repository.uploadAvatar(avatarFile: avatarFile);
  }
}

class GetAvatar {
  final BookRepository repository;
  GetAvatar({required this.repository});
  Future<Result> call({required String avatarPath}) async {
    return await repository.getAvatar(avatarPath: avatarPath);
  }
}
