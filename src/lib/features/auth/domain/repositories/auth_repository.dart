import '../../../../core/connections/result.dart';
import '../../../../core/params/params.dart';

abstract class AuthRepository {
  Future<Result> login({required LoginParams params});
  Future<Result> signUp({required SignupParams params});
  Future<Result> forgotPassword({required ForgotPasswordParams params});
  Future<Result> otp({required OTPParams params});
  Future<Result> logout();
}












//Todo add the Result to the AuthRepository above "IMPORTANT" after test 
  // Future<Result<List<PostEntity>>> getNewsByCategory({
  //   required NewsCategoryParams params,
  // });