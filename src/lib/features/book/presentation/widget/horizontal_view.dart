import 'package:bookreading/core/helper/size_provider/size_provider.dart';
import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/routes/app_routes.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
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
            return SizedBox(
              height: context.sizeProvider.height,

              child: ListView.builder(
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  final book = state.books[index];
                  return Padding(
                    padding: EdgeInsets.only(right: context.setMinSize(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => context.push(
                              AppRoutes.bookDetails,
                              extra: {
                                'book': book,
                                'heroTag': '${widget.category}_${book.id}',
                              },
                            ),
                            child: Container(
                              width: context.sizeProvider.width,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Hero(
                                tag: '${widget.category}_${book.id}',
                                child: Image.network(
                                  book.coverUrl!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: context.setMinSize(16)),
                        SizedBox(
                          width: context.sizeProvider.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.title,
                                style: context.headlineSmall(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                book.author ?? "Unknown",
                                style: context.bodyMedium(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
