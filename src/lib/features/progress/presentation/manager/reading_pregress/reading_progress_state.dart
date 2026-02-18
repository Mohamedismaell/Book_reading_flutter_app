// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reading_progress_cubit.dart';

class ReadingProgressState extends Equatable {
  final ProgressModel? progress;
  final bool justSaved;
  final String? message;
  final LoadStatus progressStatus;

  const ReadingProgressState({
    this.progress,
    this.justSaved = false,
    this.message,
    this.progressStatus = LoadStatus.initial,
  });

  ReadingProgressState copyWith({
    ProgressModel? progress,
    bool? justSaved,
    String? message,
    LoadStatus? progressStatus,
  }) {
    return ReadingProgressState(
      progress: progress ?? this.progress,
      justSaved: justSaved ?? this.justSaved,
      message: message ?? this.message,
      progressStatus: progressStatus ?? this.progressStatus,
    );
  }

  @override
  List<Object?> get props => [progress, justSaved, message, progressStatus];

  @override
  bool get stringify => true;
}
