import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/core/database/api/api_error_mapper.dart';
import 'package:bookreading/core/shared/user/data/datasources/user_remote_data_source.dart';
import 'package:bookreading/core/shared/user/data/models/user_model.dart';
import 'package:bookreading/core/shared/user/domain/repositories/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final SupabaseClient supabase;
  UserRepositoryImpl({required this.remoteDataSource, required this.supabase});

  @override
  Future<Result<UserModel>> getCurrentUser() async {
    try {
      final userId = supabase.auth.currentUser!.id;
      final user = await remoteDataSource.getCurrentUser(userId: userId);

      return Result.ok(user);
    } catch (e) {
      final error = ApiErrorMapper.fromException(e);
      return Result.error(error);
    }
  }
}
