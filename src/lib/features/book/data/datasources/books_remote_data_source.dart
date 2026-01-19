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
    required int pageIndex,
  }) async {
    await supabase.from('user_progress').upsert({
      'user_id': userId,
      'book_id': bookId,
      'chapter_id': chapterId,
      'page_index': pageIndex,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }
}
