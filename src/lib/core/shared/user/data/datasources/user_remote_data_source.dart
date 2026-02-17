import 'package:bookreading/core/shared/user/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRemoteDataSource {
  final SupabaseClient supabase;

  UserRemoteDataSource({required this.supabase});
  Future<UserModel> getCurrentUser({required String userId}) async {
    final response = await supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();
    return UserModel.fromJsonMap(response);
  }
}
