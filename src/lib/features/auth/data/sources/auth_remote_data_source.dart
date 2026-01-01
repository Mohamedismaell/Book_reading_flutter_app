import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/params/params.dart';

class AuthRemoteDataSource {
  final SupabaseClient supabase;
  AuthRemoteDataSource({required this.supabase});

  Future<void> loginWithGoogle() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'bookreading://auth',
    );
  }

  Future<void> signUpWithEmail({required SignupParams params}) async {
    await supabase.auth.signUp(
      email: params.email,
      password: params.password.toString(),
      emailRedirectTo: "https://mohamedismaell.github.io/bookreading-auth/",
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
      redirectTo: 'bookreading://auth',
    );
  }

  Future<void> updatePassword({required String newPassword}) async {
    await supabase.auth.updateUser(UserAttributes(password: newPassword));
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
