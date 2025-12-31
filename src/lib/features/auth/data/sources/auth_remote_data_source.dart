import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/params/params.dart';

class AuthRemoteDataSource {
  final SupabaseClient supabase;
  AuthRemoteDataSource({required this.supabase});

  Future<void> loginWithGoogle() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'bookreading://login-callback',
    );
  }

  Future<void> signUpWithEmail({required SignupParams params}) async {
    await supabase.auth.signUp(
      email: params.email,
      password: params.password.toString(),
      data: {'full_name': params.name},
    );
  }

  Future<void> loginWithEmail({required LoginParams params}) async {
    await supabase.auth.signInWithPassword(
      email: params.email,
      password: params.password.toString(),
    );
  }

  Future<void> requestPasswordReset({
    required ForgotPasswordParams params,
  }) async {
    await supabase.auth.resetPasswordForEmail(
      params.email,
      redirectTo: 'bookreading://reset-password',
    );
  }

  Future<void> updatePassword({required String newPassword}) async {
    await supabase.auth.updateUser(UserAttributes(password: newPassword));
  }

  // Future<void> updatePassword(String newPassword) async {
  //   final response = await supabase.auth.updateUser(
  //     UserAttributes(password: newPassword),
  //   );
  //   if (response.user != null) {
  //     print('Password updated successfully!');
  //   }
  // }

  // Future<UserApp?> updatePassword(String newPassword) async {
  //   final response = await supabase.auth.updateUser(
  //     UserAttributes(password: newPassword),
  //   );
  //   if (response.user != null) {
  //     return UserApp.fromSupabase(response.user);
  //   }
  // }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
