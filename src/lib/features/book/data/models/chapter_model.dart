// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  ChapterModel copyWith({
    String? id,
    int? bookId,
    int? chapterIndex,
    String? title,
    String? text,
    String? audioUrl,
  }) {
    return ChapterModel(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      chapterIndex: chapterIndex ?? this.chapterIndex,
      title: title ?? this.title,
      text: text ?? this.text,
      audioUrl: audioUrl ?? this.audioUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'book_id': bookId,
      'chapter_index': chapterIndex,
      'title': title,
      'text': text,
      'audioUrl': audioUrl,
    };
  }

  factory ChapterModel.fromJsonMap(Map<String, dynamic> map) {
    return ChapterModel(
      id: map['id'] as String,
      bookId: map['book_id'] as int,
      chapterIndex: map['chapter_index'] as int,
      title: map['title'] as String,
      text: map['text'] as String,
      audioUrl: map['audio_url'] != null ? map['audio_url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChapterModel.fromJsonString(String source) =>
      ChapterModel.fromJsonMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChapterModel(id: $id, book_id: $bookId, chapter_index: $chapterIndex, title: $title, text: $text, audio_url: $audioUrl)';
  }

  @override
  bool operator ==(covariant ChapterModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.bookId == bookId &&
        other.chapterIndex == chapterIndex &&
        other.title == title &&
        other.text == text &&
        other.audioUrl == audioUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        bookId.hashCode ^
        chapterIndex.hashCode ^
        title.hashCode ^
        text.hashCode ^
        audioUrl.hashCode;
  }
}
