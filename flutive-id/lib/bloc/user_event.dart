part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class SignOut extends UserEvent {
  @override
  List<Object> get props => [];
}

class LoadUser extends UserEvent {
  final String id;

  LoadUser(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateData extends UserEvent {
  final String name;
  final String uploadImage;

  UpdateData({this.name, this.uploadImage});

  @override
  List<Object> get props => [name, uploadImage];
}

// TODO: event user top-up saldo
class TopUp extends UserEvent {
  final int amount;

  TopUp(this.amount);

  @override
  List<Object> get props => [amount];
}

// TODO: state ketika user melakukan pembelian tiket
class Purchase extends UserEvent {
  final int amount;

  Purchase(this.amount);

  @override
  List<Object> get props => [amount];
}
