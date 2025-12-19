import '../../../../core/connections/result.dart';
import '../../../../core/params/params.dart';
import '../repositories/auth_repository.dart';

class ForgetPassword {
  final AuthRepository repository;

  ForgetPassword({required this.repository});

  Future<Result> forgotPassword({required ForgotPasswordParams params}) async {
    return await repository.forgotPassword(params: params);
  }
}
