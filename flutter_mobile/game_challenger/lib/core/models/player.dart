import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final String? id;
  final String? name;
  final String? points;

  const Player({this.id, this.name, this.points});

  @override
  List<Object?> get props => [id, name, points];
}
