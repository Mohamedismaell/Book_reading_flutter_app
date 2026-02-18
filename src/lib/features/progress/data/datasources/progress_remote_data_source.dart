import 'package:bookreading/features/progress/data/models/user_progress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProgressRemoteDataSource {
  final SupabaseClient supabaseCilent;

  ProgressRemoteDataSource({required this.supabaseCilent});

  Future<void> saveProgress({
    required String userId,
    required int bookId,
    required String chapterId,
    // required int pageIndex,
    required int pageNumber,
    required double percentage,
  }) async {
    await supabaseCilent.from('user_progress').upsert({
      'user_id': userId,
      'book_id': bookId,
      'chapter_id': chapterId,
      // 'page_index': pageIndex,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
      'page_number': pageNumber,
      'progress_percentage': percentage,
    });
  }

  Future<ProgressModel?> getProgress({
    required String userId,
    // required int bookId,
  }) async {
    final response = await supabaseCilent
        .from('user_progress')
        .select('*, books(*), chapters(*)')
        .eq('user_id', userId)
        .order('updated_at', ascending: false)
        .limit(1)
        .maybeSingle();

    if (response == null) return null;
    return ProgressModel.fromJson(response);
  }
}
