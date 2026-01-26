import '../../../../core/connections/result.dart';
import '../../../../core/params/params.dart';

abstract class AuthRepository {
  //*Google
  Future<Result> loginWithGoogle();
  //*Email
  Future<Result> signUpWithEmail({required SignupParams params});
  Future<Result> loginWithEmail({required LoginParams params});

  //*Password
  Future<Result> resetPassword({required ForgotPasswordParams params});
  Future<Result> updatePassword({required String newPassword});

  //*OTP
  Future<Result> otp({required OTPParams params});
  //*logOut
  Future<Result> logout();
}
