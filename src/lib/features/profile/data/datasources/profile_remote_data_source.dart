import 'package:bookreading/features/profile/data/models/user_stats_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRemoteDataSource {
  final SupabaseClient supabaseCilent;
  ProfileRemoteDataSource({required this.supabaseCilent});

  Future<void> updateUserStats({
    required String userId,
    int? readingStreak,
    int? readingDays,
    int? booksCompleted,
    int? totalReadingMinutes,
    DateTime? lastReadAt,
    // DateTime? updatedAt,
  }) async {
    final updates = <String, dynamic>{};

    if (readingStreak != null) {
      updates['reading_streak'] = readingStreak;
    }
    if (readingDays != null) {
      updates['reading_days'] = readingDays;
    }
    if (booksCompleted != null) {
      updates['books_completed'] = booksCompleted;
    }
    if (totalReadingMinutes != null) {
      updates['total_reading_minutes'] = totalReadingMinutes;
    }
    if (lastReadAt != null) {
      updates['last_read_at'] = lastReadAt.toIso8601String();
    }

    if (updates.isEmpty) return;

    updates['updated_at'] = DateTime.now().toIso8601String();

    await supabaseCilent
        .from('user_stats')
        .update(updates)
        .eq('user_id', userId);
  }

  Future<UserStatsModel> getUserStats({required String userId}) async {
    final response = await supabaseCilent
        .from('user_stats')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    // if (response == null) return null;
    return UserStatsModel.fromJson(response!);
  }
}
