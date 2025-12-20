import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_app.dart';

class AuthRemoteDataSource {
  final SupabaseClient supabase;
  AuthRemoteDataSource({required this.supabase});

  Future<UserApp?> loginWithGoogle() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.flutter://login-callback',
    );

    final authState = await supabase.auth.onAuthStateChange.firstWhere(
      (data) => data.event == AuthChangeEvent.signedIn,
    );

    return UserApp.fromSupabase(authState.session?.user);
  }

  Future<void> logout({required UserApp currentUser}) async {
    await supabase.auth.signOut();
  }
}
