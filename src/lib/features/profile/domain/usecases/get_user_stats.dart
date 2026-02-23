import 'package:bookreading/core/connections/result.dart';
import 'package:bookreading/features/profile/data/models/user_stats_model.dart';
import 'package:bookreading/features/profile/domain/repositories/profile_repository.dart';

class GetUserStats {
  final ProfileRepository repository;
  GetUserStats({required this.repository});
  Future<Result<UserStatsModel>> call() async {
    return await repository.getUserStats();
  }
}
