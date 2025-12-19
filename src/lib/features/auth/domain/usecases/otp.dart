import '../../../../core/connections/result.dart';
import '../../../../core/params/params.dart';
import '../repositories/auth_repository.dart';

class Otp {
  final AuthRepository repository;

  Otp({required this.repository});

  Future<Result> otp({required OTPParams params}) async {
    return await repository.otp(params: params);
  }
}
