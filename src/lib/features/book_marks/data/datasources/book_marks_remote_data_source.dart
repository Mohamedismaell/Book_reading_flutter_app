import 'package:bookreading/features/book_marks/data/models/book_marks_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookMarksRemoteDataSource {
  final SupabaseClient supabaseClient;

  BookMarksRemoteDataSource({required this.supabaseClient});
  Future<void> insertBookmark({
    required String userId,
    required int bookId,
  }) async {
    await supabaseClient.from('book_marks').upsert({
      'user_id': userId,
      'book_id': bookId,
    });
  }

  Future<void> removeBookmark({
    required String userId,
    required int bookId,
  }) async {
    await supabaseClient
        .from('book_marks')
        .delete()
        .eq('book_id', bookId)
        .eq('user_id', userId);
  }

  Future<List<BookMarksModel>> getBookmarks({required String userId}) async {
    final response = await supabaseClient
        .from('book_marks')
        .select('''
        created_at,
        books (
          id,
          title,
          cover_url,
          author
        )
      ''')
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    final resulte = response.map((e) => BookMarksModel.fromJsonMap(e)).toList();
    return resulte;
  }
}
