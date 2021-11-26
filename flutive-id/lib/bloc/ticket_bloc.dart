import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/services/firebase/ticket_service.dart';
import '/model/ticket.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc(TicketState initialState) : super(TicketState([]));

  @override
  Stream<TicketState> mapEventToState(
    TicketEvent event,
  ) async* {
    if (event is BuyTicket) {
      await TicketServices.saveTicket(event.userId, event.ticket);

      List<Ticket> ticket = state.tickets + [event.ticket];

      yield TicketState(ticket);
    }
    //*
    else if (event is GetTickets) {
      List<Ticket> ticket = await TicketServices.getTickets(event.userId);

      yield TicketState(ticket);
    }
  }
}
