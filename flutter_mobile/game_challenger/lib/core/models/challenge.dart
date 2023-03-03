import 'dart:convert';

import 'package:equatable/equatable.dart';

class Challenge extends Equatable {
  final String? id;
  final String? question;

  final List<Option>? options;

  const Challenge({this.id, this.question, this.options});

  @override
  List<Object?> get props => [id, question, options];
}

class Option extends Equatable {
  final String text;
  final bool isCorrect;

  const Option({
    required this.text,
    this.isCorrect = false,
  });

  @override
  List<Object> get props => [text, isCorrect];

  Option copyWith({
    String? text,
    bool? isCorrect,
  }) {
    return Option(
      text: text ?? this.text,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'isCorrect': isCorrect,
    };
  }

  factory Option.fromMap(Map<String, dynamic> map) {
    return Option(
      text: map['text'] as String,
      isCorrect: map['isCorrect'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Option.fromJson(String source) =>
      Option.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
