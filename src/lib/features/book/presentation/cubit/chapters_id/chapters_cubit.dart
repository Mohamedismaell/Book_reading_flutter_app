import 'package:bloc/bloc.dart';
import 'package:bookreading/features/book/data/models/chapter.dart';
import 'package:bookreading/features/book/domain/usecases/chapters_usecase.dart';
import 'package:meta/meta.dart';

part 'chapters_state.dart';

class ChaptersCubit extends Cubit<ChaptersState> {
  final GetChaptersUseCase getChaptersUseCase;

  ChaptersCubit(this.getChaptersUseCase) : super(ChaptersInitial());

  Future<void> getChapters(int bookId) async {
    emit(ChaptersIsLoading());
    final result = await getChaptersUseCase.call(bookId);
    result.when(
      success: (chapters) => emit(ChaptersIsLoaded(chapters: chapters)),
      failure: (failure) => emit(ChaptersIsFailed(message: failure.errMessage)),
    );
  }
}
