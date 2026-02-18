import 'package:bloc/bloc.dart';
import 'package:bookreading/features/book/domain/entities/page_data.dart';
import 'package:equatable/equatable.dart';

part 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  ProgressCubit() : super(ProgressState());
}
