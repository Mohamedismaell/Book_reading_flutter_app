import '../../../../core/connections/result.dart';
import '../../../../core/params/params.dart';
import '../repositories/auth_repository.dart';

class SignUpWithEmail {
  final AuthRepository repository;

  SignUpWithEmail({required this.repository});

  Future<Result> signUpWithEmail({required SignupParams params}) async {
    return await repository.signUpWithEmail(params: params);
  }
}
