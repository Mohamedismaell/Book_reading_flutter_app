import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/features/book/data/models/book_model.dart';

class BooksViewState {
  final LoadStatus status;
  final List<BookModel> books;
  final String? error;

  const BooksViewState({
    required this.status,
    required this.books,
    required this.error,
  });
}
