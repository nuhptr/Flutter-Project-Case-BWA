import 'package:cloud_firestore/cloud_firestore.dart';

import '/model/ticket.dart';
import '/model/theater.dart';
import '/services/http/movie_services.dart';

class TicketServices {
  // TODO: Buat Collection
  static CollectionReference ticketCollection =
      Firestore.instance.collection("ticket");

  // TODO: Save ticket
  static Future<void> saveTicket(String id, Ticket ticket) async {
    await ticketCollection.document().setData({
      "movieId": ticket.movieDetail.id ?? "",
      "userId": id ?? "",
      "theaterName": ticket.theater.name ?? 0,
      "time": ticket.time.microsecondsSinceEpoch ??
          DateTime.now().microsecondsSinceEpoch,
      "bookingCode": ticket.bookingCode,
      "seats": ticket.seatsInString,
      "name": ticket.name,
      "totalPrice": ticket.totalPrice,
    });
  }

  // TODO: Get ticket
  static Future<List<Ticket>> getTickets(String userId) async {
    var snapshot = await ticketCollection.getDocuments();
    var documents = snapshot.documents.where(
      (document) => document.data["userId"] == userId,
    );

    List<Ticket> tickets = [];
    for (var document in documents) {
      var movieDetail = await MovieServices.getDetails(
        null,
        movieId: document.data["movieId"],
      );

      tickets.add(Ticket(
        movieDetail,
        Theater(document.data["theaterName"]),
        DateTime.fromMicrosecondsSinceEpoch(document.data["time"]),
        document.data["bookingCode"],
        document.data["seats"].toString().split(", "),
        document.data["name"],
        document.data["totalPrice"],
      ));
    }

    return tickets;
  }
}
