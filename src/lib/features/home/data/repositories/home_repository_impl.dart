import 'package:bookreading/features/home/data/datasources/home_data_source.dart';
import 'package:bookreading/features/home/data/datasources/home_remote_data_source.dart';

import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    // required this.networkInfo,
  });
}
