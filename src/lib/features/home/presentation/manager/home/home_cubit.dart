import 'package:bloc/bloc.dart';
import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/core/shared/user/data/models/user_model.dart';
import 'package:bookreading/core/shared/user/domain/usecases/get_current_user.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.getCurrentUser) : super(const HomeState());
  final GetCurrentUser getCurrentUser;

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
}
