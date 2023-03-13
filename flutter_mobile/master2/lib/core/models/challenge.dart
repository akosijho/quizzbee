import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final int? id;
  final String? question;
  final String? answer;
  final String? status;
  final String? tag;
  final List<Option>? choice;

  const Question(
      {this.id, this.tag, this.question, this.choice, this.status, this.answer});

  @override
  List<Object?> get props => [id, question, choice, status, answer, tag];

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        id: json["id"] as int?,
        question: json['question'] as String?,
        status: json['status'] as String?,
        tag: json['tag'] as String?,
        choice: json['choices'] as List<Option>?,
        answer: json['answer']);
  }
}

class Option extends Equatable {
  final int? id;
  final String? choices;
  final int? questionId;
  final bool? isCorrect;

  const Option(
      {this.id, this.isCorrect = false, this.choices, this.questionId});

  @override
  List<Object?> get props => [id, choices, questionId, isCorrect];

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
        id: json['id'] as int?,
        questionId: json['question_id'] as int?,
        choices: json['choices'] as String?);
  }
}
