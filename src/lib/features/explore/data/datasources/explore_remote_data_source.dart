import 'package:bookreading/features/book/data/models/book_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExploreRemoteDataSource {
  final SupabaseClient supabaseClient;

  ExploreRemoteDataSource({required this.supabaseClient});

  Future<List<BookModel>> search({required String query}) async {
    final response = await supabaseClient
        .from('books')
        .select()
        .ilike('title', '%$query%');
    return response.map((e) => BookModel.fromJsonMap(e)).toList();
  }
}
