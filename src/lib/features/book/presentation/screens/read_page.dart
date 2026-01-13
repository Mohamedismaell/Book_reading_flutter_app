import 'package:bookreading/core/helper/size_provider/sized_helper_extension.dart';
import 'package:bookreading/core/theme/extensions/scaled_text.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/presentation/cubit/books_cubit.dart';
import 'package:bookreading/features/book/presentation/widget/custom_header.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadPage extends StatefulWidget {
  const ReadPage({super.key, required this.book});
  final BookModel book;
  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  @override
  void initState() {
    context.read<BooksCubit>().getChapters(widget.book.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    return Column(
      children: [
        CustomHeader(isheader: true, title: book.title, author: book.author),
      ],
    );
  }
}
