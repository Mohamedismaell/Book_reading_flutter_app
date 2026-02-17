import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/core/shared/user/data/models/user_model.dart';
import 'package:bookreading/core/shared/user/domain/repositories/user_repository.dart';

class GetCurrentUser {
  final UserRepository repository;

  GetCurrentUser({required this.repository});

  Future<Result<UserModel>> call() {
    return repository.getCurrentUser();
  }
}
