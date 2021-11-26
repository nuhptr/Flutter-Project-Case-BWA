import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/model/user.dart';
import '/services/firebase/user_services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(UserState initialState) : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUser) {
      User user = await UserServices.getUser(event.id);

      yield UserLoaded(user);
    }
    //* event SignOut
    else if (event is SignOut) {
      yield UserInitial();
    }
    //* event UpdateData
    else if (event is UpdateData) {
      User updateData = (state as UserLoaded)
          .user
          .copyWith(name: event.name, profilePicture: event.uploadImage);

      // TODO: updata data dengan menggunakan User copywith
      await UserServices.updateUser(updateData);

      yield UserLoaded(updateData);
    }
    //* event top up
    else if (event is TopUp) {
      if (state is UserLoaded) {
        try {
          var updateUser = (state as UserLoaded).user.copyWith(
                balance: (state as UserLoaded).user.balance + event.amount,
              );

          await UserServices.updateUser(updateUser);

          yield UserLoaded(updateUser);
        } catch (e) {
          print(e);
        }
      }
    }
    //* event purchase
    else if (event is Purchase) {
      if (state is UserLoaded) {
        try {
          var updateUser = (state as UserLoaded).user.copyWith(
                balance: (state as UserLoaded).user.balance - event.amount,
              );

          await UserServices.updateUser(updateUser);

          yield UserLoaded(updateUser);
        } catch (e) {
          print(e);
        }
      }
    }
  }
}
