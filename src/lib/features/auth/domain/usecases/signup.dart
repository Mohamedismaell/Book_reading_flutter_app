import 'package:bookreading/core/params/params.dart';
import 'package:bookreading/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/connections/result.dart';

class Signup {
  final AuthRepository repository;

  Signup({required this.repository});

  Future<Result> signup({required SignupParams params}) async {
    return await repository.signUp(params: params);
  }
}
