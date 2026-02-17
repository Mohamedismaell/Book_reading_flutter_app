import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/core/shared/user/data/models/user_model.dart';

abstract class UserRepository {
  Future<Result<UserModel>> getCurrentUser();
}
