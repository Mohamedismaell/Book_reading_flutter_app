import 'package:bloc/bloc.dart';
import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/core/shared/user/data/models/user_model.dart';
import 'package:bookreading/core/shared/user/domain/usecases/get_current_user.dart';
import 'package:bookreading/features/progress/data/models/progress_model.dart';
import 'package:bookreading/features/progress/domain/usecases/get_reading_progress.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.getCurrentUser, this.getReadingProgress)
    : super(const HomeState());
  final GetCurrentUser getCurrentUser;
  final GetReadingProgress getReadingProgress;

  Future<void> userInfo() async {
    if (!isClosed) {
      emit(state.copyWith(userStatus: LoadStatus.loading));
    }
    final result = await getCurrentUser.call();
    result.when(
      success: (user) {
        if (!isClosed) {
          emit(state.copyWith(user: user, userStatus: LoadStatus.loaded));
        }
      },
      failure: (failure) {
        if (!isClosed) {
          emit(
            state.copyWith(
              userStatus: LoadStatus.error,
              userErrorMessage: failure.message,
            ),
          );
        }
      },
    );
  }

  Future<void> getProgress() async {
    if (!isClosed) {
      emit(state.copyWith(progressStatus: LoadStatus.loading));
    }
    final result = await getReadingProgress.call();
    result.when(
      success: (progress) {
        if (!isClosed) {
          emit(
            state.copyWith(
              progress: progress,
              progressStatus: LoadStatus.loaded,
            ),
          );
        }
      },
      failure: (failure) {
        if (!isClosed) {
          emit(
            state.copyWith(
              progressStatus: LoadStatus.error,
              progressErrorMessage: failure.message,
            ),
          );
        }
      },
    );
  }
}
