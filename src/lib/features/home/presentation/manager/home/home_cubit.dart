import 'package:bloc/bloc.dart';
import 'package:bookreading/core/enums/stats.dart';
import 'package:bookreading/core/shared/user/data/models/user_model.dart';
import 'package:bookreading/core/shared/user/domain/usecases/get_current_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.getCurrentUser) : super(const HomeState());
  final GetCurrentUser getCurrentUser;

  Future<void> userInfo() async {
    emit(state.copyWith(userStatus: LoadStatus.loading));
    final result = await getCurrentUser.call();
    result.when(
      success: (user) =>
          emit(state.copyWith(user: user, userStatus: LoadStatus.loaded)),
      failure: (failure) => emit(
        state.copyWith(
          userStatus: LoadStatus.error,
          userErrorMessage: failure.message,
        ),
      ),
    );
  }
}
