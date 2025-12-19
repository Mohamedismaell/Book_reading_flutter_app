import 'package:supabase_flutter/supabase_flutter.dart';

class UserApp {
  final String id;
  final String fullName;

  UserApp({required this.id, required this.fullName});

  factory UserApp.fromSupabase(User? user) {
    return UserApp(
      id: user?.id ?? "User Not Found No \"ID\"",
      fullName:
          user?.userMetadata?['full_name'] ??
          user?.email ??
          'User Not Found No "Email"',
    );
  }
}
