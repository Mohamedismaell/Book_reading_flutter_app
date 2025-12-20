import 'package:bookreading/features/auth/data/models/user_app.dart';

import '../../../../core/connections/result.dart';
import '../repositories/auth_repository.dart';

class Logout {
  final AuthRepository repository;

  Logout({required this.repository});

  Future<Result> logout({required UserApp currentUser}) async {
    return await repository.logout(currentUser: currentUser);
  }
}
