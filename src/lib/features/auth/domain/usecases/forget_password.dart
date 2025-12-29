import '../../../../core/connections/result.dart';
import '../../../../core/params/params.dart';
import '../repositories/auth_repository.dart';

class ForgetPassword {
  final AuthRepository repository;

  ForgetPassword({required this.repository});

  Future<Result> resetPassword({required ForgotPasswordParams params}) async {
    return await repository.resetPassword(params: params);
  }
}
