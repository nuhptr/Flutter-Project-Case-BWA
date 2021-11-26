import 'package:equatable/equatable.dart';

class Theater extends Equatable {
  final String name;

  Theater(this.name);

  @override
  List<Object> get props => [name];
}

List<Theater> dummyTheater = [
  Theater("XXI Mal Boemi Kedaton (MBK)"),
  Theater("Central Plaza"),
  Theater("Malkartini XXI"),
  Theater("Ciplaz Lampung XXI")
];
