import 'package:bookreading/features/book/data/models/book_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExploreRemoteDataSource {
  final SupabaseClient supabaseClient;

  ExploreRemoteDataSource({required this.supabaseClient});

  Future<List<BookModel>> search({required String query}) async {
    final response = await supabaseClient
        .from('books')
        .select()
        .eq('is_coming_soon', false)
        .ilike('title', '%$query%');
    return response.map((e) => BookModel.fromJsonMap(e)).toList();
  }

  Future<List<BookModel>> getPopularBooks() async {
    final response = await supabaseClient
        .from('books')
        .select()
        .eq('is_coming_soon', false)
        .order('created_at', ascending: true)
        .limit(10);
    return response.map((e) => BookModel.fromJsonMap(e)).toList();
  }

  Future<List<BookModel>> getCommingSoonBooks() async {
    final response = await supabaseClient
        .from('books')
        .select()
        .eq('is_coming_soon', true)
        .order('created_at', ascending: false)
        .limit(10);
    return response.map((e) => BookModel.fromJsonMap(e)).toList();
  }
}
