// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class BookModel extends Equatable {
  final int id;
  final String title;
  final String? author;
  final String language;
  final String? coverUrl;
  final String? summary;
  const BookModel({
    required this.id,
    required this.title,
    this.author,
    required this.language,
    this.coverUrl,
    this.summary,
  });

  BookModel copyWith({
    int? id,
    String? title,
    String? author,
    String? language,
    String? coverUrl,
    String? summary,
  }) {
    return BookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      language: language ?? this.language,
      coverUrl: coverUrl ?? this.coverUrl,
      summary: summary ?? this.summary,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'language': language,
      'cover_url': coverUrl,
      'summary': summary,
    };
  }

  factory BookModel.fromJsonMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'] as int,
      title: map['title'] as String,
      author: map['author'] != null ? map['author'] as String : null,
      language: map['language'] as String,
      coverUrl: map['cover_url'] != null ? map['cover_url'] as String : null,
      summary: map['summary'] != null ? map['summary'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJsonString(String source) =>
      BookModel.fromJsonMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [id, title, author, language, coverUrl, summary];
  }
}
