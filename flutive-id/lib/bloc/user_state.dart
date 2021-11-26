part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

// TODO: state awal
class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

// TODO: state ketika IUser ada data
class UserLoaded extends UserState {
  final User user;

  UserLoaded(this.user);

  @override
  List<Object> get props => [user];
}
