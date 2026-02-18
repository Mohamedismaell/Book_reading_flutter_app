import 'package:bloc/bloc.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/data/models/chapter.dart';
import 'package:bookreading/features/progress/data/models/user_progress.dart';
import 'package:bookreading/features/book/domain/entities/page_data.dart';
import 'package:bookreading/features/progress/domain/usecases/get_reading_progress.dart';
import 'package:bookreading/features/progress/domain/usecases/save_reading_pregress.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'reading_progress_state.dart';

class ReadingProgressCubit extends Cubit<ReadingProgressState> {
  ReadingProgressCubit(this.saveReadingPregress, this.getReadingProgress)
    : super(ReadingProgressInitial());
  final SaveReadingPregress saveReadingPregress;
  final GetReadingProgress getReadingProgress;

  Future<void> saveProgress({
    required int bookId,
    required String chapterId,
    required int pageNumber,
    BookModel? activeBook,
    ChapterModel? activeChapter,
  }) async {
    int pageNumberToSave = pageNumber;
    String chapterIdToSave = chapterId;
    BookModel? bookDetailsToSave = activeBook;
    ChapterModel? chapterDetailsToSave = activeChapter;

    if (state is ReadingProgressLoaded) {
      final oldState = (state as ReadingProgressLoaded).progress;
      if (oldState.bookId == bookId) {
        final oldPercentage = oldState.pageNumber;

        if (oldPercentage > pageNumberToSave) {
          pageNumberToSave = oldPercentage;

          if (oldState.chapterDetails != null) {
            chapterDetailsToSave = oldState.chapterDetails;
          }
        }
      }
    }
    final result = await saveReadingPregress.call(
      bookId: bookId,
      chapterId: chapterIdToSave,
      pageNumber: pageNumberToSave.ceil(),
    );

    result.when(
      success: (_) {
        if (bookDetailsToSave == null && state is ReadingProgressLoaded) {
          bookDetailsToSave =
              (state as ReadingProgressLoaded).progress.bookDetails;
          chapterDetailsToSave =
              (state as ReadingProgressLoaded).progress.chapterDetails;
        }
        final newProgress = UserProgressModel(
          bookId: bookId,
          updatedAt: DateTime.now(),
          chapterId: chapterIdToSave,
          pageNumber: pageNumberToSave,
          bookDetails: bookDetailsToSave,
          chapterDetails: chapterDetailsToSave,
        );
        if (!isClosed) {
          emit(ReadingProgressLoaded(progress: newProgress, justSaved: true));
        }
      },
      failure: (failure) {
        if (!isClosed) {
          emit(ReadingProgressError(message: failure.message));
        }
      },
    );
  }

  double calculateProgress({
    required List<PageData> pages,
    required int currentPageIndex,
  }) {
    if (pages.isEmpty || currentPageIndex <= 0) return 0.0;

    int charactersRead = 0;
    final safeIndex = (currentPageIndex - 1).clamp(0, pages.length - 1);

    for (int i = 0; i <= safeIndex; i++) {
      charactersRead += pages[i].contentLength;
    }
    final totalCharacters = pages.fold<int>(
      0,
      (sum, page) => sum + page.contentLength,
    );

    if (totalCharacters == 0) return 0.0;

    return charactersRead / totalCharacters;
  }

  Future<void> loadProgress() async {
    emit(ReadingProgressLoading());
    final result = await getReadingProgress.call();
    result.when(
      success: (progress) {
        if (!isClosed) {
          emit(ReadingProgressLoaded(progress: progress, justSaved: false));
        }
      },
      failure: (failure) {
        if (!isClosed) {
          emit(ReadingProgressError(message: failure.message));
        }
      },
    );
  }
}
