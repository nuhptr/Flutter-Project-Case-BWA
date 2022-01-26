import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:airplane/models/transaction_model.dart';

class TransactionService {
  final CollectionReference _transactionRef =
      FirebaseFirestore.instance.collection('transactions');

  Future<void> createTransaction(TransactionModel? transaction) async {
    try {
      _transactionRef.add({
        'destination': transaction?.destinationModel.toJson(),
        'amountOfTraveler': transaction?.amountOfTraveler,
        'selectedSeats': transaction?.selectedSeat,
        'insurance': transaction?.insurance,
        'refundable': transaction?.refundable,
        'vat': transaction?.vat,
        'price': transaction?.price,
        'grandTotal': transaction?.grandTotal,
      });
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<List<TransactionModel>> fetchTransaction() async {
    try {
      QuerySnapshot snapshot = await _transactionRef.get();

      List<TransactionModel> transactions = snapshot.docs.map((e) {
        return TransactionModel.fromJson(
          e.id,
          e.data() as Map<String, dynamic>,
        );
      }).toList();

      return transactions;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
