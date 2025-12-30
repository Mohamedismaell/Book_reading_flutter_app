import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/connections/network_info.dart';
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
}
