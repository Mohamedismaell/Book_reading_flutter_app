import 'package:bloc/bloc.dart';
import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/features/book/data/models/books.dart';
import 'package:bookreading/features/book/data/models/chapter.dart';
import 'package:bookreading/features/progress/data/models/user_progress.dart';
import 'package:bookreading/features/book/domain/entities/page_data.dart';
import 'package:bookreading/features/progress/domain/usecases/get_reading_progress.dart';
import 'package:bookreading/features/progress/domain/usecases/save_reading_pregress.dart';
import 'package:equatable/equatable.dart';

part 'reading_progress_state.dart';

class ReadingProgressCubit extends Cubit<ReadingProgressState> {
  ReadingProgressCubit(this.saveReadingPregress, this.getReadingProgress)
    : super(ReadingProgressState());
  final SaveReadingPregress saveReadingPregress;
  final GetReadingProgress getReadingProgress;

  Future<void> saveProgress({
    required int bookId,
    required String chapterId,
    required int pageNumber,
    required double progress,
    BookModel? activeBook,
    ChapterModel? activeChapter,
  }) async {
    int pageNumberToSave = pageNumber;
    double progressToSave = progress;
    String chapterIdToSave = chapterId;
    BookModel? bookDetailsToSave = activeBook;
    ChapterModel? chapterDetailsToSave = activeChapter;

    if (state.progressStatus == LoadStatus.loaded) {
      final oldState = state.progress;
      if (oldState?.bookId == bookId) {
        final oldPercentage = oldState?.percentage;

        if (oldPercentage != null && oldPercentage > progress) {
          progressToSave = oldPercentage;
          pageNumberToSave = oldState?.pageNumber ?? 0;

          if (oldState?.chapterDetails != null) {
            chapterDetailsToSave = oldState?.chapterDetails;
          }
        }
      }
    }
    print('progressToSave: $progressToSave');
    final result = await saveReadingPregress.call(
      bookId: bookId,
      chapterId: chapterIdToSave,
      pageNumber: pageNumberToSave.ceil(),
      percentage: progressToSave,
    );

    result.when(
      success: (_) {
        if (bookDetailsToSave == null &&
            state.progressStatus == LoadStatus.loaded) {
          bookDetailsToSave = state.progress?.bookDetails;
          chapterDetailsToSave = state.progress?.chapterDetails;
        }
        final newProgress = ProgressModel(
          bookId: bookId,
          updatedAt: DateTime.now(),
          chapterId: chapterIdToSave,
          pageNumber: pageNumberToSave,
          bookDetails: bookDetailsToSave,
          chapterDetails: chapterDetailsToSave,
          percentage: progressToSave,
        );
        if (!isClosed) {
          emit(
            state.copyWith(
              progress: newProgress,
              justSaved: true,
              progressStatus: LoadStatus.loaded,
            ),
          );
        }
      },
      failure: (failure) {
        if (!isClosed) {
          emit(
            state.copyWith(
              message: failure.message,
              progressStatus: LoadStatus.error,
            ),
          );
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

  Future<void> getProgress() async {
    emit(state.copyWith(progressStatus: LoadStatus.loading));
    final result = await getReadingProgress.call();
    result.when(
      success: (progress) {
        if (!isClosed) {
          emit(
            state.copyWith(
              progress: progress,
              justSaved: false,
              progressStatus: LoadStatus.loaded,
            ),
          );
        }
      },
      failure: (failure) {
        if (!isClosed) {
          emit(
            state.copyWith(
              message: failure.message,
              progressStatus: LoadStatus.error,
            ),
          );
        }
      },
    );
  }
}
