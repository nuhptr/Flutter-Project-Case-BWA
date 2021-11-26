import 'package:equatable/equatable.dart';

class Actor extends Equatable {
  final String name;
  final String profilePath;

  Actor({this.name, this.profilePath});

  @override
  List<Object> get props => [name, profilePath];
}
