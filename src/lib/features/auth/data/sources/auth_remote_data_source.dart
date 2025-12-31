import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/params/params.dart';
import '../models/user_app.dart';

class AuthRemoteDataSource {
  final SupabaseClient supabase;
  AuthRemoteDataSource({required this.supabase});

  Future<void> loginWithGoogle() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.flutter://login-callback',
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

  // Future<UserApp?> requestPasswordReset({
  //   required ForgotPasswordParams params,
  // }) async {
  //   await supabase.auth.resetPasswordForEmail(
  //     params.email,
  //     redirectTo: 'io.supabase.flutter://login-callback',
  //   );
  //   final authState = await supabase.auth.onAuthStateChange.firstWhere(
  //     (data) => data.event == AuthChangeEvent.passwordRecovery,
  //   );
  //   if (authState.session?.user != null) {
  //     return UserApp.fromSupabase(authState.session?.user);
  //   }
  //   return null;
  // }

  // Future<UserApp?> updatePassword(String newPassword) async {
  //   final response = await supabase.auth.updateUser(
  //     UserAttributes(password: newPassword),
  //   );
  //   if (response.user != null) {
  //     return UserApp.fromSupabase(response.user);
  //   }
  //   return null;
  // }

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
