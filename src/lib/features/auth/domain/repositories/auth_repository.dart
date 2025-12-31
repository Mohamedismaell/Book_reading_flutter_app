import 'package:bookreading/features/auth/data/models/user_app.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/connections/result.dart';
import '../../../../core/params/params.dart';

abstract class AuthRepository {
  //*Google
  Future<Result> loginWithGoogle();
  //*Email
  Future<Result> signUpWithEmail({required SignupParams params});
  Future<Result> loginWithEmail({required LoginParams params});

  //*Password
  // Future<Result> resetPassword({required ForgotPasswordParams params});
  // Future<Result> updatePassword({required String newPassword});

  //*OTP
  Future<Result> otp({required OTPParams params});
  //*logOut
  Future<Result> logout({required UserApp currentUser});
}












//Todo add the Result to the AuthRepository above "IMPORTANT" after test 
  // Future<Result<List<PostEntity>>> getNewsByCategory({
  //   required NewsCategoryParams params,
  // });