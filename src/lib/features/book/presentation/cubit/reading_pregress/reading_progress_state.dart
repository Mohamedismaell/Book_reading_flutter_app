part of 'reading_progress_cubit.dart';

@immutable
sealed class ReadingProgressState {}

class ReadingProgressInitial extends ReadingProgressState {}

class ReadingProgressLoading extends ReadingProgressState {
  ReadingProgressLoading();
}

class ReadingProgressSaved extends ReadingProgressState {
  final double progress;

  ReadingProgressSaved({required this.progress});
}

class ReadingProgressLoaded extends ReadingProgressState {
  final UserProgressModel progress;
  final bool justSaved;
  ReadingProgressLoaded({required this.progress, required this.justSaved});
}

class ReadingProgressSaving extends ReadingProgressState {}

class ReadingProgressError extends ReadingProgressState {
  final String message;
  ReadingProgressError({required this.message});
}
