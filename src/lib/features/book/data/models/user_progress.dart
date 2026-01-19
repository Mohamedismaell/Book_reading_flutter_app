class UserProgressModel {
  final String userId;
  final int bookId;
  final String chapterId;
  final int pageIndex;

  UserProgressModel({
    required this.userId,
    required this.bookId,
    required this.chapterId,
    required this.pageIndex,
  });
}
