part of 'reading_progress_cubit.dart';

@immutable
sealed class ReadingProgressState {}

class ReadingProgressInitial extends ReadingProgressState {}

class ReadingProgressSaving extends ReadingProgressState {}

class ReadingProgressSaved extends ReadingProgressState {}

class ReadingProgressError extends ReadingProgressState {
  final String message;
  ReadingProgressError({required this.message});
}
