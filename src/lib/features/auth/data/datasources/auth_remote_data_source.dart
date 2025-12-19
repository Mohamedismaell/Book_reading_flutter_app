import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_app.dart';

class AuthRemoteDataSource {
  final supabase = Supabase.instance.client;

  Future<UserApp> login() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.flutter://login-callback',
    );

    final currentUser = supabase.auth.currentUser;

    return UserApp.fromSupabase(currentUser!);
  }
}
