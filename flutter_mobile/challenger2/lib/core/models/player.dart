

import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final int? id;
  final String? name;
  final int? score;

  const Player({this.id, this.name, this.score});

  @override
  List<Object?> get props => [id, name, score];

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] as int?,
      name: json['name'] as String?,
      score: json['score'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        if (name != null) "name": name,
        if (score != null) "points": score
      };
}
