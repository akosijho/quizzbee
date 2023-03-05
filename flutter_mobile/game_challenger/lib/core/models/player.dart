import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final String? id;
  final String? name;
  final String? score;

  const Player({this.id, this.name, this.score});

  @override
  List<Object?> get props => [id, name, score];

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] as String?,
      name: json['name'] as String?,
      score: json['score'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        if (name != null) "name": name,
        if (score != null) "points": score
      };
}
