import 'package:bloc/bloc.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/data/models/chapter.dart';
import 'package:bookreading/features/book/data/models/user_progress.dart';
import 'package:bookreading/features/book/domain/usecases/get_reading_progress.dart';
import 'package:bookreading/features/book/domain/usecases/insert_reading_pregress.dart';
import 'package:meta/meta.dart';

part 'reading_progress_state.dart';

class ReadingProgressCubit extends Cubit<ReadingProgressState> {
  ReadingProgressCubit(this.insertReadingPregress, this.getReadingProgress)
    : super(ReadingProgressInitial());
  final InsertReadingPregress insertReadingPregress;
  final GetReadingProgress getReadingProgress;
  Future<void> saveProgress({
    required int bookId,
    required String userId,
    required String chapterId,
    required int currentPage,
    required int totalPages,
    // 1. ADD THESE PARAMETERS
    BookModel? activeBook,
    ChapterModel? activeChapter,
  }) async {
    final result = await insertReadingPregress.call(
      bookId,
      userId,
      chapterId,
      currentPage,
    );

    result.when(
      success: (_) {
        BookModel? bookToSave = activeBook;
        ChapterModel? chapterToSave = activeChapter;

        // 2. LOGIC: If the UI gave us the book, use it!
        // Only fall back to 'state' if we didn't get new info.
        if (bookToSave == null && state is ReadingProgressLoaded) {
          bookToSave = (state as ReadingProgressLoaded).progress?.bookDetails;
          chapterToSave =
              (state as ReadingProgressLoaded).progress?.chapterDetails;
        }

        print('Saving Book Title: ${bookToSave?.title}'); // Check this print

        final newProgress = UserProgressModel(
          userId: userId,
          bookId: bookId,
          chapterId: chapterId,
          pageIndex: currentPage,
          updatedAt: DateTime.now(),
          // 3. Use the resolved variables
          bookDetails: bookToSave,
          chapterDetails: chapterToSave,
        );

        emit(ReadingProgressLoaded(progress: newProgress, justSaved: true));
      },
      failure: (failure) =>
          emit(ReadingProgressError(message: failure.errMessage)),
    );
  }

  Future<void> loadProgress() async {
    // print("progress $progress");
    emit(ReadingProgressLoading());
    final result = await getReadingProgress.call();
    result.when(
      success: (progress) {
        emit(ReadingProgressLoaded(progress: progress, justSaved: false));
      },
      failure: (failure) =>
          emit(ReadingProgressError(message: failure.errMessage)),
    );
  }
}
