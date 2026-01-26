class BookModel {
  final int id;
  final String title;
  final String? author;
  final String language;
  final String? coverUrl;
  final String? summary;

  BookModel({
    required this.id,
    required this.title,
    this.author,
    required this.language,
    this.coverUrl,
    this.summary,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] != null ? json['author'] as String : 'Unknown',
      language: json['language'] as String,
      coverUrl: json['cover_url'] as String?,
      summary: json['summary'] != null ? json['summary'] as String : 'Nothing',
    );
  }
}
