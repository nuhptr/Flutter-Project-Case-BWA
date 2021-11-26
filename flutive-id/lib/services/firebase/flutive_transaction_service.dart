import 'package:cloud_firestore/cloud_firestore.dart';

import '/model/flutive_transaction.dart';

class FlutiveTransactionService {
  static CollectionReference transactionCollection =
      Firestore.instance.collection("transaction");

  // TODO: Save Transaction
  static Future<void> saveTransaction(
      FlutiveTransaction flutiveTransaction) async {
    await transactionCollection.document().setData({
      "userId": flutiveTransaction.userId,
      "title": flutiveTransaction.title,
      "subtitle": flutiveTransaction.subtitle,
      "time": flutiveTransaction.time,
      "amount": flutiveTransaction.amount,
      "picture": flutiveTransaction.picture,
    });
  }

  // TODO: Get flutive transaction
  static Future<List<FlutiveTransaction>> getTransaction(String userId) async {
    var snapshot = await transactionCollection.getDocuments();
    var document = snapshot.documents.where(
      (document) => document.data["userId"] == userId,
    );

    return document
        .map((e) => FlutiveTransaction(
            userId: e.data["userId"],
            picture: e.data["picture"],
            amount: e.data["amount"],
            title: e.data["title"],
            subtitle: e.data["subtitle"],
            time: (e.data["time"] as Timestamp).toDate()))
        .toList();
  }
}
