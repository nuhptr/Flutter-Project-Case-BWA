part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  TicketEvent();
}

// TODO: event ketika mengambil data ticket
class GetTickets extends TicketEvent {
  final String userId;

  GetTickets(this.userId);

  @override
  List<Object> get props => [userId];
}

// TODO: event mengambil
class BuyTicket extends TicketEvent {
  final String userId;
  final Ticket ticket;

  BuyTicket(this.userId, this.ticket);

  @override
  List<Object> get props => [userId, ticket];
}
