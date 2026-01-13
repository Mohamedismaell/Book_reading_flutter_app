class ChapterModel {
  final String id;
  final int bookId;
  final int chapterIndex;
  final String title;
  final String text;
  final String? audioUrl;

  ChapterModel({
    required this.id,
    required this.bookId,
    required this.chapterIndex,
    required this.title,
    required this.text,
    this.audioUrl,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      id: json['id'] as String,
      bookId: json['book_id'] as int,
      chapterIndex: json['chapter_index'] as int,
      title: json['title'] ?? '',
      text: json['text'] as String,
      audioUrl: json['audio_url'] as String?,
    );
  }
}
