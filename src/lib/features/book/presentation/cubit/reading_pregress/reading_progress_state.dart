part of 'reading_progress_cubit.dart';

@immutable
sealed class ReadingProgressState extends Equatable {
  const ReadingProgressState();

  @override
  List<Object?> get props => [];
}

class ReadingProgressInitial extends ReadingProgressState {
  const ReadingProgressInitial();
}

class ReadingProgressLoading extends ReadingProgressState {
  const ReadingProgressLoading();
}

// class ReadingProgressSaved extends ReadingProgressState {
//   final double progress;

//   const ReadingProgressSaved({required this.progress});
//   @override
//   List<Object?> get props => [progress];
// }

class ReadingProgressLoaded extends ReadingProgressState {
  final UserProgressModel progress;
  final bool justSaved;

  const ReadingProgressLoaded({
    required this.progress,
    required this.justSaved,
  });

  @override
  List<Object?> get props => [progress, justSaved];
}

class ReadingProgressError extends ReadingProgressState {
  final String message;

  const ReadingProgressError({required this.message});

  @override
  List<Object?> get props => [message];
}
