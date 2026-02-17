import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/core/database/api/api_error_mapper.dart';
import 'package:bookreading/core/shared/user/data/datasources/user_remote_data_source.dart';
import 'package:bookreading/core/shared/user/data/models/user_model.dart';
import 'package:bookreading/core/shared/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource remoteDataSource;
  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<UserModel>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();

      return Result.ok(user);
    } catch (e) {
      final error = ApiErrorMapper.fromException(e);
      return Result.error(error);
    }
  }
}
