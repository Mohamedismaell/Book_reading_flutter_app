import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/features/book/presentation/cubit/all_books/books_cubit.dart';
import 'package:bookreading/features/book/presentation/cubit/chapters_id/chapters_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, state) {
        return Center(
          child: state is BooksInitial
              ? TextButton(
                  onPressed: () => context.read<BooksCubit>().getBooks(),
                  child: Text("ExplorePage"),
                )
              : state is BooksIsLoading
              ? const CircularProgressIndicator()
              : state is BooksIsLoaded
              ? ListView.builder(
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(state.books[index].title),
                        TextButton(
                          onPressed: () => context
                              .read<ChaptersCubit>()
                              .getChapters(state.books[index].id),
                          child: Text("Chapters....."),
                        ),
                      ],
                    );
                  },
                )
              : state is BooksIsFailed
              ? Text(state.message)
              : Text("ExplorePage", style: context.headlineLarge()),
        );
      },
    );
  }
}
