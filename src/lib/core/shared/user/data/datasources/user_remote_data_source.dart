import 'package:bookreading/core/shared/user/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRemoteDataSource {
  final SupabaseClient supabaseClient;

  UserRemoteDataSource({required this.supabaseClient});
  Future<UserModel> getCurrentUser() async {
    final userId = supabaseClient.auth.currentUser!.id;
    final response = await supabaseClient
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();
    return UserModel.fromJsonMap(response);
  }
}
