import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bookreading/features/auth/domain/usecases/login_google.dart';
import '../../../../core/connections/network_info.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_app.dart';

class AuthRepositoryImpl extends AuthRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Result> loginWithGoogle() async {
    try {
      final response = await remoteDataSource.loginWithGoogle();
      return Result.ok(response);
    } on CacheException catch (e) {
      return Result.error(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Result> logout({required UserApp currentUser}) async {
    try {
      await remoteDataSource.logout(currentUser: currentUser);
      return Result.ok(null);
    } catch (e) {
      return Result.error(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Result> forgotPassword({required ForgotPasswordParams params}) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Result> loginWithEmail({required LoginParams params}) {
    // TODO: implement loginWithEmail
    throw UnimplementedError();
  }

  @override
  Future<Result> otp({required OTPParams params}) {
    // TODO: implement otp
    throw UnimplementedError();
  }

  @override
  Future<Result> signUpWithEmail({required SignupParams params}) {
    // TODO: implement signUpWithEmail
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
