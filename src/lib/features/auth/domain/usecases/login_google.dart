import '../../../../core/connections/result.dart';
import '../repositories/auth_repository.dart';

class LoginWithGoogle {
  final AuthRepository repository;

  LoginWithGoogle({required this.repository});

  Future<Result> loginWithGoogle() async {
    return await repository.loginWithGoogle();
  }
}
