import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/auth/data/datasources/auth_remote_data_source.dart';
import '../../../../core/connections/network_info.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Result> login({required LoginParams params}) async {
    try {
      final response = await remoteDataSource.login();
      return Result.ok(response);
    } on CacheException catch (e) {
      return Result.error(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Result> signUp({required SignupParams params}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<Result> forgotPassword({required ForgotPasswordParams params}) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Result> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Result> otp({required OTPParams params}) {
    // TODO: implement otp
    throw UnimplementedError();
  }

  //!Filtered Posts with Category
  // @override
  // Future<Result<List<PostEntity>>> getNewsByCategory({
  //   required NewsCategoryParams params,
  // }) async {
  //   try {
  //     final remoteNews = await remoteDataSource.getNewsByCategory(params);
  //     return Result.ok(remoteNews.posts ?? []);
  //   } on ServerExceptions catch (e) {
  //     return Result.error(Failure(errMessage: e.errorModel.errorMessage));
  //   }
  // }
}
