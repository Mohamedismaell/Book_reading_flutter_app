// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:bookreading/features/book/data/models/book_model.dart';

class BookMarksModel extends Equatable {
  final BookModel bookDetails;
  final DateTime createdAt;
  const BookMarksModel({required this.bookDetails, required this.createdAt});

  BookMarksModel copyWith({BookModel? bookDetails, DateTime? createdAt}) {
    return BookMarksModel(
      bookDetails: bookDetails ?? this.bookDetails,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bookDetails': bookDetails.toMap(),
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory BookMarksModel.fromJsonMap(Map<String, dynamic> map) {
    return BookMarksModel(
      bookDetails: BookModel.fromJsonMap(
        map['bookDetails'] as Map<String, dynamic>,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookMarksModel.fromJsonString(String source) =>
      BookMarksModel.fromJsonMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [bookDetails, createdAt];
}
