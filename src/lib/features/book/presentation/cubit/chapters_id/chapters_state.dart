part of 'chapters_cubit.dart';

@immutable
sealed class ChaptersState {}

final class ChaptersInitial extends ChaptersState {}

final class ChaptersIsLoading extends ChaptersState {}

final class ChaptersIsLoaded extends ChaptersState {
  final List<ChapterModel> chapters;
  ChaptersIsLoaded({required this.chapters});
}

final class ChaptersIsFailed extends ChaptersState {
  final String message;
  ChaptersIsFailed({required this.message});
}
