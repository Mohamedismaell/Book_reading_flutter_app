import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/data/models/chapter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BooksRemoteDataSource {
  final SupabaseClient supabase;
  BooksRemoteDataSource({required this.supabase});

  Future<List<BookModel>> getBooks() async {
    final response = await supabase.from('books').select('*');
    // print(" Books **1** ===> $response");
    final resulte = response.map((e) => BookModel.fromJson(e)).toList();
    // print("Books **2**  ===> $resulte");
    return resulte;
  }

  Future<List<ChapterModel>> getChapters(int bookId) async {
    final response = await supabase
        .from('chapters')
        .select('*')
        .eq('book_id', bookId);
    // print(" Chapters **1** ===> $response");
    final resulte = response.map((e) => ChapterModel.fromJson(e)).toList();
    // print("Chapter  **2**  ===> $resulte");
    return resulte;
  }
}
