import 'dart:io';

import 'package:bookreading/features/book/data/models/profile_model.dart';
import 'package:bookreading/features/book/data/models/user_stats_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/book_model.dart';
import '../models/chapter_model.dart';

class BookRemoteDataSource {
  final SupabaseClient supabaseCilent;
  BookRemoteDataSource({required this.supabaseCilent});

  //Books
  Future<List<BookModel>> getBooks() async {
    final response = await supabaseCilent
        .from('books')
        .select()
        .eq('is_coming_soon', false);
    // .eq('is_coming_soon', false);
    // print(" Books **1** ===> $response");
    final resulte = response.map((e) => BookModel.fromJsonMap(e)).toList();
    // print("Books **2**  ===> $resulte");
    return resulte;
  }

  Future<BookModel?> getBookById(int bookId) async {
    final response = await supabaseCilent
        .from('books')
        .select()
        .eq('id', bookId)
        .eq('is_coming_soon', false)
        .maybeSingle();

    if (response == null) return null;

    return BookModel.fromJsonMap(response);
  }

  //Chapters
  Future<List<ChapterModel>> getChapters(int bookId) async {
    final response = await supabaseCilent
        .from('chapters')
        .select()
        .eq('book_id', bookId)
        .eq('is_coming_soon', false);

    // print(" Chapters **1** ===> $response");
    final resulte = response.map((e) => ChapterModel.fromJsonMap(e)).toList();
    // print("Chapter  **2**  ===> $resulte");
    return resulte;
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

    await supabaseCilent
        .from('user_stats')
        .update(updates)
        .eq('user_id', userId);
  }

  Future<UserStatsModel?> getUserStats({required String userId}) async {
    final response = await supabaseCilent
        .from('user_stats')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) return null;
    return UserStatsModel.fromJson(response);
  }

  Future<ProfileModel?> getUserProfile({required String userId}) async {
    final response = await supabaseCilent
        .from('profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (response == null) return null;

    return ProfileModel.fromJson(response);
  }

  Future<void> updateUserProfile({
    required String userId,
    String? avatarUrl,
    String? language,
    double? textScale,
    bool? darkMode,
  }) async {
    final updates = <String, dynamic>{};

    if (avatarUrl != null) updates['avatar_url'] = avatarUrl;
    if (language != null) updates['language'] = language;
    if (textScale != null) updates['text_scale'] = textScale;
    if (darkMode != null) updates['dark_mode'] = darkMode;

    if (updates.isEmpty) return;

    await supabaseCilent.from('profiles').update(updates).eq('id', userId);
    //     if (response.isEmpty) {
    //   throw Exception('Profile row not found');
    // }
  }

  Future<String> uploadAvatar({
    required File avatarFile,
    required String userId,
  }) async {
    final ext = avatarFile.path.split('.').last;
    final path = '$userId/avatar_${DateTime.now().millisecondsSinceEpoch}.$ext';

    print('UPLOAD PATH => $path');
    await supabaseCilent.storage
        .from('avatars')
        .upload(path, avatarFile, fileOptions: const FileOptions(upsert: true));
    final publicUrl = supabaseCilent.storage.from('avatars').getPublicUrl(path);
    return publicUrl;
  }
}
