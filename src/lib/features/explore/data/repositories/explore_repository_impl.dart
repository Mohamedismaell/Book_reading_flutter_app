import 'package:bookreading/features/explore/data/datasources/explore_data_source.dart';
import 'package:bookreading/features/explore/data/datasources/explore_remote_data_source.dart';

import '../../domain/repositories/explore_repository.dart';

class ExploreRepositoryImpl implements ExploreRepository {

  final ExploreRemoteDataSource remoteDataSource;
  final ExploreLocalDataSource localDataSource;
  ExploreRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    // required this.networkInfo,
  });


}
