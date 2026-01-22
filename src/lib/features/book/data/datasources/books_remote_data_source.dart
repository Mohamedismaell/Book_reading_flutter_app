import 'package:bookreading/features/book/data/models/user_progress.dart';
import 'package:bookreading/features/book/data/models/user_stats.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/books.dart';
import '../models/chapter.dart';

class BooksRemoteDataSource {
  final SupabaseClient supabase;
  BooksRemoteDataSource({required this.supabase});

  Future<List<BookModel>> getBooks() async {
    final response = await supabase.from('books').select();
    // print(" Books **1** ===> $response");
    final resulte = response.map((e) => BookModel.fromJson(e)).toList();
    // print("Books **2**  ===> $resulte");
    return resulte;
  }

  Future<BookModel?> getBookById(int bookId) async {
    final response = await supabase
        .from('books')
        .select()
        .eq('id', bookId)
        .maybeSingle();

    if (response == null) return null;

    return BookModel.fromJson(response);
  }

  Future<List<ChapterModel>> getChapters(int bookId) async {
    final response = await supabase
        .from('chapters')
        .select()
        .eq('book_id', bookId);
    // print(" Chapters **1** ===> $response");
    final resulte = response.map((e) => ChapterModel.fromJson(e)).toList();
    // print("Chapter  **2**  ===> $resulte");
    return resulte;
  }

  Future<void> saveProgress({
    required String userId,
    required int bookId,
    required String chapterId,
    // required int pageIndex,
    required double progressPercentage,
  }) async {
    await supabase.from('user_progress').upsert({
      'user_id': userId,
      'book_id': bookId,
      'chapter_id': chapterId,
      // 'page_index': pageIndex,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
      'progress': progressPercentage,
    });
  }

  Future<UserProgressModel?> getProgress({
    required String userId,
    // required int bookId,
  }) async {
    final response = await supabase
        .from('user_progress')
        .select('*, books(*), chapters(*)')
        .eq('user_id', userId)
        .order('updated_at', ascending: false)
        .limit(1)
        .maybeSingle();

    if (response == null) return null;
    return UserProgressModel.fromJson(response);
  }

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

    await supabase.from('user_stats').update(updates).eq('user_id', userId);
  }

  Future<UserStats?> getUserStats({required String userId}) async {
    final response = await supabase
        .from('user_stats')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) return null;
    return UserStats.fromJson(response);
  }
}
