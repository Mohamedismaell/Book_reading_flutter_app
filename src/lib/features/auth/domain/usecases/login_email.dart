import '../../../../core/connections/result.dart';
import '../../../../core/params/params.dart';
import '../repositories/auth_repository.dart';

class LoginWithEmail {
  final AuthRepository repository;

  LoginWithEmail({required this.repository});

  Future<Result> loginWithEmail({required LoginParams params}) async {
    return await repository.loginWithEmail(params: params);
  }
}
