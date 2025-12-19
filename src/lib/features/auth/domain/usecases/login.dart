import '../../../../core/connections/result.dart';
import '../../../../core/params/params.dart';
import '../repositories/auth_repository.dart';

class Login {
  final AuthRepository repository;

  Login({required this.repository});

  Future<Result> login({required LoginParams params}) async {
    return await repository.login(params: params);
  }
}
