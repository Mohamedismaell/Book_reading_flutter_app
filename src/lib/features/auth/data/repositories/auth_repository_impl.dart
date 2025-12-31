import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/connections/network_info.dart';
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
  Future<Result> loginWithGoogle() async {
    try {
      await remoteDataSource.loginWithGoogle();
      return Result.ok(null);
    } on AuthApiException catch (e) {
      return Result.error(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Result> signUpWithEmail({required SignupParams params}) async {
    try {
      await remoteDataSource.signUpWithEmail(params: params);
      return Result.ok(null);
    } on AuthApiException catch (e) {
      return Result.error(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Result> loginWithEmail({required LoginParams params}) async {
    try {
      await remoteDataSource.loginWithEmail(params: params);
      return Result.ok(null);
    } on AuthApiException catch (e) {
      return Result.error(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Result> resetPassword({required ForgotPasswordParams params}) async {
    try {
      await remoteDataSource.requestPasswordReset(params: params);
      return Result.ok(null);
    } on AuthApiException catch (e) {
      return Result.error(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Result> updatePassword({required String newPassword}) async {
    try {
      await remoteDataSource.updatePassword(newPassword: newPassword);
      return Result.ok(null);
    } on AuthApiException catch (e) {
      return Result.error(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Result> logout() async {
    try {
      await remoteDataSource.logout();
      return Result.ok(null);
    } on AuthApiException catch (e) {
      return Result.error(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Result> otp({required OTPParams params}) {
    // TODO: implement otp
    throw UnimplementedError();
  }
}
