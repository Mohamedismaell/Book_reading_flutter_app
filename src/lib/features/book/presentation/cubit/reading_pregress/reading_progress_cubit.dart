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
    required String chapterId,
    required int currentPage,
    required double progressPercentage,
    BookModel? activeBook,
    ChapterModel? activeChapter,
  }) async {
    final result = await insertReadingPregress.call(
      bookId: bookId,
      chapterId: chapterId,
      pageIndex: currentPage,
      progressPercentage: progressPercentage,
    );

    result.when(
      success: (_) {
        BookModel? bookToSave = activeBook;
        ChapterModel? chapterToSave = activeChapter;

        //! last progress if there is no new progress
        if (bookToSave == null && state is ReadingProgressLoaded) {
          bookToSave = (state as ReadingProgressLoaded).progress.bookDetails;
          chapterToSave =
              (state as ReadingProgressLoaded).progress.chapterDetails;
        }

        print('Saving Book Title: ${bookToSave?.title}');

        final newProgress = UserProgressModel(
          bookId: bookId,
          chapterId: chapterId,
          pageIndex: currentPage,
          updatedAt: DateTime.now(),
          bookDetails: bookToSave,
          chapterDetails: chapterToSave,
          progressPercentage: progressPercentage,
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
