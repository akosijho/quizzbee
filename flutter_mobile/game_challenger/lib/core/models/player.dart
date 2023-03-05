import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final String? id;
  final String? name;
  final String? points;

  const Player({this.id, this.name, this.points});

  @override
  List<Object?> get props => [id, name, points];

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] as String?,
      name: json['name'] as String,
      points: json['points'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        if (name != null) "name": name,
        if (points != null) "points": points
      };
}
