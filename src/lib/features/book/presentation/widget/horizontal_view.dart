import 'package:bookreading/core/helper/size_provider/size_provider.dart';
import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/routes/app_routes.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/presentation/cubit/books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HorizontalView extends StatefulWidget {
  const HorizontalView({super.key, required this.category});
  final String category;

  @override
  State<HorizontalView> createState() => _HorizontalViewState();
}

class _HorizontalViewState extends State<HorizontalView> {
  // Theme.of(context);
  @override
  void initState() {
    super.initState();
    final cubit = context.read<BooksCubit>();
    if (cubit.state is! BooksIsLoaded && cubit.state is! BooksIsLoading) {
      cubit.getBooks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizeProvider(
      baseSize: const Size(160, 310),
      width: context.setWidth(160),
      height: context.setHeight(310),
      child: BlocBuilder<BooksCubit, BooksState>(
        builder: (context, state) {
          if (state is BooksIsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BooksIsFailed) {
            return Center(child: Text("Error: ${state.message}"));
          }
          if (state is BooksIsLoaded) {
            print(" Here Books ${state.books}");
            return _Content(books: state.books, category: widget.category);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.books, required this.category});
  final List<BookModel> books;
  final String category;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sizeProvider.height,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          final currentBook = books[index];
          return Padding(
            padding: EdgeInsets.only(right: context.setMinSize(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BookCover(currentBook: currentBook, category: category),
                SizedBox(height: context.setMinSize(16)),
                _BookHeader(currentBook: currentBook),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BookCover extends StatelessWidget {
  const _BookCover({required this.currentBook, required this.category});

  final BookModel currentBook;
  final String category;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => context.push(
          AppRoutes.bookDetails,
          extra: {
            'book': currentBook,
            'heroTag': '${category}_${currentBook.id}',
          },
        ),
        child: Container(
          width: context.sizeProvider.width,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
          child: Hero(
            tag: '${category}_${currentBook.id}',
            child: Image.network(currentBook.coverUrl!, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

class _BookHeader extends StatelessWidget {
  const _BookHeader({required this.currentBook});
  final BookModel currentBook;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sizeProvider.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentBook.title,
            style: context.headlineSmall(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            currentBook.author ?? "Unknown",
            style: context.bodyMedium(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
